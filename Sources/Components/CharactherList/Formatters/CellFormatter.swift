//
//  CellFormatter.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import Foundation

protocol CellDataProtocol {
 
    var name: String { get }
    var imageUrl: String { get }
    var status: String { get }
    var species: String { get }
}

struct CellFormatter: Hashable, CellDataProtocol {
    
    let characther: Characther
 
    var name: String { characther.name }
    var imageUrl: String { characther.image }
    var status: String { characther.status }
    var species: String { characther.species }
}
