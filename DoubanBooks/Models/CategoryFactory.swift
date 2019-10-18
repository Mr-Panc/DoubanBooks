//
//  CategoryFactory.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/14.
//  Copyright © 2019 2017YD. All rights reserved.
//

import CoreData
import Foundation

final class CategoryFactory {
      var app: AppDelegate?
    var repository: Repository<BookCategory>
    
    static var instance: CategoryRepository?
    
    //    init(_ app: AppDelegate) {
    //        repository = CategoryRepository(app)
    //    }
    private init(_ app: AppDelegate) {
        repository = Repository<BookCategory>(app)
    }
    static func getInstance(_ app: AppDelegate) -> CategoryRepository {
        if let obj = instance {
            return obj
        }else {
//            let token = "net.lzzy.factory.category"
             let token = "net.lzzy.factory.category"
            DispatchQueue.once(token: token, block: {
                if instance == nil {
                    instance = CategoryRepository(app)
                }
            })
            return instance!
        }
        
    }
    
    
    func getAllCategoryies() throws -> [BookCategory] {
        return try repository.get()
    }
    
    func addCategory(category: BookCategory) -> (Bool,String?) {
        do {
            if try repository.isEntityExists([BookCategory.colName], keyword: category.name!) {
                return (false, "同样的类别已存在")
            }
            repository.insert(vw: category)
            return (true,nil)
        }catch DateError.entityExistsError(let info) {
            return (false, info)
        }catch {
            return (false, error.localizedDescription)
        }
    }
//    func getBookOf(category id: UUID) throws -> [VWBook] {
//        return try repository.getBy([VWBook.colCategoryId], keyword: id.uuidString)
//    }
//
//    func getBooksCountOfCategory(category id: UUID) -> Int? {
//        do {
//            return try CategoryFactory.getInstance(app!).get
//        }
//    }
//
//    func remove(category: BookCategory) -> (Bool, String?) {
//        if let count = getBooksC
//    }
    
}

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
            
        }
        _onceTracker.append(token)
        block()
        
    }
    
}
