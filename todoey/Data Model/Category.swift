//
//  Category.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/13/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String=""
    let items=List<Item>()
}
