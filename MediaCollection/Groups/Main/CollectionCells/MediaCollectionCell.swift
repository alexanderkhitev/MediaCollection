//
//  MediaCollectionCell.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

class MediaCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mediaImageView: UIImageView!
    
    // MARK: - Data
    private var media: Media?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func populate(_ media: Media) {
        self.media = media
        switch media.type {
        case .photo:
            backgroundColor = .green
            setupPhotoSettings()
            if let url = media.url {
                setupPhoto(url)
            }
        case .video:
            backgroundColor = .red
            setupVideoSettings()
        }
    }
    
    private func setupPhotoSettings() {
        mediaImageView.isHidden = false
    }
    
    private func setupVideoSettings() {
        mediaImageView.isHidden = true
    }

    private func setupPhoto(_ url: URL) {
    }
    
}
