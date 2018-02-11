//
//  TracksDTO.swift
//  PruebaBeRepublic
//
//  Created by Erik on 24/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation
import ObjectMapper

class Media : Mappable {
    
    var trackName = ""
    var collectionName = ""
    var artistName = ""
    var releaseDate = ""
    var artwork = ""
    var trackTime = 0
    var primaryGenreName = ""
    var trackPrice = 0.0
    var previewUrl = ""
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        trackName <- map["trackName"]
        collectionName <- map["collectionName"]
        artistName <- map["artistName"]
        releaseDate <- map["releaseDate"]
        artwork <- map["artworkUrl100"]
        trackTime <- map["trackTimeMillis"]
        primaryGenreName <- map["primaryGenreName"]
        trackPrice <- map["trackPrice"]
        previewUrl <- map["previewUrl"]
    }
    
}

class MediaInfo: Mappable {
    var allMedia: [Media]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        allMedia <- map["results"]
    }
    
}
