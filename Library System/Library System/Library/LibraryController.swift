//
//  LibraryController.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
import UIKit

class LibraryController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var myBookList: books =  books()
    var count = 0
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookList.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LibraryCellController
        cell.layer.borderWidth = 1.0
        cell.bookName.text = myBookList.books[indexPath.row].bookName;
        cell.bookDes.text = myBookList.books[indexPath.row].bookDescription
        cell.bookImage.image = UIImage(named: myBookList.books[indexPath.row].bookImageName!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.delete }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        // delete the data from the fruit table,  Do this first, then use method 1 or method 2
       myBookList.books.remove(at: indexPath.row)
        
        //Method 1
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        
        //Method 2
        //self.fruitTable.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailView"){
        let selectedIndex: IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        let book = myBookList.books[selectedIndex.row]
            if let viewController: HaydenController = segue.destination as? HaydenController  {
                viewController.bookName = book.bookName;
            }
        }
    }

    @IBAction func logOut(_ sender: Any) {
        performSegue(withIdentifier: "out", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.rowHeight = 73
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func returnedToLibrary(segue: UIStoryboardSegue){
        
    }
}
