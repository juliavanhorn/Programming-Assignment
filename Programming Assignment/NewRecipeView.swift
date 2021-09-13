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
        ScrollView{
            //ZStack{
                //Color(red:219,green:219,blue:219)
            VStack{
                TextField("Recipe Name", text: $name)
                    .font(.title2)
                    //.padding()
                Text("Ingredients")
                    .font(.title3)
                TextEditor(text: $ingred)
                    .frame(height:200)
                Text("Instructions")
                    .font(.title3)
                TextEditor(text: $instruc)
                    .frame(height:200)
                Text("Share")
                    .font(.title3)
                TextField("Enter user's email to share recipe", text: $sharedTo)
                Button(action: {
                    viewModel.addData(name: name, user: user, ingred: ingred, instruc: instruc, sharedTo: sharedTo)
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("New Recipe")
            .padding()
            //}
        }
    }
}
