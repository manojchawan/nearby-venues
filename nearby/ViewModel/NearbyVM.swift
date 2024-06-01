//
//  NearbyVM.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import Foundation

protocol NearbyVMProtocol {
   func getNearbyVenues()
    var lat: Double {get set}
    var lon: Double {get set}
    var currentPage: Int {get set}
}

protocol NearbyVenueProtocol{
    func updateData()
}

final class NearbyVM: NearbyVMProtocol {
    
    
    private var repository: NearbyRepositoryProtocol
    var lat : Double
    var lon : Double
    var currentPage: Int
    var range: Int
    var venues: [Venue]? = []
    var delegate: NearbyVenueProtocol?
    
    init(repository: NearbyRepositoryProtocol = NearbyRepository(), lat: Double, lon: Double){
        self.repository = repository
        self.lat = lat
        self.lon = lon
        currentPage = 1
        range = 12
    }
    
    
    
    func getNearbyVenues(){
        currentPage += 1
        repository.getVenues(lat: lat, lon: lon, page: currentPage, range: "\(range)mi", callback: { [weak self] result in
            self?.venues?.append(contentsOf: result ?? [])
            self?.delegate?.updateData()
        })
    }
    
}
