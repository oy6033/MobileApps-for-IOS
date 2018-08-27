//
//  ViewController.swift
//  CSE335_Homework_01
//
//  Created by Yangkang Ou on 13/02/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var countRecrod: UILabel!
    @IBOutlet weak var running: UITextField!
    @IBOutlet weak var strenght: UITextField!
    @IBOutlet weak var food: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var blood: UITextField!
    var weeklyInfo: weeklyQueue = weeklyQueue()
    var cal: calculation = calculation()
    var textViewHeight1: CGFloat!
    var textViewHeight2: CGFloat!
    var originLabel : CGFloat!
    
    var count = 0
    var running_v = 0.0
    var strenght_v = 0.0
    var food_v = 0.0
    var weight_v = 0.0
    var blood_v = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        running.text = String(running_v)
        strenght.text = String(strenght_v)
        food.text = String(food_v)
        weight.text = String(weight_v)
        blood.text = String(blood_v)
        running.delegate = self
        strenght.delegate = self
        food.delegate = self
        weight.delegate = self
        blood.delegate = self
        textViewHeight1 = weight.frame.origin.y
        textViewHeight2 = blood.frame.origin.y
        originLabel = countRecrod.frame.origin.y
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == running{
            strenght.becomeFirstResponder()
        }
        else if textField == strenght{
            food.becomeFirstResponder()
        } else if textField == food{
            weight.becomeFirstResponder()
        }else if textField == weight{
            blood.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0  && self.weight.isEditing{
                self.countRecrod.frame.origin.y = originLabel
                self.view.frame.origin.y -= keyboardSize.height
            }else if self.view.frame.origin.y == 0  && self.blood.isEditing{
                self.countRecrod.frame.origin.y = originLabel
                self.view.frame.origin.y -= keyboardSize.height
            }else if self.running.isEditing{
                self.countRecrod.frame.origin.y = originLabel
                self.countRecrod.frame.origin.y -=
                    keyboardSize.height
            }else if self.strenght.isEditing{
                self.countRecrod.frame.origin.y = originLabel
                self.countRecrod.frame.origin.y -=
                    keyboardSize.height
            }else if self.food.isEditing{
                self.countRecrod.frame.origin.y = originLabel
                self.countRecrod.frame.origin.y -=
                    keyboardSize.height
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
            //      print(keyboardSize.height)
        }
        self.countRecrod.frame.origin.y = originLabel
    }
    
    
    func isStringAnInt(string: String) -> Bool {
        if(Double(string) != nil && string != "" && Double(string) != 0){
            return true;
        }
        return false;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sumFunction = cal.sum(sumAll: weeklyInfo.queueRecord)
        if segue.identifier == "Detail" && count >= 7
        {
            let des = segue.destination as! SecondViewController
            if food.text != ""{
                des.intake = sumFunction.intake
                print(sumFunction.intake)
            }
            if running.text != "" && strenght.text != ""{
                des.sumburned = sumFunction.burned
                print(sumFunction.burned)
            }
            if blood.text != ""{
                des.average = sumFunction.average
                print(sumFunction.average)
            }
            if weight.text != ""{
                des.weight = sumFunction.change
                print(sumFunction.change)
            }
        }
        else{
            let alert = UIAlertController(title: "records not encough Error", message: "Please enter at least 7 records to show the weekly record", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        cal.sumIntake = 0
        cal.sumBurned = 0
        cal.average = 0
        cal.weightChange = 0
        
    }
    
    @IBAction func add(_ sender: Any) {
        let R = running.text!
        let S = strenght.text!
        let F = food.text!
        let W = weight.text!
        let B = blood.text!
        if(isStringAnInt(string: R) && isStringAnInt(string: S) && isStringAnInt(string: F) && isStringAnInt(string: W) && isStringAnInt(string: B)){
            
            let weeklyr = userReacord(r: Double(R)!, e: Double(S)!, f: Double(F)!, w: Double(W)!, b: Double(B)!)
            weeklyInfo.add(u: weeklyr)
            count = count + 1
            countRecrod.text! = "\(count)th record added"
            print(count)
        }
        else{
            let alert = UIAlertController(title: "Data Input Error", message: "Data Inputs are either empty or incorrect types", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
        
        //print(weeklyInfo.queueWeekly.pop().exerciesBurned)
    }
    
    
    @IBAction func randomSet(_ sender: UIButton) {
        
        //random number
        running.text = String(Double(arc4random_uniform(100)+1))
        strenght.text = String(Double(arc4random_uniform(100)+1))
        food.text = String(Double(arc4random_uniform(100)+1))
        weight.text = String(Double(arc4random_uniform(100)+1))
        blood.text = String(Double(arc4random_uniform(100)+1))
        
        //color
        running.textColor = UIColor.red
        strenght.textColor = UIColor.red
        food.textColor = UIColor.red
        weight.textColor = UIColor.red
        blood.textColor = UIColor.red
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnedSecond(segue: UIStoryboardSegue){
    }
    
}

