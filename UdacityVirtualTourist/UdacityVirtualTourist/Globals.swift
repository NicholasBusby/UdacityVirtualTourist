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
}
