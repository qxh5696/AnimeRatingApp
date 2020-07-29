//
//  AnimeCollectionViewController.swift
//  AnimeBrowsingApp
//
//  Created by qh on 7/22/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_Theming

class AnimeCollectionViewController: UIViewController {
    
    var animeCategory: [Anime?] = []
    var sectionLabelString: String?
    let reuseIdentifier = "collectionViewCell"
    
    private lazy var sectionLabel: UILabel = {
        let sectionLabel = UILabel()
        sectionLabel.backgroundColor = .clear
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        return sectionLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // getAnimeImages()
        setUpCollectionView()
    }
    
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        view.addSubview(sectionLabel)
        
        sectionLabel.text = sectionLabelString ?? ""
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MDCCardCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        sectionLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sectionLabel.bottomAnchor.constraint(equalTo: sectionLabel.topAnchor, constant: 30).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
    }
}

extension AnimeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animeCategory.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MDCCardCollectionCell
        cell.cornerRadius = 8
        var image: UIImage? = nil
        
        guard let smallImageUrl = animeCategory[indexPath.row]?.getPosterImageSmallURL() else { return cell }
        ImageCache.loadImage(urlString: smallImageUrl.absoluteString, completion: {string, storedImage in
            image = storedImage
        })
        
        if let backgroundImage = image {
            DispatchQueue.main.async {
                cell.backgroundView = UIImageView(image: backgroundImage)
            }
            return cell
        }
        
        URLSession.shared.dataTask(with: smallImageUrl, completionHandler: { data, response, error in
            if (error != nil) {
                print(error as Any)
                return
            }
            
            guard let image = UIImage(data: data!) else { return }
            ImageCache.storeImage(urlString: smallImageUrl.absoluteString, img: image)
            DispatchQueue.main.async {
                cell.backgroundView = UIImageView(image: image)
            }
            
        }).resume()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.5, height: view.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
