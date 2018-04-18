//
//  VideoCollectionCell.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCollectionCell: UICollectionViewCell {
    
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
        backgroundColor = .red
        if let url = media.url {
            setupVideoSettings(url)
        } else {
            avPlayerLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: - video
    
    private func setupVideoSettings(_ url: URL) {
        videoPlayer = AVPlayer(url: url)
        videoPlayer.isMuted = true
        videoPlayer.volume = 0
        
        avPlayerLayer = AVPlayerLayer(player: videoPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayerLayer.frame = bounds
        
        self.layer.addSublayer(avPlayerLayer)
        
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.videoPlayer.play()
        }
    }
    
    private func clear() {
        videoPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
}
