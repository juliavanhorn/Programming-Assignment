//
//  ContactViewModel.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import Foundation
import FirebaseFirestore

class RecipeViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    private var db = Firestore.firestore()
    
    func fetchData(user: String) {
        self.recipes = []
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            for doc in documents {
                let data = doc.data()
                let fetchedUser = data["user"] as? String ?? ""
                var recipe = Recipe()
                if(fetchedUser == user){
                    let name = data["name"] as? String ?? ""
                    let ingred = data["ingred"] as? String ?? ""
                    let instruc = data["instruc"] as? String ?? ""

                    recipe.name = name
                    recipe.ingred = ingred
                    recipe.instruc = instruc
                    
                    self.recipes.append(recipe)
                }
            }
        }
    }
    func fetchSharedData(user: String) {
        self.recipes = []
        db.collection("recipes").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            for doc in documents {
                let data = doc.data()
                let fetchedUser = data["sharedTo"] as? String ?? ""
                var recipe = Recipe()
                if(fetchedUser == user){
                    let name = data["name"] as? String ?? ""
                    let ingred = data["ingred"] as? String ?? ""
                    let instruc = data["instruc"] as? String ?? ""

                    recipe.name = name
                    recipe.ingred = ingred
                    recipe.instruc = instruc
                    
                    self.recipes.append(recipe)
                }
            }
        }
    }
    func addData(name: String, user: String, ingred: String, instruc: String, sharedTo: String) {
        do {
            _ = try db.collection("recipes").addDocument(data: ["name": name, "user": user, "instruc": instruc, "ingred": ingred, "sharedTo": sharedTo])
        }
        catch {
            print("cant add new item")
            print(error.localizedDescription)
        }
    }
}
