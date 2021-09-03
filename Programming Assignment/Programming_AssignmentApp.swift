//
//  Programming_AssignmentApp.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import SwiftUI
import Firebase

@main
struct Programming_AssignmentApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
