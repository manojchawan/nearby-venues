//
//  ViewController.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var venueTable: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    var locationHelper = LocationHelper()
    var viewModel: NearbyVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup(){
        locationHelper.delegate = self
        loaderView.isHidden = false
        loaderView.startAnimating()
        venueTable.dataSource = self
        venueTable.delegate = self
        
        venueTable.registerNib(type: VenueTVC.self)
       
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: VenueTVC.self, indexPath: indexPath)
        cell.venue = viewModel?.venues?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel?.venues?.count ?? 0) - 2 {
            viewModel?.getNearbyVenues()
        }
    }
}


extension ViewController : LocationProtocol{
    func sendLocationData(location : CLLocation){

        viewModel = NearbyVM(lat: Double(location.coordinate.latitude), lon: Double(location.coordinate.longitude))
        viewModel?.delegate = self
        viewModel?.getNearbyVenues()
    }
}

extension ViewController: NearbyVenueProtocol{
    func updateData() {
        
        DispatchQueue.main.async {
            self.loaderView.stopAnimating()
            self.loaderView.isHidden = true
            self.venueTable.reloadData()
        }
    }
}
