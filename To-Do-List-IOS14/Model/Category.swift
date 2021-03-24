//
//  Category.swift
//  To-Do-List-IOS14
//
//  Created by 程式猿 on 2021/3/24.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
//    let array = Array<Int>()
}
