//
//  MainModel.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import Foundation
struct MainModel : Decodable {
    let id : String?
    let type : String?
    let date : String?
    let data : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case date = "date"
        case data = "data"
    }
}
