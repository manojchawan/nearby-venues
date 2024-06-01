//
//  VenueResponse.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import Foundation
struct VenueResponse: Decodable {
    let venues : [Venue]?
}

struct Venue: Decodable{
    let name : String
    let url : String
    let address : String
    
}
