//
//  RecipeDetailView.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/10/21.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    @State var instructions = "Instructions"
    @ObservedObject private var viewModel = RecipeViewModel()

    
    var body: some View {
        VStack{
            Text(recipe.name ?? "")
            Text("Ingredients")
            Text(recipe.ingred ?? "")
            Text("Instructions")
            Text(recipe.instruc ?? "")
        }
    }
}
