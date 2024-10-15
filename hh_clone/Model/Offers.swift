//
//  Offers.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

struct Offers: Codable {
    let offers: [RecommendModel]
}

struct RecommendModel: Codable {
    let title: String
}
