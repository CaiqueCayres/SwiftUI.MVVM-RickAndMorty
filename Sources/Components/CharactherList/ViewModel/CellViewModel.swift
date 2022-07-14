//
//  CellViewModel.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import SwiftUI
import Combine

class CellViewModel: ObservableObject {
    
    let data: CellDataProtocol
    let downloader: Downloader
    
    var disposeBag = Set<AnyCancellable>()
    
    @Published var charImage: UIImage = UIImage()
    
    init(data: CellDataProtocol,
         downloader: Downloader = Downloader()) {
        self.data = data
        self.downloader = downloader
        self.downloadImage()
    }
    
    func downloadImage() {
        downloader.downloadImage(from: data.imageUrl)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] image in
                self?.charImage = image ?? UIImage()
            }
            .store(in: &disposeBag)
    }
}
