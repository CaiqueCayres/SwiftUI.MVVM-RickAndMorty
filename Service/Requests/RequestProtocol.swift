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

enum APIRequest: RequestProtocol {
    
    case characters(Int)
    case episodes(Int)
    case locations(Int)
    
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }
    
    var path: String {
        switch self {
        case .characters(let i): return "/character" + (i < 1 ? "" : "?page=\(i)")
        case .episodes(let i):   return "/episode"   + (i < 1 ? "" : "?page=\(i)")
        case .locations(let i):  return "/location"  + (i < 1 ? "" : "?page=\(i)")
        }
    }
}
