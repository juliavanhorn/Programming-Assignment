//
//  RecipeSearchView.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/10/21.
//

import SwiftUI

struct RecipeSearchView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                webRequest()
            }
    }
    func webRequest() {
        let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=pancake&app_id=646943bf&app_key=%20233dc39ee6897f7089e3c76782fbcec2&field=label&field=ingredients")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                //let recipeList: Recipes = try! JSONDecoder().decode(Recipes.self, from: data)
                //print(recipeList)
                
                
                /*if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                    print("SPACER")
                    
                    
                    
                }*/
                print("requested")
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
            
            
            
            /*do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                    // try to read out a string array
                    print("going")
                    print(json)
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }*/
        }
        task.resume()
        
    }
}

struct Root: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipes: Decodable {
    let name: String
    let image: URL
    let ingredientList: [String]
    let seeMoreUrl: URL

    enum CodingKeys: String, CodingKey {
        case name = "label"
        case image
        case ingredientList = "ingredientLines"
        case seeMoreUrl = "url"
    }
}


struct RecipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView()
    }
}
