//
//  ItemRealm.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 05.09.2022.
//

import Foundation
import RealmSwift

class ItemRealm: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    // Relationship
                                    // parent category               // property
    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "items")
    
}
