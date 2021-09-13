//
//  SharedRecipeView.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/10/21.
//

import SwiftUI

struct SharedRecipeView: View {
    var user: String
    @ObservedObject private var viewModel = RecipeViewModel()

    
    var body: some View {
        //NavigationView {
            List(viewModel.recipes) { recipe in
                VStack(alignment: .leading) {
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name ?? "Default").font(.title)
                    }
                }
            }.onAppear() {
                self.viewModel.fetchSharedData(user: user)
            }
                .navigationBarTitle("Shared Recipes")
        //}
    }
}
