//
//  Category.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 05.09.2022.
//

import Foundation
import RealmSwift

class CategoryRealm: Object {
    
    @objc dynamic var name: String = ""
    // Relationship
    // creating a list (like array) of type ItemRealm
    let items = List<ItemRealm>()
}
