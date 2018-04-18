//
//  MediaCollectionCell.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit
import AVFoundation

class MediaCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mediaImageView: UIImageView!
    
    // MARK: - Managers
    
    private lazy var resourceManager: ResourceManager = {
        let resourceManager = ResourceManager()
        return resourceManager
    }()
    
    private lazy var videoPlayer: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    private lazy var avPlayerLayer: AVPlayerLayer = {
        let avPlayerLayer = AVPlayerLayer()
        return avPlayerLayer
    }()

    
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
            if let url = media.url {
                setupVideo(url)
            }
        }
        guard media.url == nil else { return }
        clear()
    }
    
    private func setupPhotoSettings() {
        avPlayerLayer.removeFromSuperlayer()
        mediaImageView.isHidden = false
    }
    
    private func setupVideoSettings() {
        mediaImageView.isHidden = true
        avPlayerLayer.videoGravity = .resizeAspectFill
        
        avPlayerLayer.player = videoPlayer
        avPlayerLayer.frame = bounds
        
        debugPrint("avPlayerLayer", avPlayerLayer.frame)
        
        let subLayersCount = layer.sublayers?.count ?? 0
        debugPrint("subLayersCount", subLayersCount)
        let index = subLayersCount + 1
        self.layer.insertSublayer(avPlayerLayer, at: UInt32(index))
    }

    private func setupPhoto(_ url: URL) {
        let image = resourceManager.getImageURL(url)
        mediaImageView.image = image
    }
    
    private func setupVideo(_ url: URL) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.videoPlayer = AVPlayer(url: url)
            self?.videoPlayer.play()
        }
    }
    
    private func clear() {
        mediaImageView.image = nil
    }
    
}
