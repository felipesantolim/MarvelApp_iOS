//
//  MACharactersModel.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public struct MACharactersModel {
    
    public var uid: Int?
    public var name: String?
    public var thumbnail: MACharThumbnailModel?
    public var description: String?
    public var comics: Int?
    public var series: Int?
    public var stories: Int?
    public var events: Int?
 
    public init() {}
    
    public init(_ uid: Int, _ name: String, _ thumbnail: MACharThumbnailModel, _ description: String,
                _ comics: Int?, _ series: Int?, _ stories: Int?, _ events: Int?) {
        self.uid = uid
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }
}

public struct MACharThumbnailModel {
    
    public var path: String?
    public var _extension: String?
    
    public init() {}
    
    public init(_ path: String, _extension: String) {
        self.path = path
        self._extension = _extension
    }
}
