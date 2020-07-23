//
//  Constants.swift
//  AnimeBrowsingApp
//
//  Created by qadir haqq on 7/2/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import Foundation

// Trending Anime
let ANIME_TRENDING_URL_STRING = "https://kitsu.io/api/edge/trending/anime"
let ANIME_TRENDING_URL = URL(string: ANIME_TRENDING_URL_STRING)!

// Most popular anime
let ANIME_POPULAR_URL_STRING = "https://kitsu.io/api/edge/anime?sort=popularityRank"
let ANIME_POPULAR_URL = URL(string: ANIME_POPULAR_URL_STRING)!

// Newest Anime
let ANIME_NEW_URL_STRING = "https://kitsu.io/api/edge/anime?sort=-startDate"
let ANIME_NEW_URL = URL(string: ANIME_NEW_URL_STRING)!

// Highest Rated anime
let ANIME_HIGHEST_RATING_URL_STRING = "https://kitsu.io/api/edge/anime?sort=ratingRank"
let ANIME_HIGHEST_RATING_URL = URL(string: ANIME_HIGHEST_RATING_URL_STRING)!

// Most talked about anime
let ANIME_USERS_URL_STRING = "https://kitsu.io/api/edge/anime?sort=userCount"
let ANIME_USERS_URL = URL(string: ANIME_USERS_URL_STRING)!




let ENGLISH_STRING = "en"
let JAPAN_EN_STRING = "en_jp"
let JAPAN_STRING = "jp_jp"
