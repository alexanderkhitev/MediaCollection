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
    private let mediaImageView = UIImageView()
    
    // MARK: - Managers
    
    private lazy var resourceManager: ResourceManager = {
        let resourceManager = ResourceManager()
        return resourceManager
    }()
    
    private lazy var videoPlayer: AVPlayer = {
        let player = AVPlayer()
        player.isMuted = true
        player.volume = 0
        return player
    }()
    
    private lazy var avPlayerLayer: AVPlayerLayer = {
        let avPlayerLayer = AVPlayerLayer()
        return avPlayerLayer
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func populate(_ media: Media) {
        clear()
        switch media.type {
        case .photo:
            backgroundColor = .green 
            setupPhotoSettings()
            if let url = media.url {
                addImageView()
                setupPhoto(url)
            }
        case .video:
            backgroundColor = .red
            if let url = media.url {
                setupVideoSettings(url)
                setupVideo(url)
            }
        }
    }
    
    // MARK: - image
    
    private func addImageView() {
        mediaImageView.frame = bounds
        addSubview(mediaImageView)
    }
    
    private func setupPhoto(_ url: URL) {
        let image = resourceManager.getImageURL(url)
        mediaImageView.image = image
    }

    private func setupPhotoSettings() {
        avPlayerLayer.removeFromSuperlayer()
        mediaImageView.isHidden = false
        mediaImageView.contentMode = .scaleAspectFill
        mediaImageView.clipsToBounds = true
        videoPlayer.pause()
    }
    
    // MARK: - video
    
    private func setupVideoSettings(_ url: URL) {
        mediaImageView.removeFromSuperview()
        
        videoPlayer = AVPlayer(url: url)
        videoPlayer.isMuted = true
        videoPlayer.volume = 0
        
        mediaImageView.isHidden = true
        avPlayerLayer = AVPlayerLayer(player: videoPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayerLayer.frame = bounds
        
        self.layer.addSublayer(avPlayerLayer)
    }
    
    private func setupVideo(_ url: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.videoPlayer.play()
        }
    }
    
    private func clear() {
        mediaImageView.image = nil
        mediaImageView.removeFromSuperview()
        
        videoPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
}
