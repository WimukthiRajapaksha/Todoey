//
//  Item.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/13/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    @objc dynamic var dateCreated:Date?
    var parentCategory=LinkingObjects(fromType: Category.self, property: "items") 
}
