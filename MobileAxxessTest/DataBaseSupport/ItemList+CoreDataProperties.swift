//
//  ItemList+CoreDataProperties.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var type: String?
    @NSManaged public var id: String?
    @NSManaged public var date: String?
    @NSManaged public var data: String?
    
    func convertToItem() -> MainModel {
        return MainModel(id: id, type: type, date: date, data: data)
    }

}
