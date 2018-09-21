//
//  MAProviderProtocol.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON

public typealias MAProviderResultCallback = (_ data: JSON?) -> ()

public protocol MAProviderProtocol {
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MAProviderResultCallback)
}
