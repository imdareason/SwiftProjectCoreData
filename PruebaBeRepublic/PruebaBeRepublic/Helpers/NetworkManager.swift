//
//  NetworkManager.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol NetworkManagerProtocol {
    func getAllMedia(media: Array<Media>)->Void
}

class NetworkManager {
    //MARK: vars
    var tracksArray:Array<Media>?
    var delegate:NetworkManagerProtocol?
    
    //MARK: Methods
    func fetchAllMedia(url:String) -> Void{
        Alamofire.request(url).responseObject{ (response: DataResponse<MediaInfo>) in
            switch(response.result) {
            case .success:
                
                if let tracks = response.result.value{
                    self.tracksArray = tracks.allMedia!
                    self.delegate?.getAllMedia(media: self.tracksArray!)
                }
                
            case .failure:
                print("Network error")
            }
        }
    }
    
}
