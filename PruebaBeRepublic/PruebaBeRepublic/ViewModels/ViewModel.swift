//
//  ViewModel.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    func allTracksLoaded() -> Void
}

class ViewModel:ModelProtocol {
    
    //MARK: Vars&lets
    var model:Model!
    
    var allMediaArray:Array<Media>!
    
    var delegate:ViewModelProtocol!
    
    
    //MARK: Methods
    init() {
        model = Model()
        model.delegate = self
    }
    
    func fetchMedia(filter:String) -> Void {
        model.fetchAllMedia(searchText: filter)
    }
    
    //MARK: ModelProtocol
    func allMediaToViewModel(media: Array<Media>) {
        self.allMediaArray = media
        self.delegate.allTracksLoaded()
    }
}
