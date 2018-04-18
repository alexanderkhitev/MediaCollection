//
//  MediaListViewController.swift
//  MediaCollection
//
//  Created by Alexander Khitev on 4/18/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import UIKit

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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        // ui
        setupUISettings()
        addUIElements()
        // collection view
        setupCollectionViewSettings()
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

// MARK: - Collection View

extension MediaListViewController {
    
    private func setupCollectionViewSettings() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.defaultReuseIdentifier)
    }
    
}

// MARK: - CollectionView Data source and delegate

extension MediaListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.defaultReuseIdentifier, for: indexPath)
        
        cell.backgroundColor = .black
        
        return cell
    }
    
}
