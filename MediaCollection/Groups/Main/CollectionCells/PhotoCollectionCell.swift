//
//  PhotoCollectionCell.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    private let mediaImageView = UIImageView()
    
    // MARK: - Managers
    
    private lazy var resourceManager: ResourceManager = {
        let resourceManager = ResourceManager()
        return resourceManager
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        addUIElements()
        setupImageViewSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUIElements() {
        mediaImageView.frame = bounds
        addSubview(mediaImageView)
    }
    
    private func setupImageViewSettings() {
        mediaImageView.contentMode = .scaleAspectFill
        mediaImageView.clipsToBounds = true
    }
    
    open func populate(_ media: Media) {
        if let url = media.url {
            setupPhoto(url)
        } else {
            mediaImageView.image = nil
        }
    }
    
    private func setupPhoto(_ url: URL) {
        let image = resourceManager.getImageURL(url)
        mediaImageView.image = image
    }
    
    
}
