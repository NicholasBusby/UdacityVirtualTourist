//
//  FlickrService.swift
//  UdacityVirtualTourist
//
//  Created by Nicholas Busby on 7/24/15.
//  Copyright (c) 2015 CareerBuilder. All rights reserved.
//

import Foundation

class FlickrService {
    private var locationSearchProcedure = FlickrSearchByLocationProcedure()
    private let flickrKey = "357c8418f453971714372a3453bbbd54"
    
    init() {
        locationSearchProcedure = buildLocationSearchProcedure()
    }
    
    func searchByLocation(latitude:Double, longitude:Double) -> Array<FlickrSearchModel> {
        return locationSearchProcedure.searchByLocation(latitude, longitude: longitude, flickrKey: flickrKey)
    }
    
    private func buildLocationSearchProcedure() -> FlickrSearchByLocationProcedure {
        return FlickrSearchByLocationProcedure()
    }
}