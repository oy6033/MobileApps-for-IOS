//
//  Login.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RegisterController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var imageSelect: UIImageView!
    @IBOutlet weak var imageSource: UISegmentedControl!
    var t:Timer?
    var counter = 3;
    var disCout:String?
    let picker = UIImagePickerController()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    @IBAction func Save(_ sender: Any) {
        let ent = NSEntityDescription.entity(forEntityName: "Login", in: self.managedObjectContext)
        let log = Login(entity: ent!, insertInto: managedObjectContext)
        if(self.imageSelect.image == nil){
            let alert = UIAlertController(title: "Warning", message: "please pick a image", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            log.username = username.text!
            log.password = password.text!
            log.email = email.text!
            log.image = UIImagePNGRepresentation(self.imageSelect.image!) as NSData?
            do {
                try self.managedObjectContext.save()
            } catch _ {
            }
            print(log)
            t = Timer();
            
            let alert = UIAlertController(title: "congratulation", message: log.username!+", you register successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                self.performSegue(withIdentifier: "reg", sender: self)
            }))
            self.present(alert, animated: true){
            }

        }
    }
    
    @objc func count()
    {
        counter = counter - 1
        disCout = String(counter)
    }
    
    @IBAction func image(_ sender: Any) {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        picker .dismiss(animated: true, completion: nil)
        imageSelect.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }

}

