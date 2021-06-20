//
//  Genre.swift
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//
import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
