//
//  MainNaviController.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class MainNaviController: UINavigationController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSetting()
        addControllers()
    }
    
    // MARK: - Settings

    private func setupSetting() {
        definesPresentationContext = true
    }
    
    private func addControllers() {
        let mediaListViewController = MediaListViewController()
        viewControllers = [mediaListViewController]
    }
    
}
