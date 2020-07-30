//
//  AnimeHomeCollectionViewController.swift
//  AnimeBrowsingApp
//
//  Created by qh on 7/20/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_Theming

class AnimeHomeCollectionViewController: UIViewController {
    
    let COLLECTIONVIEW_HEIGHT_MULTIPLIER = CGFloat(0.6)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        return scrollView
    }()
    
    private lazy var popularAnimeViewController: AnimeCollectionViewController = {
        let animeCollectionViewContoller = AnimeCollectionViewController()
        animeCollectionViewContoller.animeCategory = self.popularAnime
        animeCollectionViewContoller.sectionLabelString = "Popular Anime"
        return animeCollectionViewContoller
    }()
    
    private lazy var trendingAnimeViewController: AnimeCollectionViewController = {
        let animeCollectionViewContoller = AnimeCollectionViewController()
        animeCollectionViewContoller.animeCategory = self.trendingAnime
        animeCollectionViewContoller.sectionLabelString = "Trending Anime"
        return animeCollectionViewContoller
    }()
    
    private lazy var newAnimeController: AnimeCollectionViewController = {
        let animeCollectionViewContoller = AnimeCollectionViewController()
        animeCollectionViewContoller.animeCategory = self.newAnime
        animeCollectionViewContoller.sectionLabelString = "New Anime"
        return animeCollectionViewContoller
    }()
    
    private lazy var highestRatedAnimeController: AnimeCollectionViewController = {
        let animeCollectionViewContoller = AnimeCollectionViewController()
        animeCollectionViewContoller.animeCategory = self.highestRatedAnime
        animeCollectionViewContoller.sectionLabelString = "Highest Rated Anime"
        return animeCollectionViewContoller
    }()
    
    private lazy var mostTalkedAboutAnimeController: AnimeCollectionViewController = {
        let animeCollectionViewContoller = AnimeCollectionViewController()
        animeCollectionViewContoller.animeCategory = self.mostTalkedAboutAnime
        animeCollectionViewContoller.sectionLabelString = "Most Talked About Anime"
        return animeCollectionViewContoller
    }()
    
    var trendingAnime: [Anime] = []
    var popularAnime: [Anime] = []
    var newAnime: [Anime] = []
    var highestRatedAnime: [Anime] = []
    var mostTalkedAboutAnime: [Anime] = []
    
    var trendingAnimeBackgroundImages: [UIImage] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        
    }
    
    func setUp() {
        self.navigationController?.navigationBar.isHidden = true
        makeApiCalls()
        setUpCollectionView()
        
    }
    
    // MARK: Anime API Calls
    func makeApiCalls() {
        let group = DispatchGroup()
        
        // TRENDING ANIME API CALL
        group.enter()
        URLSession.shared.dataTask(with: ANIME_TRENDING_URL, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                if let data = animeData.data {
                    self.trendingAnime = data
                }
                group.leave()
                
            } catch {
                print("Error in network call")
            }
        }).resume()
        
        // POPULAR ANIME API CALL
        group.enter()
        URLSession.shared.dataTask(with: ANIME_POPULAR_URL, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                if let data = animeData.data {
                    self.popularAnime = data
                }
                group.leave()
                
            } catch {
                print("Error in network call")
            }
        }).resume()
        
        // NEW ANIME API CALL
        group.enter()
        URLSession.shared.dataTask(with: ANIME_NEW_URL, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                if let data = animeData.data {
                    self.newAnime = data
                }
                group.leave()
            } catch {
                print("Error in network call")
            }
        }).resume()
        
        // HIGHEST RATED ANIME API CALL
        group.enter()
        URLSession.shared.dataTask(with: ANIME_HIGHEST_RATING_URL, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                if let data = animeData.data {
                    self.highestRatedAnime = data
                }
                group.leave()
                
            } catch {
                print("Error in network call")
            }
        }).resume()
        
        // MOST USERS API CALL
        group.enter()
        URLSession.shared.dataTask(with: ANIME_USERS_URL, completionHandler: { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                if let data = animeData.data {
                    self.mostTalkedAboutAnime = data
                }
                group.leave()
            } catch {
                print("Error in network call")
            }
        }).resume()
        
        group.wait()
    }
    
    // MARK: Set Up UI Layout
    func setUpCollectionView() {
        let backgroundImageView = UIImageView(image: UIImage(named: "akira")!)
        backgroundImageView.addBlurEffect()
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        
        scrollView.delegate = self
        scrollView.pin(to: view)
        scrollView.backgroundColor = .clear
        scrollView.addSubview(popularAnimeViewController.view)
        scrollView.addSubview(trendingAnimeViewController.view)
        scrollView.addSubview(newAnimeController.view)
        scrollView.addSubview(highestRatedAnimeController.view)
        scrollView.addSubview(mostTalkedAboutAnimeController.view)
        
        
        popularAnimeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        popularAnimeViewController.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 75).isActive = true
        popularAnimeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        popularAnimeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        popularAnimeViewController.view.heightAnchor.constraint(equalTo: popularAnimeViewController.view.widthAnchor, multiplier: COLLECTIONVIEW_HEIGHT_MULTIPLIER).isActive = true
        
        trendingAnimeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        trendingAnimeViewController.view.topAnchor.constraint(equalTo: popularAnimeViewController.view.bottomAnchor, constant: 40).isActive = true
        trendingAnimeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        trendingAnimeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        trendingAnimeViewController.view.heightAnchor.constraint(equalTo: trendingAnimeViewController.view.widthAnchor, multiplier: COLLECTIONVIEW_HEIGHT_MULTIPLIER).isActive = true
        
        newAnimeController.view.translatesAutoresizingMaskIntoConstraints = false
        newAnimeController.view.topAnchor.constraint(equalTo: trendingAnimeViewController.view.bottomAnchor, constant: 40).isActive = true
        newAnimeController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        newAnimeController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        newAnimeController.view.heightAnchor.constraint(equalTo: newAnimeController.view.widthAnchor, multiplier: COLLECTIONVIEW_HEIGHT_MULTIPLIER).isActive = true
        
        highestRatedAnimeController.view.translatesAutoresizingMaskIntoConstraints = false
        highestRatedAnimeController.view.topAnchor.constraint(equalTo: newAnimeController.view.bottomAnchor, constant: 40).isActive = true
        highestRatedAnimeController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        highestRatedAnimeController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        highestRatedAnimeController.view.heightAnchor.constraint(equalTo: highestRatedAnimeController.view.widthAnchor, multiplier: COLLECTIONVIEW_HEIGHT_MULTIPLIER).isActive = true
        
        mostTalkedAboutAnimeController.view.translatesAutoresizingMaskIntoConstraints = false
        mostTalkedAboutAnimeController.view.topAnchor.constraint(equalTo: highestRatedAnimeController.view.bottomAnchor, constant: 40).isActive = true
        mostTalkedAboutAnimeController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        mostTalkedAboutAnimeController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        mostTalkedAboutAnimeController.view.heightAnchor.constraint(equalTo: mostTalkedAboutAnimeController.view.widthAnchor, multiplier: COLLECTIONVIEW_HEIGHT_MULTIPLIER).isActive = true
    }
    
}

extension AnimeHomeCollectionViewController: UIScrollViewDelegate {}
