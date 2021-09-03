//
//  Contact.swift
//  Programming Assignment
//
//  Created by julia van horn on 9/2/21.
//

import Foundation
import SwiftUI
struct Contact: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String?
}
