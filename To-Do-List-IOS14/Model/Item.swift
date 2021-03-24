//
//  Item.swift
//  To-Do-List-IOS14
//
//  Created by 程式猿 on 2021/3/24.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
