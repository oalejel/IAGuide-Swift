//
//  MapViewController.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/11/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    var filterByTeacher = false //setting this to 'true' sets the tableview search rooms by teacher
    var inputViewIsToggled = false
    var editingTextField = false
    var viewAppearedBefore = false //to be used in viewwillappear to check if this happened
    var searchViewRect: CGRect!//used to return inputview frame to original size after animation
    var roomTable: LocationTable!
    var initialMapRegion: MKCoordinateRegion!//locatation of school
    var locationManager: CLLocationManager! //MIGHT need this property. guessing ARC will kill if not
    @IBOutlet weak var mapView: MKMapView!//shows room locations/pinview callouts trigger InfoViewController
    @IBOutlet weak var toggleButton: UIButton! //toggle table with room/teacher choices
    @IBOutlet weak var searchField: UITextField!//to search by room/possibly teachers
    @IBOutlet weak var headerView: UIView!//blue box above map that says "find your way"
    @IBOutlet weak var roomSearchView: UIView!//contains textfield and tableview
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //get the 2 images to be set for its tab bar icon
        let image = UIImage(named: "comapass")
        let selectedImage = UIImage(named: "compass_sel")
        tabBarItem = UITabBarItem(title: "Map", image: image, selectedImage: selectedImage)
    }
    
    required init(coder aDecoder: NSCoder) {
        //unimportant
        super.init(coder: aDecoder)
    }
//MARK: View Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //ask the user for permission to track location on the background thread (so no interruption)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            if self.locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")) {
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            }
        })
        //set up the map
        mapView.delegate = self
        mapView.mapType = .Satellite
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .None
        //keep user from changing the map location, angle, & zoom
        mapView.zoomEnabled = false
        mapView.rotateEnabled = false
        mapView.scrollEnabled = false
        //make it transparent until it loads
        mapView.alpha = 0
        
        //set textfield delegate
        searchField.delegate = self
        //get message when filter is changed
        filterSegmentControl.addTarget(self, action: Selector("roomTableFilterChanged:"), forControlEvents: .ValueChanged)
        //initialize the room search table
        roomTable = LocationTable(frame: CGRectZero)//??change
        
        setLocation()
        setRotation()
    }

    override func viewWillAppear(animated: Bool) {
        //called before the view is actually seen by the user
        super.viewWillAppear(animated)
        //i only want to draw a gradient in the background the first time the view appears
        if !viewAppearedBefore {
            setBackgroundGradient()
            addSchoolOverlayToMap()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //called when the view is actually seen by the user
        super.viewDidAppear(animated)
        if !viewAppearedBefore {
            //hold on to the frame of the box so that it can return to its original shape after resizing it
            searchViewRect = roomSearchView.frame
            //set viewappeared to true
            viewAppearedBefore = true
        }
    }
    
    func setBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        //set the colors of the gradient
        let color1 = UIColor(red: 0.4117, green: 0.8627, blue: 1, alpha: 1)
        let color2 = UIColor(red: 0, green: 0.17, blue: 0.9, alpha: 1)
        gradientLayer.colors = [color1, color2]
        //add the gradient layer to the view layer
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func addSchoolOverlayToMap() {
        //create a circle and with a given center and radius and a polygon to put the map image in
        var polygonPoints = [CLLocationCoordinate2DMake(42.602941, -83.225584),
            CLLocationCoordinate2DMake(42.602941, -83.226743),
            CLLocationCoordinate2DMake(42.603796, -83.226743),
            CLLocationCoordinate2DMake(42.603796, -83.225584)]
        let polygon = MKPolygon(coordinates: &polygonPoints, count: 4)
        mapView.addOverlay(polygon)
        
        let circle = MKCircle(centerCoordinate: CLLocationCoordinate2DMake(42.603373, -83.226150), radius: 400)
        mapView.addOverlay(circle)
    }
//MARK: Map
    func setLocation() {
        //give the map a start location
        let lat: CLLocationDegrees = 42.603373
        let lon: CLLocationDegrees = -83.226150
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let schoolRegion = MKCoordinateRegionMakeWithDistance(center, 155, 100)
        let fittingRegion = mapView.regionThatFits(schoolRegion)
        //save the region so that we ca readjust
        initialMapRegion = fittingRegion
        mapView.setRegion(fittingRegion, animated: false)
    }
    
    func setRotation() {
        let camera = mapView.camera.copy() as! MKMapCamera
        camera.heading = 179.0
        mapView.setCamera(camera, animated: false)
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView!) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.mapView.alpha = 1
        })
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        //need to check class since not all annotations are custom (i.e. the current location annotation)
        if let loc = view.annotation as? Location {
            let ivc = InfoViewController()//pass the annotation!!
        }
    }
}
