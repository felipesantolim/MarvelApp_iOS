//
//  MAManager.swift
//  MarvelAppApi
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public class MAManager: MAManagerProtocol {
    
    public static let shared = MAManager()
    
    public func fetchAllCharacters(with pg: Int?, _ completion: @escaping MAManagerResultCallback) {
        MABusiness.shared.fetchAllCharacters(with: pg, completion)
    }
}
