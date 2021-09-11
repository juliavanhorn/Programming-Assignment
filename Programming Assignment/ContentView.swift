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
    @State var loggedIn: Bool = true
    @State var email = ""
    @State var password = ""
    @State var errorMessage = " \n "
    @ObservedObject private var viewModel = RecipeViewModel()


    var body: some View {
        if(loggedIn){
            NavigationView {
                List(viewModel.recipes) { recipe in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            Text(recipe.name ?? "Default").font(.title)
                        }
                    }
                }.onAppear() {
                    self.viewModel.fetchData(user: email)
                }
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewRecipeView(user: email)) {
                            Label("+", systemImage: "plus")
                        }
                        
                    }
                    ToolbarItem(placement: .bottomBar){
                        HStack{
                            Button(action: { logout() }) {
                                Text("Log out")
                            }
                            NavigationLink(destination: RecipeSearchView()) {
                                Label("Search", systemImage: "magnifyingglass")
                            }
                            NavigationLink(destination: SharedRecipeView(user: email)) {
                                Label("Shared", systemImage: "person.2.fill")
                            }
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

    func logout() {
        do {
         try Auth.auth().signOut()
            loggedIn = false
        } catch {
            print("unable to logout")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
