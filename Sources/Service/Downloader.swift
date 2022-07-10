//
//  Downloader.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import Foundation
import Combine
import SwiftUI

class Downloader {
    
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func downloadImage(from urlString: String) -> AnyPublisher<UIImage?, Error> {
        return network.downloadImage(from: urlString)
            .tryMap({ (data) -> UIImage? in
                UIImage(data: data)
            })
            .eraseToAnyPublisher()
    }
}
