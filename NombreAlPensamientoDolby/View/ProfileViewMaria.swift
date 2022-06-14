//
//  ProfileViewMaria.swift
//  NombreAlPensamientoDolby
//
//  Created by Angelik Laboy on 11/06/2022.
//
//  Profile & Background Card for Candidate 1

import SwiftUI

struct ProfileViewMaria: View {
    @State var show = false
    
    var body: some View{
        ZStack{
            //Background Card with Maria's information along with the exit button
            //* Note: In the future, this information can be pulled from the website or from a professional site like Linkedin where their information is constantly updated.
            VStack{
                Image("MariaBackground")
                    .offset(x: show ? -5: 0, y:10) //For design purposes, the card is a bit twist to make it visable for the user
                    .shadow(color: .gray, radius: 40, x:0, y:20)
                    //Animation effect to straighten the horizon of the Background card
                    .rotation3DEffect(Angle(degrees: show ? 0 :10), axis: (x:0, y:10, z:0))
                    .animation(.spring(response:0.6,dampingFraction:0.6,blendDuration: 0), value: 0.1)
                Image("Cancel Icon")
                   .resizable() //Allows for the manipulation of the image icon
                   .aspectRatio(contentMode:.fit)
                   .frame(width:30,height:30)
                   .offset(x:112,y:-435)
                   .onTapGesture {
                       self.show.toggle() //Returns us to the Profile card view
                   }
            }
            ZStack{
                //Displays profile picture
                Image("MariaProfile")
                    //Building the Card's shape
                    .frame(width:307,height:410)
                    .shadow(color: .gray, radius: 5, x:0, y:5)
                    .cornerRadius(24)
                VStack{
                    //Profile Card containing Maria's name and information icon
                    //* Note: In the future, the candidates would be produced from a single CandidateView as the information would be pulled from a database with multiple instances.
                    Text("Maria Zarvago")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(40)
                        .padding(.top)
                        .offset(x:-60,y:-160)
                    Image("Information Icon")
                       .resizable() //Allows for the manipulation of the image icon
                       .aspectRatio(contentMode:.fit)
                       .frame(width:30,height:30)
                       .offset(x:120,y:-240)
                       .onTapGesture {
                           self.show.toggle() //Brings forth the Background card
                   }
                }
            }
            //Animation effect as the information is revealed where the top card moves to the side
            .offset(x: show ? -330: 0, y:-17)
            .animation(.spring(response:0.6, dampingFraction: 0.6, blendDuration: 0), value: 1.5)
            .rotationEffect(Angle(degrees:show ? 5 : 0))
        }
    }
}
