//
//  ResourceManager.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

final class ResourceManager {
    
    open func getImageURL(_ url: URL) -> UIImage? {
        let image = UIImage(contentsOfFile: url.path)
        // Do whatever you want with the image
        return image
    }
        
}
