//
//  ItemDataRepository.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit
import CoreData

protocol ItemRepository {
    func create(item: MainModel)
    func getAll() -> [MainModel]?
    //func update(item: ItemListModel) -> Bool
    func deleteAll() -> Bool
    func delete(record:String) -> Bool
}

struct ItemDataRepository : ItemRepository  {
   
    
    func create(item: MainModel) {
        let itemDescription = ItemList(context: PersistentStorage.shared.context)
        if let id = item.id {
            itemDescription.id = id//item.id
        }else {
            itemDescription.id = ""
        }
        if let type = item.type {
           itemDescription.type = type
        } else {
            itemDescription.type = ""
        }
        if let date = item.date {
            itemDescription.date = date
        }else {
            itemDescription.date = ""
        }
        if let data = item.data {
            itemDescription.data = data
        } else {
            itemDescription.data = ""
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [MainModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: ItemList.self)
        
        var itemsListData:[MainModel] = []
        result.forEach { (itemList) in
            itemsListData.append(itemList.convertToItem())
        }
        return itemsListData
    }
    
//    func update(item: ItemListModel) -> Bool {
//        return true
//    }
    
    func delete(record: String) -> Bool {
        
        let itemData = getItems(byIdentifier: record)
        guard itemData != nil else {
            return false
        }
        PersistentStorage.shared.context.delete(itemData!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func deleteAll() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemList")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try PersistentStorage.shared.context.execute(deleteRequest)
            PersistentStorage.shared.saveContext()
            return true
        }
        catch _ {
            return false
        }
    }
    

    
    private func getItems(byIdentifier id:String) -> ItemList? {
        let fetchRquest = NSFetchRequest<ItemList>(entityName: "ItemList")
        let predicate = NSPredicate(format: "id==%@", id)
        fetchRquest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRquest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
    
}
