//
//  ContentView.swift
//  Icebreaker-Pellicano-S24
//
//  Created by Frank Pellicano on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var txtFirstName: String = ""
    @State var txtLastName: String = ""
    @State var txtPrefName: String = ""
    @State var txtAnswer: String = ""
    @State var txtQuestion: String = ""
    
    var body: some View {
        
        VStack {
            Text("Icebreaker")
                .font(.system(size: 40))
                .bold()
            Text("Built with SwiftUI")
            
            TextField("First Name", text: $txtFirstName)
            
            TextField("Last Name", text: $txtLastName)
            
            TextField("Preferred Name", text: $txtPrefName)
            
            Button(action: { setRandomQuestion()
            }){
                Text("Get a new random question")
                    .font(.system(size: 28))
            }
            Text(txtQuestion)
            
            TextField("Answer", text: $txtAnswer)
            
            
            Button(action: { writeStudentToFirebase()
            }){
                Text("Submit")
                    .font(.system(size: 28))
            }
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .padding()
    }
    
    func setRandomQuestion(){
        print("Set random question pressed")
    }
    
    func writeStudentToFirebase(){
        print("Submit button pressed")
        print("First Name: \(txtFirstName)")
        print("Last Name: \(txtLastName)")
        print("Pref Name: \(txtPrefName)")
        print("Answer: \(txtAnswer)")
    }
}

#Preview {
    ContentView()
}
