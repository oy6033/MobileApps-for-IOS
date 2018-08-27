//
//  ViewController.swift
//  Lab_08
//
//  Created by Yangkang Ou on 2018/4/18.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var monkey: UIImageView!
    @IBOutlet weak var Timerx: UILabel!
    @IBOutlet weak var Message: UILabel!
    var t:Timer?
    var counter = 0;
    var check1 = false;
    var check2 = false;
    var check3 = false;
    var check4 = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.monkey.image = UIImage(named: "monkey.jpeg")
        self.image1.image = UIImage(named: "apple.jpg")
        self.image2.image = UIImage(named: "apple.jpg")
        self.image3.image = UIImage(named: "apple.jpg")
        self.image4.image = UIImage(named: "apple.jpg")
        t = Timer();
        t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewIntersectsView(_ first_View: UIView, second_View:UIView) -> Bool
    {
        return first_View.frame.intersects(second_View.frame)
    }
    
    func winGame(check1:Bool,check2:Bool,check3:Bool,check4:Bool){
        if( check1 == true && check2 == true && check3 == true && check4 == true && counter<10){
            Message.text = "Win < 10 sec"
           t?.invalidate()
        }else if(check1 == true && check2 == true && check3 == true && check4 == true && counter>10){
            Message.text = "lose > 10 sec"
            t?.invalidate()
        }
    }
    @objc func count()
    {
        counter = counter + 1
        Timerx.text  = String( counter)
    }
    
    @IBAction func up(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.y -= 20
        self.monkey.frame =  frame
        
        if(viewIntersectsView(monkey, second_View: image1))
        {
            self.image1.isHidden = true
            check1 = true;
        }else if(viewIntersectsView(monkey, second_View: image2)){
            self.image2.isHidden = true
            check2 = true;
        }else if(viewIntersectsView(monkey, second_View: image3)){
            self.image3.isHidden = true
            check3 = true;
        } else if(viewIntersectsView(monkey, second_View: image4)){
            self.image4.isHidden = true
            check4 = true;
            
        }
        winGame(check1: check1, check2: check2, check3: check3, check4: check4)
    }
    
    @IBAction func down(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.y += 20
        self.monkey.frame =  frame
        
        if(viewIntersectsView(monkey, second_View: image1))
        {
            self.image1.isHidden = true
            check1 = true;
        }else if(viewIntersectsView(monkey, second_View: image2)){
            self.image2.isHidden = true
            check2 = true;
        }else if(viewIntersectsView(monkey, second_View: image3)){
            self.image3.isHidden = true
            check3 = true;
        } else if(viewIntersectsView(monkey, second_View: image4)){
            self.image4.isHidden = true
            check4 = true;
            
        }
        winGame(check1: check1, check2: check2, check3: check3, check4: check4)
        
    }
    @IBAction func left(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.x -= 20
        self.monkey.frame =  frame
        
        if(viewIntersectsView(monkey, second_View: image1))
        {
            self.image1.isHidden = true
            check1 = true;
        }else if(viewIntersectsView(monkey, second_View: image2)){
            self.image2.isHidden = true
            check2 = true;
        }else if(viewIntersectsView(monkey, second_View: image3)){
            self.image3.isHidden = true
            check3 = true;
        } else if(viewIntersectsView(monkey, second_View: image4)){
            self.image4.isHidden = true
            check4 = true;
            
        }
        winGame(check1: check1, check2: check2, check3: check3, check4: check4)
        
    }
    
    @IBAction func Right(_ sender: Any) {
        var frame  = self.monkey.frame
        frame.origin.x += 20
        self.monkey.frame =  frame
        
        if(viewIntersectsView(monkey, second_View: image1))
        {
            self.image1.isHidden = true
            check1 = true;
        }else if(viewIntersectsView(monkey, second_View: image2)){
            self.image2.isHidden = true
            check2 = true;
        }else if(viewIntersectsView(monkey, second_View: image3)){
            self.image3.isHidden = true
            check3 = true;
        } else if(viewIntersectsView(monkey, second_View: image4)){
            self.image4.isHidden = true
            check4 = true;
            
        }
        winGame(check1: check1, check2: check2, check3: check3, check4: check4)
    }
}

