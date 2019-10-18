//
//  BookCategory.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/12.
//  Copyright © 2019 2017YD. All rights reserved.
//

import Foundation
import CoreData

class BookCategory:NSObject,DateViewModelDelegate {
    var id: UUID
    var name:String?
    var image: String?
    
    override init() {
        id = UUID()
    }
    static let entityName = "Category"
    static let colId = "id"
    static let colName = "name"
    static let colImage = "image"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dic: Dictionary<String, Any?> = Dictionary<String, Any?>()
        dic[BookCategory.colId] = id
        dic[BookCategory.colName] = name
        dic[BookCategory.colImage] = image
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let category = result as! Category
        id = category.id!
        name = category.name
        image = category.image
    }
}
