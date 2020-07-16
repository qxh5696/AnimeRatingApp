//
//  AnimeTableCell.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/1/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import UIKit

class AnimeTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeBackgroundImageCall(anime: Anime) {
        guard let url = anime.getCoverImageOriginalUrl() else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if (error != nil) {
                print(error as Any)
                return
            }
            guard let image = UIImage(data: data!) else { return }
            
            DispatchQueue.main.async() { [weak self] in
                guard let contentView = self?.contentView else { return }
                let imageView = UIImageView(image: image)
                contentView.addSubview(imageView)
                imageView.pin(to: contentView)
                contentView.sendSubviewToBack(imageView)
            }
        }.resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
