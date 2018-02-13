//
//  DetailVC.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import AlamofireImage
import Social

class DetailVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet
    weak var imageView: UIImageView!
    @IBOutlet
    weak var artistName: UILabel!
    @IBOutlet
    weak var mediaName: UILabel!
    @IBOutlet
    weak var playButton: UIButton!
    @IBOutlet
    weak var backButton: UIButton!
    @IBOutlet
    weak var forwardButton: UIButton!
    
    //MARK: Vars&lets
    var mediaArray:Array<Media>!
    var currentMedia:Media!
    var currentIndex:Int!
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    var isPlaying = false
    
    
    //MARK: Methods
    init(mediaArray:Array<Any>,currentMedia:Media, currentIndex:Int) {
        self.mediaArray = mediaArray as! Array<Media>
        self.currentMedia = currentMedia
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() -> Void {
        self.artistName.text = currentMedia.artistName
        self.mediaName.text = currentMedia.trackName
        self.imageView.af_setImage(withURL: (URL(string: currentMedia.artwork))!)
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: IBActions
    @IBAction func playTapped(_ sender: Any) {
        if !isPlaying {
            let url = URL(string: currentMedia.previewUrl)
            playerItem = AVPlayerItem(url: url!)
            player=AVPlayer(playerItem: playerItem!)
            player?.play()
            isPlaying = true
        }else{
            player?.pause()
            isPlaying = false
        }
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if currentIndex-1>=0 {
            currentMedia = mediaArray[currentIndex-1]
            currentIndex = currentIndex-1
            player?.pause()
            updateUI()
        }
        
    }
    
    @IBAction func forwardTapped(_ sender: Any) {
        if currentIndex+1<=mediaArray.count {
            currentMedia = mediaArray[currentIndex+1]
            currentIndex = currentIndex+1
            player?.pause()
            updateUI()
        }
    }
    @IBAction func shareTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Share this content", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let twitterAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterComposeVC?.setInitialText("Watch this out!"+self.currentMedia.trackName)
                self.present(twitterComposeVC!, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not logged in to your Twitter account.")
            }
        }
        
        
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookComposeVC?.setInitialText("Watch this out!"+self.currentMedia.trackName)
                
                self.present(facebookComposeVC!, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not connected to your Facebook account.")
            }
        }
        
        alertController.addAction(twitterAction)
        alertController.addAction(facebookPostAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}
