//
//  DetailPageVC.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/8/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController, UIScrollViewDelegate {
    
    var anime: Anime?
    var shouldShowBackButton: Bool = false
    var scrollView = UIScrollView()
    var posterImage = UIImageView()
    var titleLabel = UILabel()
    var synopsisLabel = UILabel()
    var backButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setUpScrollView() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.pin(to: view)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*2)
        let session = URLSession.shared
        guard let largePosterURL = anime?.getPosterImageLargeURL() else { return }
        let task = session.dataTask(with: largePosterURL, completionHandler: { data, response, error in
            if (error != nil) {
                return
            }
            guard let image = UIImage(data: data!) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.setContentBackgroundImage(image: image)
                self?.setPosterImage(image: image)
                self?.setTitleLabel()
                self?.setSynopsisLabel()
                self?.setBackButton()
            }
            
        })
        task.resume()
    }
    
    func setContentBackgroundImage(image: UIImage) {
        let contentBackgroundImage = UIImageView(image: image)
        contentBackgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height*2)
        contentBackgroundImage.addBlurEffect()
        view.addSubview(contentBackgroundImage)
        view.sendSubviewToBack(contentBackgroundImage)
    }
    
    func setPosterImage(image: UIImage) {
        posterImage.image = image
        posterImage.frame = CGRect(x: 0, y:0, width: view.frame.width, height: view.frame.height - 300)
        scrollView.addSubview(posterImage)
    }
    
    func setTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(30)
        titleLabel.text = anime?.getTitle()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 30).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40).isActive = true
    }
    
    func setSynopsisLabel() {
        scrollView.addSubview(synopsisLabel)
        synopsisLabel.textColor = .white
        synopsisLabel.numberOfLines = 0
        synopsisLabel.text = anime?.getSynopsis()
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        synopsisLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        synopsisLabel.bottomAnchor.constraint(equalTo: synopsisLabel.topAnchor, constant: 500).isActive = true
        synopsisLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        synopsisLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    
    func setBackButton() {
        if (shouldShowBackButton) {
            scrollView.addSubview(backButton)
            scrollView.bringSubviewToFront(backButton)
            backButton.setTitle("Back", for: .normal)
            backButton.frame = CGRect(x: 30, y: 30, width: 50, height: 20)
            backButton.addTarget(self, action: #selector(DetailPageViewController.dissDetailsPage), for: .touchUpInside)
        }
    }
    
    @objc func dissDetailsPage() {
        navigationController?.popViewController(animated: true)
    }
}
