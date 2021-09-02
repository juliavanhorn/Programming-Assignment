//
//  Programming_AssignmentApp.swift
//  Programming Assignment
//
//  Created by zach siwik on 9/2/21.
//

import SwiftUI

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
