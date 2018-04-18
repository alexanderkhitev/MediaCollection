//
//  MediaListViewController.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit
import MobileCoreServices

class MediaListViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let mainScreenBounds = UIScreen.main.bounds
        let sizeValue = (mainScreenBounds.width - 32) / 2
        layout.itemSize = CGSize(width: sizeValue, height: sizeValue)
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var mediaPicker: UIImagePickerController = {
        let mediaPicker = UIImagePickerController()
        return mediaPicker
    }()
    
    // MARK: - Data
    
    private var models = [Media]()
    
    // MARK: - Properties
    
    private var selectedIndexPath: IndexPath?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        // ui
        setupUISettings()
        addUIElements()
        // collection view
        setupCollectionViewSettings()
        // data
        getModels()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }

    // MARK: - Settings
    
    private func setupSettings() {
        definesPresentationContext = true
    }
 
    // MARK: - UI
    
    private func setupUISettings() {
        view.backgroundColor = .white
        navigationItem.title = "Green == photo, Red == video"
    }
    
    private func addUIElements() {
        view.addSubview(collectionView)
    }
    
    private func setupUIElementsPositions() {
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}

// MARK: - Data

extension MediaListViewController {
    
    private func getModels() {
        let mediaDataManager = MediaDataManager()
        models = mediaDataManager.getModels()
        collectionView.reloadData()
    }
    
}

// MARK: - Collection View

extension MediaListViewController {
    
    private func setupCollectionViewSettings() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(VideoCollectionCell.self, forCellWithReuseIdentifier: VideoCollectionCell.defaultReuseIdentifier)
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.defaultReuseIdentifier)
    }
    
}

// MARK: - CollectionView Data source and delegate

extension MediaListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let media = models[indexPath.row]
        if media.type == .video {
            return videoCell(collectionView, indexPath: indexPath, media: media)
        } else {
            return photoCell(collectionView, indexPath: indexPath, media: media)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let media = models[indexPath.row]
        presentMediaPicker(media)
    }
    
}

// MARK: - Cells

extension MediaListViewController {
    
    private func videoCell(_ collectionView: UICollectionView, indexPath: IndexPath, media: Media) -> VideoCollectionCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionCell.defaultReuseIdentifier, for: indexPath) as! VideoCollectionCell
        // swiftlint:enable force_cast
        
        cell.populate(media)
        
        return cell
    }
    
    private func photoCell(_ collectionView: UICollectionView, indexPath: IndexPath, media: Media) -> PhotoCollectionCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.defaultReuseIdentifier, for: indexPath) as! PhotoCollectionCell
        // swiftlint:enable force_cast
        
        cell.populate(media)
        
        return cell
    }
    
}

// MARK: - Media functions

extension MediaListViewController {
    
    private func presentMediaPicker(_ media: Media) {
        mediaPicker.sourceType = .photoLibrary
        mediaPicker.delegate = self
        switch media.type {
        case .photo:
            mediaPicker.mediaTypes = [kUTTypeImage] as [String]
        case .video:
            mediaPicker.mediaTypes = [kUTTypeMovie] as [String]
        }
        present(mediaPicker, animated: true, completion: nil)
    }
    
    private func updateCell(_ url: URL) {
        guard let selectedIndexPath = selectedIndexPath else { return }
        let media = models[selectedIndexPath.row]
        media.url = url
        
        if media.type == .video {
            guard let cell = collectionView.cellForItem(at: selectedIndexPath) as? VideoCollectionCell else { return }
            cell.populate(media)
        } else {
            guard let cell = collectionView.cellForItem(at: selectedIndexPath) as? PhotoCollectionCell else { return }
            cell.populate(media)
        }
    }
    
}

// MARK: - Media picker delegate

extension MediaListViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let url = info["UIImagePickerControllerImageURL"] as? URL {
            print(url)
            updateCell(url)
        } else if let mediaURL = info["UIImagePickerControllerMediaURL"] as? URL {
            print(mediaURL)
            updateCell(mediaURL)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
