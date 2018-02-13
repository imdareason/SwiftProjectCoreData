//
//  MainCell.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation
import UIKit

class MainCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet
    weak var artistName: UILabel!
    @IBOutlet
    weak var trackName: UILabel!
    @IBOutlet
    weak var artwork: UIImageView!
    @IBOutlet
    weak var collectionName: UILabel!
    @IBOutlet
    weak var releaseDate: UILabel!
    @IBOutlet
    weak var trackTime: UILabel!
    @IBOutlet
    weak var primaryGenre: UILabel!
    @IBOutlet
    weak var trackPrice: UILabel!
}
