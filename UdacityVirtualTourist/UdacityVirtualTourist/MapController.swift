//
//  MapController.swift
//  UdacityVirtualTourist
//
//  Created by Nicholas Busby on 6/30/15.
//  Copyright (c) 2015 CareerBuilder. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapController: UIViewController, MKMapViewDelegate {
    var regions = [NSManagedObject]()
    
    @IBOutlet var longPressGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var map: MKMapView!
    
    override func viewWillAppear(animated: Bool) {

        let fetchRequest = NSFetchRequest(entityName:"MapRegion")
        
        var error: NSError?
        
        let fetchedResults = Globals.managedContext().executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            self.regions = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        if regions.count > 0 {
            let latitude = self.regions.first!.valueForKey("latitude") as! Double
            let longitude = self.regions.first!.valueForKey("longitude") as! Double
            let width = self.regions.first!.valueForKey("width") as! Double
            let height = self.regions.first!.valueForKey("height") as! Double
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: width, longitudeDelta: height)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            map.region = region
        }
        
        let pinsFetch = NSFetchRequest(entityName: "Pin")
        let pinResults = Globals.managedContext().executeFetchRequest(pinsFetch, error: &error) as? [NSManagedObject]
        if let pins = pinResults {
            for pin in pins {
                var annotation = MKPointAnnotation()
                var location = CLLocationCoordinate2D(latitude: (pin.valueForKey("latitude") as! Double), longitude: (pin.valueForKey("longitude") as! Double))
                annotation.coordinate = location
                map.addAnnotation(annotation)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        map.delegate = self
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        let entity = NSEntityDescription.entityForName("MapRegion", inManagedObjectContext: Globals.managedContext())
        let mapRegion = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: Globals.managedContext())
        
        mapRegion.setValue(mapView.region.center.latitude, forKey: "latitude")
        mapRegion.setValue(mapView.region.center.longitude, forKey: "longitude")
        mapRegion.setValue(mapView.region.span.latitudeDelta , forKey: "width")
        mapRegion.setValue(mapView.region.span.longitudeDelta, forKey: "height")

        for reg:NSManagedObject in self.regions {
            Globals.managedContext().deleteObject(reg)
        }
        
        var error: NSError?
        if !Globals.managedContext().save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        self.regions = [mapRegion]
    }
    
    
    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let touchSpot = sender.locationInView(map)
            let mapPoint = map.convertPoint(touchSpot, toCoordinateFromView: map)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = mapPoint
            map.addAnnotation(annotation)
            
            let entity = NSEntityDescription.entityForName("Pin", inManagedObjectContext: Globals.managedContext())
            let pin = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: Globals.managedContext())
            
            pin.setValue(mapPoint.latitude, forKey: "latitude")
            pin.setValue(mapPoint.longitude, forKey: "longitude")
            
            var error: NSError?
            if !Globals.managedContext().save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
}
