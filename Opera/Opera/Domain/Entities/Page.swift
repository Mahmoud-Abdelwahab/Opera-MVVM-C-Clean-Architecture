//
//  Page.swift
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import Foundation

struct Page<T: Decodable>: Decodable {
    let page: Int
    let total: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case total = "total_pages"
        case results = "results"
    }
}


