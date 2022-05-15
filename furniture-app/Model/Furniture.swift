//
//  Furniture.swift
//  furniture-app
//
//  Created by Clarence on 15/05/22.
//

import SwiftUI

// Model..
struct Furniture: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var price: String
    var image: String
}
