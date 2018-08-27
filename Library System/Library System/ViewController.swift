//
//  ViewController.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 30/03/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var res: UIButton!
    @IBOutlet weak var accountLable: UILabel!
    @IBOutlet weak var welcomeLable: UILabel!
    @IBOutlet weak var library: UIButton!
    @IBOutlet weak var imagelog: UIImageView!
    
    @IBOutlet weak var findLibrary: UIButton!
    
    var temp:String?
    var imagelll:NSData?
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        library.isHidden = true
        findLibrary.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnedSecond(segue: UIStoryboardSegue){
        
    }
    @IBAction func returnedSecondAfterLogin(segue: UIStoryboardSegue){
        imagelog.isHidden = false;
        loginButton.isHidden = true;
        accountLable.isHidden = true;
        res.isHidden = true;
        library.isHidden = false;
        welcomeLable.text = temp;
        imagelog.image = UIImage(data: imagelll! as Data)
        findLibrary.isHidden = false;
        
    }
    @IBAction func returnedLogout(segue: UIStoryboardSegue){
        library.isHidden = false;
        imagelog.isHidden = true;
        loginButton.isHidden = false;
        accountLable.isHidden = false;
        res.isHidden = false;
        library.isHidden = true;
        findLibrary.isHidden = true;
        welcomeLable.text = "WelCome!"
    }
}

