//
//  LibraryCellController.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/23.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import UIKit
class LibraryCellController: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!{
        didSet {
            bookImage.layer.cornerRadius =
            bookImage.bounds.width / 2
            bookImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var bookDes: UILabel!
    @IBOutlet weak var bookName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
