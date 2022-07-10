//
//  RequestProtocol.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation

protocol RequestProtocol {
    
    var baseURL: String { get }
    var path: String { get }
    
    func urlRequest() -> URL?
}

extension RequestProtocol {
    
    func urlRequest() -> URL? {
        URL(string: baseURL + path)
    }
}
