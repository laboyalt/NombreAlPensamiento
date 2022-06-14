//
//  ContentView.swift
//  NombreAlPensamientoDolby
//
//  Created by Angelik Laboy on 11/06/2022.
//
//  Home Page of the application

import SwiftUI
import AVFoundation
import AVKit

struct ContentView: View {
    @State var show = false
    @State var showProfile = false
    var body: some View {
        ScrollView{
            ZStack{
                TitleView()
                UserIcon(show: $showProfile)
                    .offset(x:137,y:10)
            }

            VStack(spacing:-50){ // *Note: The default spacing wasn't leaving a lot of space between the Profile Cards
               ProfileViewMaria()
               ProfileViewBenjamin()
               ProfileViewAna()
            }
        }
        //Styling qualities of the environment app
        .background(.white)
        .frame(width:370, height:600)
        .cornerRadius(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Writes the app's discovery section title
struct TitleView: View {
    @State var show = false
    var body: some View{
        //Placed it outside to allows no constrains with the extending text
        Text("Discover el Talento Puro 🔥")
            .fontWeight(.bold)
            .foregroundColor(.black)
            .font(.system(size:20))
            .offset(x:-35,y:30)
        VStack(alignment: .leading){
            Text("Nombre Al Pensamiento")
                .foregroundColor(.gray)
                .font(.system(size:14))
            Spacer() //Allows the text to stay on the header
        }
        //Specific location for the text
        .padding(.trailing,170)
        .padding(.top, 30)
    }
}

//Actionable button with User's Photo
struct UserIcon: View {
    @Binding var show: Bool
    @State var showUpdate = false
    var body: some View{
        return
            //Notification button - User's perspective
            // * Note: This view is only for User's but as the system continues to grow this would be a messaging center between Candidates as well as a setting space for Recruiters
            Button(action: {self.showUpdate.toggle()}) {
                Image("UserProfile")
                    .padding()
                    .offset(y:18)
                    .foregroundColor(.white)
                    .sheet(isPresented: self.$showUpdate){ RecruiterList() // Pulls up the notification view with all of the example recruiters' interest
                }
        }
        //Styling qualities of the button
        .frame(width:35, height:35)
        .background(.black)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 11, x: -4, y: 5)
    }
}

