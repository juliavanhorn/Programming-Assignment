//
//  ContentView.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import SwiftUI
import Firebase
import UserNotifications


struct ContentView: View {
    @State private var name: String = ""
    @State var loggedIn: Bool = false
    @State var email = ""
    @State var password = ""
    @State var errorMessage = " \n "

    @ObservedObject private var viewModel = RecipeViewModel()


    var body: some View {
        if(loggedIn){
            NavigationView {
                //List(viewModel.recipes) { recipe in
                List {
                    ForEach(viewModel.recipes) { recipe in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                Text(recipe.name ?? "Default").font(.title)
                            }
                        }
                    }
                }.onAppear() {
                    self.viewModel.fetchData(user: email)
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                            let content = UNMutableNotificationContent()
                            content.title = "Recipe of the Day"
                            content.subtitle = "Click to View"
                            content.sound = UNNotificationSound.default
                            var dateComponents = DateComponents()
                            dateComponents.hour = 9
                            dateComponents.minute = 0
                            //set hour and minute to test notifications
                            //currently set to notify at 9:00AM every day
                            
                            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                }
                
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .bottomBar){
                        HStack{
                            Button(action: { logout() }) {
                                Text("Log out")
                            }
                            .offset(x:-50)
                            NavigationLink(destination: SharedRecipeView(user: email)) {
                                Label("Shared", systemImage: "person.2.fill")
                            }
                            NavigationLink(destination: RecipeSearchView()) {
                                Label("Search", systemImage: "magnifyingglass")
                            }
                            .offset(x:50)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewRecipeView(user: email)) {
                            Label("New Recipe", systemImage: "plus")
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
