//
//  MediaDataManager.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

final class MediaDataManager {
    
    open func getModels() -> [Media] {
        var models = [Media]()
        for _ in 0...19 {
            let media = Media()
            models.append(media)
        }
        return models
    }
    
}
