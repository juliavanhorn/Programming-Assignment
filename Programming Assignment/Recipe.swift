//
//  Contact.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import Foundation
import SwiftUI
struct Recipe: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String?
    var user: String?
    var instruc: String?
    var ingred: String?
    init() {
        self.id = UUID().uuidString
        self.name = ""
        self.user = ""
        self.instruc = ""
        self.ingred = ""
    }
}
