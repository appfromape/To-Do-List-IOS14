//
//  Item.swift
//  To-Do-List-IOS14
//
//  Created by 程式猿 on 2021/3/23.
//

import Foundation

class Item:Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
