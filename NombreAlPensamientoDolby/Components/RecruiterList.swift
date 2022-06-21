//
//  RecruiterList.swift
//  NombreAlPensamientoDolby
//
//  Created by Angelik Laboy on 11/06/2022.
//
// Candidate's notification center
// After the recruiter likes a candidate, the candidate will receive a notification on their end asking whether they would like to accept this engagement.

import SwiftUI

struct RecruiterList: View {
   @State var showResult: Bool = false
   @State var show = false
   var body: some View {
       VStack{
           Text("Recruiter Invitation")
               .font(.title)
               .fontWeight(.bold)
               .padding(.top)
           exitButton() //Apple's closing buttons which will take us back to the home page
           
           //Reproduces a list of companies interested in contacting the candidate.
          List(updateData){ item in //loop over the company's example data
             HStack{
                 Image(item.image) //Company's logo icon
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 35, height: 35)
                     .background(Color("background"))
                     .cornerRadius(20)
                 
                 Text(item.title) //Text notification of recruiter wanting to connect
                 .font(.system(size:20))
                 .fontWeight(.light)
                 
                 Button(action: {
                     twitterViewLoad() //This action will activate the candidates' Twitter account to follow the recruiter as well as direct message them with an introduction

                     showResult.toggle()
                 }){
                     Text("Accept")
                 }
                 .background(.blue)
                 .cornerRadius(20)
             
                 //Candidate has the option to decline but for this instance this button has no effect
                 Button(action: {self.show.toggle()}){
                     Text("Decline")
                 }
                 .background(.white)
                 .foregroundColor(.black)
                 .cornerRadius(20)
             }
          }
      }.frame(width:550,height:300) //Sizes the appearing screen to be a rectangle
   }
}

struct RecruiterList_Previews: PreviewProvider {
   static var previews: some View {
       RecruiterList()
   }
}

//Structure of buttons imitating the Apple's closing icons
struct exitButton: View{
    @State var showUpdate = false
    var body: some View{
        return HStack{
            Button(action: {showUpdate.toggle()}) { //Red Button
                }
                .sheet(isPresented: self.$showUpdate){ ContentView() //This is the only button that would take us back into the Home Page
                }
                .foregroundColor(.white)
                .frame(width:12,height:12)
                .background(.red)
                .cornerRadius(1000)
                .offset(x:-240,y:-45)
            
            Button(action: {showUpdate.toggle()}) { //Yellow button
                }
                .foregroundColor(.white)
                .frame(width:12,height:12)
                .background(.yellow)
                .cornerRadius(1000)
                .offset(x:-238,y:-45)
            
            Button(action: {showUpdate.toggle()}) { //Green button
                }
                .foregroundColor(.white)
                .frame(width:12,height:12)
                .background(.green)
                .cornerRadius(1000)
                .offset(x:-236,y:-45)
        }
    }
    
}

//Item keys for the list of notifications
struct Update: Identifiable {
   var id = UUID()
   var image: String
   var title: String
}

//The notification's example information
let updateData = [
   Update(image: "DolbyIcon", title: "Dolby wants to connect with you."),
   Update(image: "GoogleIcon", title: "Google wants to connect with you."),
   Update(image: "TeslaIcon", title: "Tesla wants to know more of you.")
]

