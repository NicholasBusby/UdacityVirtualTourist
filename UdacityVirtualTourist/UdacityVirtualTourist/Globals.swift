//
//  Globals.swift
//  UdacityVirtualTourist
//
//  Created by Nicholas Busby on 6/30/15.
//  Copyright (c) 2015 CareerBuilder. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Globals {
    static func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    static func managedContext() -> NSManagedObjectContext {
        return appDelegate().managedObjectContext!
    }
    
    static let flickrKey = "357c8418f453971714372a3453bbbd54"
    static let flickrSecret = "7468324ea14cd55f"
}
