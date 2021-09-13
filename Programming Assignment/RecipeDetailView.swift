//
//  RecipeDetailView.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/10/21.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    @ObservedObject private var viewModel = RecipeViewModel()

    
    var body: some View {
        VStack{
            HStack{
                Text(recipe.name ?? "")
                    .font(.title)
                Spacer()
            }
            Spacer()
            HStack{
                Text("Ingredients")
                    .font(.title2)
                Spacer()
            }
            HStack{
                Text(recipe.ingred ?? "")
                Spacer()
            }
            Spacer()
            HStack{
                Text("Instructions")
                    .font(.title2)
                Spacer()
            }
            HStack{
                Text(recipe.instruc ?? "")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
