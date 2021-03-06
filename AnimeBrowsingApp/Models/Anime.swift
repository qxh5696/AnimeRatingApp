//
//  Anime.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/2/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import Foundation
import UIKit

class AnimeData: Codable {
    let data: [Anime]
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(data: [Anime]){
        self.data = data
    }
}

class Anime: Codable {
    let id: String
    let type: String
    let links: [String: String]
    let attributes: Attributes
    let relationships: Relationships
    enum CodingKeys: String, CodingKey {
        case id, type, links, attributes, relationships
    }
    
//    func getMediumImage() -> UIImage? {
//        var image: UIImage? = nil
//        let url = URL(string: self.attributes.posterImage.medium)
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            if (error != nil) {
//                print(error as Any)
//                return
//            }
//            image = UIImage(data: data!)
//        }.resume()
//        return image
//    }
    
    func getMediumImageUrl() -> URL? {
        return URL(string: self.attributes.posterImage.medium)
    }
    
    func getCoverImageSmallUrl() -> URL? {
        return URL(string: self.attributes.coverImage.small)
    }
    
    func getCoverImageOriginalUrl() -> URL? {
        return URL(string: self.attributes.coverImage.original)
    }
    
    func getTitle() -> String {
        if let englishTitle = self.attributes.titles[ENGLISH_STRING] {
            return englishTitle
        }
        if let japaneseEnglishTitle = self.attributes.titles[JAPAN_EN_STRING] {
            return japaneseEnglishTitle
        }
        return self.attributes.titles[JAPAN_STRING]!
    }
    
    func getPosterImageLargeURL() -> URL? {
        return URL(string: self.attributes.posterImage.large)
    }
    
    func getPosterImageMediumURL() -> URL? {
        return URL(string: self.attributes.posterImage.medium)
    }
    
    func getSynopsis() -> String {
        guard let synopsis = self.attributes.synopsis else { return "" }
        return synopsis
    }
}


// MARK: Anime Object SubClasses

class Attributes: Codable {
    let createdAt, updatedAt, slug, synopsis, canonicalTitle, startDate, endDate, ageRating, ageRatingGuide, subtype, status, tba, youtubeVideoId, showType, averageRating: String?
    let coverImageTopOffset, userCount, favoritesCount, popularityRank, ratingRank, episodeCount, episodeLength: Int?
    let abbreviatedTitles: [String]
    let titles, ratingFrequencies: [String: String]
    let nsfw: Bool
    let posterImage: PosterImage
    let coverImage: CoverImage
    
    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, slug, synopsis, canonicalTitle, startDate, endDate, ageRating, ageRatingGuide, subtype, status, tba, youtubeVideoId, showType, coverImageTopOffset, userCount, favoritesCount, popularityRank, ratingRank, episodeCount, episodeLength, abbreviatedTitles, averageRating, titles, ratingFrequencies, nsfw, posterImage, coverImage
    }
}

class Relationships: Codable {
    let genres, categories, castings, installments, mappings, reviews, mediaRelationships, episodes, streamingLinks, animeProductions, animeCharacters, animeStaff: [String: [String: String]]
    
    enum CodingKeys: String, CodingKey {
        case genres, categories, castings, installments, mappings, reviews, mediaRelationships, episodes, streamingLinks, animeProductions, animeCharacters, animeStaff
    }
    
}

// MARK: Attributes Object SubClasses
struct PosterImage: Codable {
    let tiny, small, medium, large, original: String
    let meta: [String : [String: [String: Int?]]]
    
    enum CodingKeys: String, CodingKey {
        case tiny, small, medium, large, original, meta
    }
}

class CoverImage: Codable {
    let tiny, small, large, original: String
    
    enum CodingKeys: String, CodingKey {
        case tiny, small, large, original
    }
}




