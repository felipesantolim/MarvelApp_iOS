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
 
    public init() {}
    
    public init(_ uid: Int, _ name: String, _ thumbnail: MACharThumbnailModel) {
        self.uid = uid
        self.name = name
        self.thumbnail = thumbnail
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
