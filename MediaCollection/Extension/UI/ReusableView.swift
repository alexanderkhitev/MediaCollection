//
//  ReusableView.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    
    static var defaultReuseIdentifier: String { get }
    
}

extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
}
