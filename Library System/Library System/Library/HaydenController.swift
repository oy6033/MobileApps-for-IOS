//
//  HaydenController.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/23.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
import UIKit
class HaydenController: UIViewController{
    var bookName: String?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(bookName == "Dictionary"){
            name.text = bookName
            textArea.text = "1.Robert Cawdrey’s A Table Alphabeticall\n2.BE’s New Dictionary of the Canting Crew \n3.Samuel Johnson’s Dictionary of the English Language"
        }else if (bookName == "Novel"){
            name.text = bookName
            textArea.text = "1.Ulysses\n2.A Portrait of the Artist as a Young Man \n3.The Sound and the Fury"
        }else if (bookName == "Law"){
            name.text = bookName
            textArea.text = "1.The Constitution of the United States of America, with all of the Amendments; The Declaration of Independence; and The Articles of Confederation\n2.The Federalist Papers \n3.Law 101 "
        }else if (bookName == "Science" ){
            name.text = bookName
         textArea.text = "1.The Accidental Universe ALAN LIGHTMAN\n2.Asap Science\n3.Bad Science "
        }else{
            name.text = bookName
        textArea.text = "1.Anant Agarwal\n2.Marybeth Gasman\n3.Diane Ravitch "
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
