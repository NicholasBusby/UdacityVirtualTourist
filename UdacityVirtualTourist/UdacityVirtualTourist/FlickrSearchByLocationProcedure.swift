//
//  FlickrSearchByLocationProcedure.swift
//  UdacityVirtualTourist
//
//  Created by Nicholas Busby on 7/24/15.
//  Copyright (c) 2015 CareerBuilder. All rights reserved.
//

import Foundation

class FlickrSearchByLocationProcedure {
    let url = "https://api.flickr.com/services/rest/"
    let method = "flickr.photos.search"
    var lat:Double = 0
    var lon:Double = 0
    var key:String = "";
    
    func searchByLocation(latitude:Double, longitude:Double, flickrKey:String) -> Array<FlickrSearchModel>{
        lat = latitude
        lon = longitude
        key = flickrKey
        let request = Http.getRequest(url, headers: [:], queryString: queryString())
        
        var response = [FlickrSearchModel(), FlickrSearchModel()];
        return response;
    }
    
    func queryString() -> [String: String] {
        let qsVars = [
            "method": method,
            "lat": "\(lat)",
            "lon": "\(lon)",
            "api_key": key
        ]
        return qsVars
    }
}