# Python Script with Twitter API which auto follows and delivers a DM to the person wanting to connect

from enum import Enum
import sys
import json
from requests_oauthlib import OAuth1Session


# Client Credentials to access the Twitter API
# *Note: In the future this will be stored in environment to avoid plain text secrets.
consumerKey = "ZmM6kmrxiN8TGvAfRqyEhcbIk"
consumerSecret = "7DlMCWpYfT6yZDe3GchXlHdDq0r7zLacx5hevqt4SycjD8JyO4"
accessToken = "1534950273852088321-l62MMYw7dSQo1uk03PRbGqo4lhTkQj"
accessTokenSecret = "uIucj9KgML4vTaObwJP2jsJn58FhIpdeZIRBXoUWIW0ZJ"


def main():
    # Authorize session using oauth
    oauth = authorizeSession(consumerKey, consumerSecret, accessToken, accessTokenSecret)

    # Make request to follow recruiter from authorized user account
    # * Note: User id of dummy recruiter twitter account - In the future this will be stored and assigned based on logged in profile.
    userFollowResponse = requestUserFollow("1534964816841953286", oauth)

    # Make request to message recruiter using preset message provided by user from authorized user account
    # * Note: Recipient id of dummy recruiter twitter account - In the future this will assigned based on message sender. Message will also be preset and saved to authorized user profile.
    userDirectMessageResponse = requestUserDirectMessage("1534964816841953286", "Hi my name is Mariana Velasquez and I am so honored you would like to connect! A bit about me, well I study Computer Science at Emory University where I am currently in my last year. So far with my experiences within the field, I have developed a love for global development and human-centered design. After school, I am looking for SWE experiences to better my learned skills in a practical environment. Excited to talk further!", oauth)

# Gives access to authorize the access tokens and keys
def authorizeSession(consumerKey, consumerSecret, accessToken, accessTokenSecret):
    requestTokenUrl = "https://api.twitter.com/oauth/request_token"
    
    # Obtain authorization from resource owner to access the proctected resources
    oauth = OAuth1Session(consumerKey, client_secret=consumerSecret)

    # Verify if the request token is working
    try:
        fetchResponse = oauth.fetch_request_token(requestTokenUrl) # Obtain a request token
    except ValueError: #Report an error when verifying
        print("There may be an issue with the consumer key or consumer secret provided.")
        
    # Access protected resources
    oauth = OAuth1Session(
        consumerKey,
        client_secret=consumerSecret,
        resource_owner_key=accessToken,
        resource_owner_secret=accessTokenSecret,
    )
    return oauth # Return the accessed resources

# Creates a request to the Twitter API and verify if it went through
def make_request(resource_url, requestType, oauth, payload=None):
    if requestType == SupportedRequestTypes.POST: #If the request is HTTP POST, cause a change to resource's URL
        response = oauth.post(resource_url, json=payload)
    elif requestType == SupportedRequestTypes.GET: #If the request is HTTP GET, receive or view the resource's URL
        response = oauth.get(resource_url)
    else:
        raise Exception(
            "Provided request type is not supported or not valid."
        )

    if response.status_code != 200: # If the status code is not 200, then return back the number of the error
        raise Exception(
            "Request returned an error: {} {}".format(response.status_code, response.text)
        )
    print("Response code: {}".format(response.status_code)) #Otherwise it should go through and produce a status code of 200

    # Save the response as JSON and return
    return json.dumps(response.json(), indent=4, sort_keys=True)

# Function to allow authorized user to follow given user id. Oauth session must be provided.
def requestUserFollow(userId, oauth):
    resourceUrl = "https://api.twitter.com/1.1/friendships/create.json?user_id={}&follow=true".format(userId)
    return make_request(resourceUrl, SupportedRequestTypes.POST, oauth)

# Function to allow authorized user to direct message given user id. Oauth session must be provided.
def requestUserDirectMessage(recipientId, message, oauth):
    payload = {"event": {"type": "message_create", "message_create": {"target": {"recipient_id": recipientId}, "message_data": {"text": message}}}}
    return make_request("https://api.twitter.com/1.1/direct_messages/events/new.json", SupportedRequestTypes.POST, oauth, payload)


class SupportedRequestTypes(Enum):
    POST = 1
    GET = 2


if __name__ == '__main__':
    main()
