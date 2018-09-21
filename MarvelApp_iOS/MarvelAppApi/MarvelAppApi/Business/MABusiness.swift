//
//  MABusiness.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON

class MABusiness: MABusinessProtocol {
    
    public static let shared = MABusiness()
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MABusinessResultCallback) {
        
        _ = MAProvider.shared.fetchAllCharacters(with: pg) { _data in
            guard let `JSONValue` = _data else { return completion(nil) }
            
            let chars: [MACharactersModel] = JSONValue[MACharactersModel.KeyData][MACharactersModel.KeyResults]
                .arrayValue.map { value in
                
                let thumbnail = MACharThumbnailModel(
                    value[MACharactersModel.KeyThumbnail][MACharactersModel.KeyPath].stringValue,
                    _extension: value[MACharactersModel.KeyThumbnail][MACharactersModel.KeyExtension].stringValue)
                
                return MACharactersModel(value[MACharactersModel.KeyUid].intValue,
                                         value[MACharactersModel.KeyName].stringValue,
                                         thumbnail,
                                         value[MACharactersModel.KeyDescription].stringValue,
                                         value[MACharactersModel.KeyComics][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeySeries][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeyStories][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeyEvents][MACharactersModel.KeyAvailable].intValue)
            }
            completion(chars)
        }
    }
}
