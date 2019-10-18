//
//  CategoryRepository.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/12.
//  Copyright © 2019 2017YD. All rights reserved.
//
import CoreData
import Foundation


class CategoryRepository {

    var app : AppDelegate
    var context : NSManagedObjectContext
    
    init ( _ app : AppDelegate){
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func insert(bc: BookCategory){
        let description = NSEntityDescription.entity(forEntityName: BookCategory.entityName, in: context)
        let book = NSManagedObject(entity: description!, insertInto:context)
        book.setValue(bc.id, forKey: BookCategory.colId)
        book.setValue(bc.name, forKey: BookCategory.colName)
        book.setValue(bc.image, forKey: BookCategory.colImage)

        app.saveContetext()
    }
    
    
    func isExists(name: String) throws -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: BookCategory.entityName)
        fetch.predicate = NSPredicate(format: "\(BookCategory.colName) = %@", name)
        do {
            let result = try context.fetch(fetch) as! [BookCategory]
            return result.count > 0
        }catch {
            throw DateError.entityExistsError("数据失败")
        }
    }
    ///获取表格数据
    func get() throws -> [BookCategory] {
        var categorys = [BookCategory]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: BookCategory.entityName)

        do {
            let result = try context.fetch(fetch) as! [Category]
            for item in result {
                let bc = BookCategory()
                bc.id = item.id!
                bc.name = item.name
                bc.image = item.image
                categorys.append(bc)
            }
            
        } catch {
            throw DateError.readCollectionError("读取数据失败！")
        }
        
        return categorys
    }
   
    
    
    ///删除数据
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: BookCategory.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        let result = try context.fetch(fetch) as! [Category]
        for m in result {
            context.delete(m)
        }
        app.saveContetext()
    }
}
