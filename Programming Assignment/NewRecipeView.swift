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
        VStack{
            Text("New Recipe")
            TextField("Recipe Name", text: $name)
            Text("Ingredients")
            TextEditor(text: $ingred)
            Text("Instructions")
            TextEditor(text: $instruc)
            TextField("Share to: (Enter user's email)", text: $sharedTo)
            Button(action: { viewModel.addData(name: name, user: user, ingred: ingred, instruc: instruc, sharedTo: sharedTo) }) {
                Text("Save")
            }
        }
    }
}
