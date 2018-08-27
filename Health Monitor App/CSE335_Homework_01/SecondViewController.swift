//
//  SecondViewController.swift
//  CSE335_Homework_01
//
//  Created by Yangkang Ou on 14/02/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var weightChange: UITextField!
    @IBOutlet weak var averagePressure: UITextField!
    @IBOutlet weak var totalBurned: UITextField!
    @IBOutlet weak var totalIntake: UITextField!
    
    var sumBurnedList:[String]?
    var intake:Double = 0.0
    var sumburned:Double = 0.0
    var average:Double = 0.0
    var weight:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.totalIntake.text = String(describing: round(100 * intake)/100)
        self.totalBurned.text = String(describing: round(100 * sumburned)/100)
        self.averagePressure.text = String(describing: round(100 * average)/100)
        self.weightChange.text = String(describing: round(100 * weight)/100)
    }
    
    struct Queue<Element>  {
        var items = [Element]()
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeFirst()
        }
        mutating func firstpeek() -> Element {
            return items.first!
        }
        mutating func pushFirst(_ item: Element) {
            items.insert(item, at: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
