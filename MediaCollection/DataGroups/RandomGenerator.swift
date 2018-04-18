//
//  RandomGenerator.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

final class RandomGenerator {
    
    class func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}
