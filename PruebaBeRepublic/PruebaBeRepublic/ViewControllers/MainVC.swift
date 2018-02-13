//
//  MainVC.swift
//  PruebaBeRepublic
//
//  Created by Erik on 25/6/17.
//  Copyright © 2017 Erik. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage


class MainVC:UIViewController  {
    
    //MARK: Vars&lets
    let cellReuseIdentifier = "mainCellID"
    var viewModel:ViewModel!
    
    //MARK: IBOutlets
    @IBOutlet
    weak var tableView: UITableView!
    @IBOutlet
    weak var searchBar: UISearchBar!
    @IBOutlet
    weak var filterSegmentedControl: UISegmentedControl!
    
    //MARK: methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        self.title = "Prueba BeRepublic"
        self.tableView.register(UINib(nibName: String(describing: MainCell.self), bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel() -> Void {
        viewModel = ViewModel.init()
        viewModel.delegate = self
    }
    
    func changeDateFormat(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let date: Date? = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func changeTimeFormat(time:String) -> String {
        
        let date = Date(timeIntervalSince1970: Double(time)!/1000)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: date)
    }
    
    //MARK: IBActions
    @IBAction func filterChanged(_ sender: Any) {
        if (viewModel.allMediaArray != nil) {
            switch filterSegmentedControl.selectedSegmentIndex {
                
            case 0:
                viewModel.allMediaArray.sort() { $0.trackTime > $1.trackTime }
                tableView.reloadData();
                
            case 1:
                viewModel.allMediaArray.sort() { $0.primaryGenreName > $1.primaryGenreName }
                tableView.reloadData();
                
            case 2:
                viewModel.allMediaArray.sort() { $0.trackPrice > $1.trackPrice }
                tableView.reloadData();
                
            default:
                break
            }

        }
        
    }
    
    
}

//MARK: TableViewDelegate and DataSource
extension MainVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MainCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MainCell
        
        if (self.viewModel.allMediaArray != nil) {
            cell.artistName.text = viewModel.allMediaArray[indexPath.row].artistName
            cell.collectionName.text = viewModel.allMediaArray[indexPath.row].collectionName
            cell.trackName.text = viewModel.allMediaArray[indexPath.row].trackName
            cell.primaryGenre.text = viewModel.allMediaArray[indexPath.row].primaryGenreName
            cell.releaseDate.text = changeDateFormat(date: viewModel.allMediaArray[indexPath.row].releaseDate)
            cell.trackPrice.text = String(viewModel.allMediaArray[indexPath.row].trackPrice)+"$"
            cell.trackTime.text = changeTimeFormat(time: String(viewModel.allMediaArray[indexPath.row].trackTime)
            )
            cell.artwork.af_setImage(withURL: URL(string:viewModel.allMediaArray[indexPath.row].artwork)!)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.viewModel.allMediaArray != nil) {
            return self.viewModel.allMediaArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (self.viewModel.allMediaArray != nil) {
            let detailVC = DetailVC.init(mediaArray: viewModel.allMediaArray, currentMedia: viewModel.allMediaArray[indexPath.row], currentIndex: indexPath.row)
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165;
    }
    
    
    
    
}

//MARK: SearchBarDelegate
extension MainVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchText = searchBar.text
        searchText = searchText?.replacingOccurrences(of: " ", with: "+")
        viewModel.fetchMedia(filter: searchText!)
    }
}

//MARK: ViewModelProtocol
extension MainVC:ViewModelProtocol {
    func allTracksLoaded() {
        tableView.reloadData()
    }
}

