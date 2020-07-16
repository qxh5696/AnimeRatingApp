//
//  HomeScreemVC.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/1/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    
    let cellReuseID = "AnimeCell"
    var trendingAnimes: [Anime?] = []
    let cellSpacingHeight: CGFloat = 3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Trending Anime"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trendingAnimes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! AnimeTableCell
        if let anime = trendingAnimes[indexPath.section] {
            cell.makeBackgroundImageCall(anime: anime)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let anime = trendingAnimes[indexPath.section] {
            let detailsPage = DetailPageVC()
            detailsPage.anime = anime
            self.navigationController?.pushViewController(detailsPage, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? cellSpacingHeight : 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTableView()
        getAnimes()
        let modelName = UIDevice.modelName
        print(modelName)
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AnimeTableCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.rowHeight = 100
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(patternImage: UIImage(named: "lineseparator.png")!)
    }
    
    func getAnimes() {
        let session = URLSession.shared
        let url = ANIME_TRENDING_URL
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(error)
                return
            }
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data!)
                self.trendingAnimes = animeData.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error in network call")
            }
        })
        task.resume()
    }
}
