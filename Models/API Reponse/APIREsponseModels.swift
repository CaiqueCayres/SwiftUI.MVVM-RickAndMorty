//
//  APIModels.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation

struct APIResponse<T:Codable>: Codable {
    let info: APIREsponseInfo
    let results: [T]
}

struct APIREsponseInfo: Codable {
    let count: Int
    let pages: Int
}
