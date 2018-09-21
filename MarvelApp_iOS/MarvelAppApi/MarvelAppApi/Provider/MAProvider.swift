//
//  MAProvider.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CryptoSwift

class MAProvider: MAProviderProtocol {
    
    public static let shared = MAProvider()
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MAProviderResultCallback) {
        if let `pg` = pg {
            rx_callApi(with: MAServiceHTTP.shared.getUrl(), page: pg) { _JSON in completion(_JSON) }
        }
    }
}

extension MAProvider {
    
    fileprivate func rx_callApi(with url: URL, page: Int, completion: @escaping (_ data: JSON?) -> ()) {

        let keys = MAServiceHTTP.shared.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let params: Parameters = [
            "apikey": keys.publicKey,
            "ts": ts,
            "hash": (ts + keys.privateKey + keys.publicKey).md5(),
            "orderBy": "name",
            "limit" : 21,
            "offset" : page,
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString),
                          headers: nil).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
