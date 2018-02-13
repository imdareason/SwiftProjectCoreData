//
//  Model.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation


protocol ModelProtocol {
    func allMediaToViewModel(media:Array<Media>)
}

class Model {
    //MARK: Vars&lets
    let baseUrl = "https://itunes.apple.com/search?term="
    var kUrl:String!
    var delegate:ModelProtocol?
    private var networkManager:NetworkManager!
    
    //MARK: Methods
    init() {
        networkManager = NetworkManager()
        networkManager.delegate = self
    }
    
    func fetchAllMedia(searchText:String) -> Void {
        kUrl = baseUrl+searchText
        networkManager.fetchAllMedia(url: kUrl)
    }
    
    
}

extension Model:NetworkManagerProtocol{
    //MARK: NetworkManagerProtocol
    func getAllMedia(media: Array<Media>) {
        delegate?.allMediaToViewModel(media: media)
    }
}
