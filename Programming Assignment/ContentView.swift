//
//  ContentView.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var name: String = ""
    @State var loggedIn: Bool = false
    @State var email = ""
    @State var password = ""
    @State var errorMessage = " \n "
    @ObservedObject private var viewModel = ContactViewModel()


    var body: some View {
        if(loggedIn){
            NavigationView {
                List(viewModel.contacts) { contact in
                    VStack(alignment: .leading) {
                        Text(contact.name ?? "Default").font(.title)
                    }
                }.onAppear() {
                    self.viewModel.fetchData()
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Text("Navigation Bar")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            TextField("Enter your name", text: $name)
                                .frame(minWidth: 100, idealWidth: 150, maxWidth: 240, minHeight: 30, idealHeight: 40, maxHeight: 50, alignment: .leading)
                            Spacer()
                            Button(action: {
                                self.viewModel.addData(name: name)

                            }) {
                                Image(systemName: "plus")
                                    //.font(.title)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(20)
                            //Spacer()
                        }
                    }
                    
                }
            }
        }else{
            VStack {
                Text("Programming Assignment App")
                Spacer()
                TextField("Email", text: $email)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                HStack{
                    Spacer()
                    Button(action: { login() }) {
                        Text("Sign in")
                    }
                    Spacer()
                    Button(action: { signup() }) {
                        Text("Create Account")
                    }
                    Spacer()
                }
                Spacer()
                Text(errorMessage)
                Spacer()
            }
            .padding()
        }
    }
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                errorMessage = error?.localizedDescription ?? ""
            } else {
                loggedIn = true
            }
        }
    }
    func login() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    errorMessage = error?.localizedDescription ?? ""
                } else {
                    loggedIn = true
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
