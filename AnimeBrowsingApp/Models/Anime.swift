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
    let data: [Anime]?
    var meta: [String: Int]? = [:]
    var links: [String: String]? = [:]
    enum CodingKeys: String, CodingKey {
        case data, meta, links
    }
    
    init(data: [Anime], meta: [String: Int]?, links: [String: String]?){
        self.data = data
        self.meta = meta
        self.links = links
    }   
}

class Anime: Codable {
    let id: String?
    let type: String?
    let links: [String: String]?
    let attributes: Attributes?
    let relationships: Relationships?
    enum CodingKeys: String, CodingKey {
        case id, type, links, attributes, relationships
    }
    
    func getMediumImageUrl() -> URL? {
        if let mediumURL = self.attributes?.posterImage?.medium {
            return URL(string: mediumURL)
        }
        return nil
    }
    
    func getCoverImageSmallUrl() -> URL? {
        if let smallURL = self.attributes?.coverImage?.small {
            return URL(string: smallURL)
        }
        return nil
    }
    
    func getCoverImageOriginalUrl() -> URL? {
        if let originalURL = self.attributes?.coverImage?.original {
            return URL(string: originalURL)
        }
        return nil
    }
    
    func getTitle() -> String {
        if let englishTitle = self.attributes?.titles?[ENGLISH_STRING] {
            return englishTitle
        }
        if let japaneseEnglishTitle = self.attributes?.titles?[JAPAN_EN_STRING] {
            return japaneseEnglishTitle
        }
        if let japanTitle = self.attributes?.titles?[JAPAN_STRING] {
            return japanTitle
        }
        return ""
    }
    
    func getPosterImageLargeURL() -> URL? {
        if let largeURL = self.attributes?.posterImage?.large {
            return URL(string: largeURL)
        }
        return nil
    }
    
    func getPosterImageMediumURL() -> URL? {
        if let mediumURL = self.attributes?.posterImage?.medium {
            return URL(string: mediumURL)
        }
        return nil
    }
    
    func getPosterImageSmallURL() -> URL? {
        if let smallURL = self.attributes?.posterImage?.small {
            return URL(string: smallURL)
        }
        return nil
    }
    
    func getSynopsis() -> String {
        if let synopsis = self.attributes?.synopsis {
            return synopsis
        }
        return ""
    }
}


// MARK: Anime Object SubClasses

class Attributes: Codable {
    let createdAt, updatedAt, slug, synopsis, canonicalTitle, startDate, endDate, ageRating, ageRatingGuide, subtype, status, tba, youtubeVideoId, showType, averageRating: String?
    let coverImageTopOffset, userCount, favoritesCount, popularityRank, ratingRank, episodeCount, episodeLength: Int?
    let abbreviatedTitles: [String]?
    let titles, ratingFrequencies: [String: String]?
    let nsfw: Bool?
    let posterImage: PosterImage?
    let coverImage: CoverImage?
    
    enum CodingKeys: String, CodingKey {
        case createdAt, updatedAt, slug, synopsis, canonicalTitle, startDate, endDate, ageRating, ageRatingGuide, subtype, status, tba, youtubeVideoId, showType, coverImageTopOffset, userCount, favoritesCount, popularityRank, ratingRank, episodeCount, episodeLength, abbreviatedTitles, averageRating, titles, ratingFrequencies, nsfw, posterImage, coverImage
    }
}

class Relationships: Codable {
    let genres, categories, castings, installments, mappings, reviews, mediaRelationships, episodes, streamingLinks, animeProductions, animeCharacters, animeStaff: [String: [String: String]]?
    
    enum CodingKeys: String, CodingKey {
        case genres, categories, castings, installments, mappings, reviews, mediaRelationships, episodes, streamingLinks, animeProductions, animeCharacters, animeStaff
    }
    
}

// MARK: Attributes Object SubClasses
struct PosterImage: Codable {
    let tiny, small, medium, large, original: String?
    let meta: [String : [String: [String: Int?]]]
    
    enum CodingKeys: String, CodingKey {
        case tiny, small, medium, large, original, meta
    }
}

class CoverImage: Codable {
    let tiny, small, large, original: String?
    
    enum CodingKeys: String, CodingKey {
        case tiny, small, large, original
    }
}




