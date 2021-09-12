//
//  NewRecipeView.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/10/21.
//

import SwiftUI

struct NewRecipeView: View {
    var user: String
    @State private var name: String = ""
    @State private var instruc: String = ""
    @State private var ingred: String = ""
    @State private var sharedTo: String = ""

    @State var email = ""
    @ObservedObject private var viewModel = RecipeViewModel()

    
    var body: some View {
        NavigationView{
            VStack{
                Text("New Recipe")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Recipe Name", text: $name)
                Text("Ingredients")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextEditor(text: $ingred)
                Text("Instructions")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextEditor(text: $instruc)
                Text("Share")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Enter user's email to share recipe", text: $sharedTo)
                Button(action: {
                    viewModel.addData(name: name, user: user, ingred: ingred, instruc: instruc, sharedTo: sharedTo)
                }) {
                    Text("Save")
                }
            }
        }
    }
}
