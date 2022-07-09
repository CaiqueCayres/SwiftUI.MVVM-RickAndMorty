//
//  Coordinator.swift
//  MVVMC-SwiftUI (iOS)
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation
import Combine
import SwiftUI


class Coordinator {
    
    
    init(){
        
        doshit()
    }
    
    
    func doshit(){
        
        let service = ServiceManager()
        
        service.loadMoreChars()
            


    }
}
