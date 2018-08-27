//
//  LoginController1.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LoginController:UIViewController,UINavigationControllerDelegate{
    @IBOutlet weak var loginUserName: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    var   fetchResults =   [Login]()
    var correct: Bool = false
    var tuxiang:NSData?
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Login])!
        
        
        x = fetchResults.count
        // return howmany entities in the coreData
        return x
        
    }
    //performSegue(withIdentifier: "account", sender: self)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "account"&&correct == true){
            if let viewController: ViewController = segue.destination as? ViewController {
                viewController.temp = "Welcome!  " + loginUserName.text! + " Login successfully"
                
                viewController.imagelll = tuxiang
                
                print("1")
            }
        }
    }
    @IBAction func login(_ sender: Any) {
        
        print(fetchRecord());
        for element in fetchResults{
            if(element.username == loginUserName.text! && element.password == loginPassword.text!){
                correct = true
                tuxiang = element.image
                break;
            }
        }
        if(correct == true){
            print("Login successfully")
            performSegue(withIdentifier: "account", sender: self)
        }else{
            let alert = UIAlertController(title: "Warning", message: "password or username incorrect", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            print("password or username incorrect")
        }
    }
    
    @IBAction func Delete_all(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        // performs the batch delete for the contact
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
            
        }
        catch let _ as NSError {
            // Handle error
        }
    }
    
}

