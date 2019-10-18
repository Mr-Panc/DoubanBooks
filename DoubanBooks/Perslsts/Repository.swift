//
//  Repository.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/16.
//  Copyright © 2019 2017YD. All rights reserved.
//

import CoreData
import Foundation
class Repository<T: DateViewModelDelegate> where T:NSObject{
    var app: AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate) {
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func insert(vw: T){
        let description = NSEntityDescription.entity(forEntityName: T.entityName, in: context)
        let obj = NSManagedObject(entity: description!,insertInto:context)
        for (key, value) in vw.entityPairs() {
            obj.setValue(value, forKey: key)
        }
        app.saveContetext()
    }
    
    func isEntityExists(_ cols: [String], keyword: String)throws -> Bool {
        var fromat = ""
        var args = [String]()
        for col in cols {
            fromat += "\(col) = %@ || "
            args.append(keyword)
        }
        fromat.removeLast(3)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: fromat, argumentArray: args)
        do {
            let result = try context.fetch(fetch)
            return result.count > 0
        } catch {
            throw DateError.readCollectionError("数据失败")
        }
    }
    ///从本地数据库读取某一实体类全部数据
    ///
    /// -returns： 视图模型对象集合
    func get() throws -> [T] {
        var items = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        do {
            let result = try context.fetch(fetch)
            for c in result {
                let t = T()
                t.packageSelf(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        }catch {
            throw DateError.readCollectionError("读取集合数据失败")
        }
    }
    
    /// 根据x关键词查询某一实体符合条件的数据，模糊查询
    ///
    /// - parametercols：要匹配的例如：【“name”，“publisher”
    /// - parameterkeyword：要搜索的关键词
    /// - returns：视图模型对象集合
    func getBy(_ cols: [String], keyword: String) throws -> [T] {
        var format = ""
        var args = [String]()
        for col in cols {
            format += "\(col) like[c] %@ ||"
            args.append("*\(keyword)*")
        }
        format.removeLast(3)
        var items = [T]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: format, argumentArray: args)
        do {
            let result = try context.fetch(fetch)
            for c in result {
                let t = T()
                t.packageSelf(result: c as! NSFetchRequestResult)
                items.append(t)
            }
            return items
        }catch {
            throw DateError.readCollectionError("查询数据失败")
        }
    }
    
    func update(vw: T) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", vw.id.uuidString)
        do {
            let obj = try context.fetch(fetch)[0] as! NSManagedObject
            for(key,value) in vw.entityPairs() {
                obj.setValue(value, forKey: key)
            }
            app.saveContetext()
        }catch {
            throw DateError.updateEntityError("更新数据失败")
        }
    }
   
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        do {
            let obj = try context.fetch(fetch)[0]
            context.delete(obj as! NSManagedObject)
            app.saveContetext()
        }catch {
            throw DateError.deleteEntityError("删除图书失败")
        }
        
    }
}
