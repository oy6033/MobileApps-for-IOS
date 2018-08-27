//
//  mapController.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class mapController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var lon: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var foodtextfiled: UITextField!
    @IBOutlet weak var address: UITextField!
    
    var currentPlacemark: CLPlacemark?
    var sourcePlacemark: CLPlacemark?
    var destinationPlacemark: CLPlacemark?
    var currentTransportType = MKDirectionsTransportType.automobile
    var currentRoute: MKRoute?
    var name_copy:String?
    var coords: CLLocationCoordinate2D?
    var totalDic = [String: AnyObject]()
    var arrary = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self;
        if #available(iOS 9.0, *) {
            map.showsCompass = true
            map.showsScale = true
            map.showsTraffic = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
            //      print(keyboardSize.height)
        }
    }
    func showLocation(addressString:String){
        let geoCoder = CLGeocoder();
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    self.lat.text = "\(round(coords.latitude*100)/100)"
                    self.lon.text = "\(round(coords.longitude*100)/100)"
                    print(location)
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    self.map.addAnnotation(ani)
                }
        })
    }
    @IBAction func SearchLocation(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Library Address", message: "Hayden: 300 E Orage Mall, Tempe\nNoble: 601 E Tyler Mall, Tempe\nPolytechnic: 5988 S Backus Mall, Mesa\nWest: 4701 W Thunderbird Rd, Glendale", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Library Address"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                self.showLocation(addressString: name);
                self.name_copy = name;
            }
        }))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func food(_ sender: Any) {
        self.map.removeAnnotations(map.annotations)
        let request = MKLocalSearchRequest();
        request.naturalLanguageQuery=foodtextfiled.text!
        request.region=map.region
        let button=MKLocalSearch(request: request)
        button.start{response,_ in
            guard let response = response else{
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count-1{
                let place = matchingItems[i].placemark
                let x = coffee(title: place.name!, coordinate: CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude), info: place.countryCode!)
                print(place.name)
                self.map.addAnnotation(x)

            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation1()
    {
        let geoCoder = CLGeocoder();
        let addressString = "699, S. Mill Ave, Tempe, AZ, 85281"
        //let addressString = address.text!
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    self.destinationPlacemark = placemark
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(location)
                    
                    let span = MKCoordinateSpanMake(0.5, 0.5)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = "Current"
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                    self.getLocation2()
                }
        })
    }
    
    func getLocation2()
    {
        let geoCoder = CLGeocoder();
        let addressString = self.name_copy
        //let addressString = address.text!
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    self.sourcePlacemark = placemark
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(location)
                    
                    let span = MKCoordinateSpanMake(0.5, 0.5)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    if(self.name_copy == "300 E Orage Mall, Tempe"){
                        ani.title = "Hayden"
                    }else if(self.name_copy == "601 E Tyler Mall, Tempe"){
                        ani.title = "Noble"
                    }else{
                         ani.title = placemark.locality
                    }
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                    // show directions once both locations are done
                    self.showDirections()
                }
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = (currentTransportType == .automobile) ? UIColor.blue : UIColor.orange
        renderer.lineWidth = 3.0
        
        return renderer
    }
    
    func showDirections()
    {
        // get the directions
        let directionRequest = MKDirectionsRequest()
        
        // Set the source and destination of the route
        let sourcePM = MKPlacemark(placemark: self.sourcePlacemark!)
        directionRequest.source = MKMapItem(placemark: sourcePM)
        
        //directionRequest.source = MKMapItem.forCurrentLocation()
        
        let destinationPM = MKPlacemark(placemark: self.destinationPlacemark!)
        directionRequest.destination = MKMapItem(placemark: destinationPM)
        
        directionRequest.transportType = currentTransportType
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { (routeResponse, routeError) -> Void in
            
            guard let routeResponse = routeResponse else {
                if let routeError = routeError {
                    print("Error: \(routeError)")
                }
                
                return
            }
            
            let route = routeResponse.routes[0]
            print("Printing route")
            print(route)
            
            self.currentRoute = route
            self.map.removeOverlays(self.map.overlays)
            self.map.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
    }
    @IBAction func getDir(_ sender: Any) {
        getLocation1();
    }
    
    func getJsonData(){
        let urlAsString = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat.text!+","+lon.text!+"&key=AIzaSyBVI4SJ8OYHR3pUkcikSGGZUhXwOWv2vVA"
        let url = URL(string: urlAsString as! String)!
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            //print(jsonResult)
            
            let setOne:NSArray = jsonResult["results"] as! NSArray
                let y = setOne[0] as? [String: AnyObject]
            DispatchQueue.main.async {
                 self.address.text = y?["formatted_address"] as? String
            
            }
            
            
        })
        
        jsonQuery.resume()
    }
    
    @IBAction func getJson(_ sender: Any) {
        getJsonData()
    }
}
