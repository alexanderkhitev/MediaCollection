//
//  Media.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import UIKit

final class Media {
    
    enum `Type`: Int {
        case photo, video
    }
    
    open let type: Type
    open var isEmpty = true
    open var url: URL?
    
    
    init() {
        let random = RandomGenerator.randomInt(min: 0, max: 1)
        self.type = Type.init(rawValue: random) ?? .photo
    }
    
}
