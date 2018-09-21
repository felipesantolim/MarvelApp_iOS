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
            
            let chars: [MACharactersModel] = JSONValue["data"]["results"].arrayValue.map { value in
                
                let thumbnail = MACharThumbnailModel(
                    value["thumbnail"]["path"].stringValue,
                    _extension: value["thumbnail"]["extension"].stringValue)
                
                return MACharactersModel(value["id"].intValue,
                                         value["name"].stringValue,
                                         thumbnail,
                                         value["description"].stringValue,
                                         value["comics"]["available"].intValue,
                                         value["series"]["available"].intValue,
                                         value["stories"]["available"].intValue,
                                         value["events"]["available"].intValue)
            }
            completion(chars)
        }
    }
}
