//
//  ContentView.swift
//  Icebreaker-Pellicano-S24
//
//  Created by Frank Pellicano on 2/6/24.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let db = Firestore.firestore()
    
    @State var txtFirstName: String = ""
    @State var txtLastName: String = ""
    @State var txtPrefName: String = ""
    @State var txtAnswer: String = ""
    @State var txtQuestion: String = ""
    
    @State var questions = [Question]()
    
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
            
            
            Button(action: { 
                if(txtAnswer != "") {
                    writeStudentToFirebase()
                }
                resetTextFields()
                
            })
            {
                Text("Submit")
                    .font(.system(size: 28))
            }
            .padding(30)
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .autocorrectionDisabled(true)
        .padding()
        .onAppear(){
            getQuestionsFromFirebase()
        }
    }
    
    func setRandomQuestion(){
        print("Set random question pressed")
        var newQuestion = questions.randomElement()?.text
        if(newQuestion != nil){
            self.txtQuestion = newQuestion!
        }
    }
    
    func getQuestionsFromFirebase(){
        db.collection("questions")
            .getDocuments() {  (querySnapshot,err) in
                if let err = err { // if error is not nil
                    print("Error getting documents: \(err)")
                } else { // Get my question documents from Firebase
                    for document in querySnapshot!.documents {
                        print("\(document.documentID)")
                        if let question = Question(id: document.documentID, data: document.data()){
                            print("Question ID = \(question.id), text = \(question.text)")
                            
                            self.questions.append(question)
                        }
                    }
                }
                
            }
    }
    
    func resetTextFields(){
        txtFirstName = ""
        txtLastName = ""
        txtPrefName = ""
        txtAnswer = ""
        txtQuestion = ""
    }
    
    func writeStudentToFirebase(){
        print("Submit button pressed")
        print("First Name: \(txtFirstName)")
        print("Last Name: \(txtLastName)")
        print("Pref Name: \(txtPrefName)")
        print("Answer: \(txtAnswer)")
        print("Question: \(txtQuestion)")
        print("Class: ios-spring2024")
        
        let data = ["first_name" : txtFirstName,
                    "last_name" : txtLastName,
                    "pref_name" : txtPrefName,
                    "question"  : txtQuestion,
                    "answer"    : txtAnswer,
                    "class"     : "ios-spring2024"] as [String : Any]
        
        var ref: DocumentReference? = nil
        ref = db.collection("students")
            .addDocument(data: data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
}

#Preview {
    ContentView()
}
