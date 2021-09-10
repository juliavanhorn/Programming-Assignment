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
        db.collection("contacts").addSnapshotListener { (querySnapshot, error) in
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
                    recipe.name = name
                    self.recipes.append(recipe)
                }
            }
        }
    }
    func addData(name: String, user: String) {
           do {
            _ = try db.collection("contacts").addDocument(data: ["name": name, "user": user])
           }
           catch {
                print("cant add new item")
                print(error.localizedDescription)
           }
       }
}
