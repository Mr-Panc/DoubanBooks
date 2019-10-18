//
//  BookRepository.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/15.
//  Copyright © 2019 2017YD. All rights reserved.
//

import Foundation
import CoreData

class BookRepository<T> {
    var app : AppDelegate
    var context : NSManagedObjectContext
    
    init ( _ app : AppDelegate){
        self.app = app
        context = app.persistentContainer.viewContext
    }
    
    func insert(bc: VWBook){
        let description = NSEntityDescription.entity(forEntityName: VWBook.entityName, in: context)
        let book = NSManagedObject(entity: description!, insertInto:context)
        book.setValue(bc.id, forKey: VWBook.colId)
        book.setValue(bc.author, forKey: VWBook.colAuthor)
        book.setValue(bc.image, forKey: VWBook.colImage)
        
        app.saveContetext()
    }
    
    func isExists(_ isbn:String)throws-> Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VWBook.entityName)
        fetch.predicate = NSPredicate(format: "\(VWBook.colIsbn10) = %@ || \(VWBook.colIsbn13) = %@",isbn,isbn)
        do {
            let result = try context.fetch(fetch) as! [VWBook]
            return result.count > 0
        } catch {
            throw DateError.entityExistsError("判断数据失败")
        }
    }
    
    func getBy(keyword format: String, args:[Any]) throws -> [VWBook] {
        var books = [VWBook]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VWBook.entityName)
        fetch.predicate = NSPredicate(format:format, argumentArray: args)
        do {
            let result = try context.fetch(fetch) as! [VWBook]
            for b in result {
                let vw = VWBook()
                vw.id = b.id
                vw.author = b.author
                vw.image = b.image
                
                books.append(vw)
            }
            return books
        }catch {
            throw DateError.readCollectionError("读取复合数据失败")
        }
    }
    
    func update(vw: VWBook) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VWBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %&", vw.id.uuidString)
        do  {
            let obj = try context.fetch(fetch)[0] as! NSManagedObject
            obj.setValue(vw.author, forKey: VWBook.colAuthor)
            obj.setValue(vw.autorintor, forKey: VWBook.colAutorintor)
            obj.setValue(vw.categoryId, forKey: VWBook.colCategoryId)
            obj.setValue(vw.isbn10, forKey: VWBook.colIsbn10)
            obj.setValue(vw.isbn13, forKey: VWBook.colIsbn13)
             obj.setValue(vw.image, forKey: VWBook.colImage)
            obj.setValue(vw.page, forKey: VWBook.colPage)
             obj.setValue(vw.price, forKey: VWBook.colPrice)
            obj.setValue(vw.pubdate, forKey: VWBook.colPubdate)
            obj.setValue(vw.publisher, forKey: VWBook.colPublisher)
             obj.setValue(vw.summary, forKey: VWBook.colSummary)
             obj.setValue(vw.title, forKey: VWBook.colTitle)
             obj.setValue(vw.binding, forKey: VWBook.colBinding)
            app.saveContetext()
        }catch {
            throw DateError.updateEntityError("更新图书失败")
        }
    }
    
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VWBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        do {
            let result = try context.fetch(fetch)
            for b in result {
                context.delete(b as! NSManagedObject)
            }
            app.saveContetext()
        }catch {
            throw DateError.deleteEntityError("删除图书失败")
        }
        
    }
}
