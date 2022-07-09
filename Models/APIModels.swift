//
//  APIModels.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation

struct Characther: Codable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct Origin: Codable {
        let name: String
        let url: String
    }
}

struct Location: Codable {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

struct Episode: Codable {
    
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
    let url: String
}
