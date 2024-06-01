//
//  NearbyRepository.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import Foundation

protocol NearbyRepositoryProtocol{
    func getVenues(lat: Double, lon: Double, page: Int, range: String, callback: @escaping(([Venue]?) -> Void))
}


class NearbyRepository: NearbyRepositoryProtocol {
    

    func getVenues(lat: Double, lon: Double, page: Int, range: String, callback: @escaping (([Venue]?) -> Void)) {
        
        var urlComponent = URLComponents(string: NearbyConstants.url)!
        
        urlComponent.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "range", value: range),
            URLQueryItem(name: "client_id", value: NearbyConstants.clientId)
        ]
        
        var urlReq = URLRequest(url: urlComponent.url!)
        urlReq.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: urlReq){ (data, response, error) in
            
            guard data != nil else {
                print("data is nil")
                return
            }
          
            do{
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode(VenueResponse.self, from: data!)
                print("success")
                callback(decodedData.venues)
//                delegate?.sendVenues(data: decodedData.venues)
            }catch{
                print("failed")
            }
            
        }.resume()
        
    }
    
    
    
}
