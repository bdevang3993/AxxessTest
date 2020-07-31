//
//  ItemManager.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import Foundation
import CoreData

struct ItemManager {
    private let _itemDataRepository = ItemDataRepository()
    
    func createItem(items:MainModel) {
        _itemDataRepository.create(item: items)
    }
    func fetchItemList() -> [MainModel] {
        return _itemDataRepository.getAll()!
    }
    func deleteItem(id:String) -> Bool {
        return _itemDataRepository.delete(record: id)
    }
    func deleteAllData() -> Bool {
        return _itemDataRepository.deleteAll()
    }
}
