//
//  VWBook.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/15.
//  Copyright © 2019 2017YD. All rights reserved.
//

import Foundation
import CoreData

class VWBook:NSObject,DateViewModelDelegate {
    
    var author: String?
    var autorintor: String?
    var categoryId: UUID?
    var id: UUID
    var image: String?
    var isbn10: String?
    var isbn13: String?
    var page: Int32?
    var price: Float?
    var pubdate: String?
    var publisher: String?
    var summary: String?
    var title: String?
    var binding: String?
    
    override init() {
        id = UUID()
    }
    static let entityName = "Book"
    static let colId = "id"
    static let colAuthor = "author"
    static let colAutorintor = "autorintor"
    static let colCategoryId = "categoryId"
    static let colImage = "image"
    static let colIsbn10 = "isbn10"
    static let colIsbn13 = "isbn13"
    static let colPage = "page"
    static let colPrice = "price"
    static let colPubdate = "pubdate"
    static let colPublisher = "publisher"
    static let colSummary = "summary"
    static let colTitle = "title"
    static let colBinding = "binding"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dic: Dictionary<String, Any?> = Dictionary<String, Any?>()
        dic[VWBook.colId] = id
        dic[VWBook.colAuthor] = author
        dic[VWBook.colAutorintor] = autorintor
        dic[VWBook.colCategoryId] = categoryId
        dic[VWBook.colImage] = image
        dic[VWBook.colIsbn10] = isbn10
        dic[VWBook.colIsbn13] = isbn13
        dic[VWBook.colPage] = page
        dic[VWBook.colPrice] = price
        dic[VWBook.colPubdate] = pubdate
        dic[VWBook.colPublisher] = publisher
        dic[VWBook.colSummary] = summary
        dic[VWBook.colTitle] = title
        dic[VWBook.colBinding] = binding
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let book = result as! Book
        id = book.id!
        author = book.author
        autorintor = book.autorintor
        categoryId = book.categoryId
        image = book.image
        isbn10 = book.isbn10
        isbn13 = book.isbn13
        page = book.page
        price = book.price
        pubdate = book.pubdate
        publisher = book.publisher
        summary = book.summary
        title = book.title
        binding = book.binding
    }
    
}
