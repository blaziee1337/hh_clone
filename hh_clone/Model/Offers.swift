//
//  Offers.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

struct Offers: Decodable {
    let offers: [RecommendModel]
}

struct RecommendModel: Decodable {
    let title: String
    let button: Button?
}

struct Button: Decodable {
    let text: String
}
