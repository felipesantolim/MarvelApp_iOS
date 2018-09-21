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
    
    public static let KeyData: String = "data"
    public static let KeyResults: String = "results"
    public static let KeyThumbnail: String = "thumbnail"
    public static let KeyPath: String = "path"
    public static let KeyExtension: String = "extension"
    public static let KeyUid: String = "id"
    public static let KeyName: String = "name"
    public static let KeyDescription: String = "description"
    public static let KeyComics: String = "comics"
    public static let KeySeries: String = "series"
    public static let KeyStories: String = "stories"
    public static let KeyEvents: String = "events"
    public static let KeyAvailable: String = "available"
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
