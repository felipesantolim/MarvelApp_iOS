//
//  MAServiceHTTP.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import Foundation

struct KeyDict {
    public var publicKey: String = ""
    public var privateKey: String = ""
}

class MAServiceHTTP {
    public static let shared = MAServiceHTTP()
}

extension MAServiceHTTP {

    public func getKeys() -> KeyDict {
        
        if let path = Bundle.main.path(forResource: "Service", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            if let publicKey = dict["publicKey"], !publicKey.isEmpty,
                let privateKey = dict["privateKey"], !privateKey.isEmpty {
                return KeyDict(publicKey: publicKey, privateKey: privateKey)
            }
            return KeyDict(publicKey: "", privateKey: "")
        }
        return KeyDict(publicKey: "", privateKey: "")
    }
}

extension MAServiceHTTP {
    
    public func getUrl() -> URL {
        
        if let path = Bundle.main.path(forResource: "Service", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            if let urlBase = dict["urlBase"], !urlBase.isEmpty {
                return URL(string: urlBase)!
            }
            return URL(string: "")!
        }
        return URL(string: "")!
    }
}
