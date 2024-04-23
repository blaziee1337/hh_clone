//
//  Recommend.swift
//  hh_clone
//
//  Created by Halil Yavuz on 05.04.2024.
//

import Foundation

struct Offers: Codable {
    let offers: [RecommendModel]
}

struct RecommendModel: Codable {
    let title: String
}
