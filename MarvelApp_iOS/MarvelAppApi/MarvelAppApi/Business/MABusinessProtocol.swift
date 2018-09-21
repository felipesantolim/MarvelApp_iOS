//
//  MABusinessProtocol.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public typealias MABusinessResultCallback = (_ model: [MACharactersModel]?) -> ()

public protocol MABusinessProtocol {
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MABusinessResultCallback)
}
