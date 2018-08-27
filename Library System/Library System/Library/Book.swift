//
//  Book.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
class books{
    
    var books:[book] = []
    init()
    {
        let f1 = book(fn: "Dictionary", fd: "English Dictionary", fin: "Dictionary.png")
        let f2 = book(fn: "Novel", fd: "World Novel", fin: "Novel.png")
        let f3 = book(fn: "Education", fd: "Educational Book", fin: "Educational.png")
        let f4 = book(fn: "Science", fd: "New Techology Book", fin: "Science.png")
        let f5 = book(fn: "Law", fd: "Law book", fin: "Law.png")
        books.append(f1)
        books.append(f2)
        books.append(f3)
        books.append(f4)
        books.append(f5)
    }
}

class book
{
    var bookName:String?
    var bookDescription:String?
    var bookImageName:String?
    
    init(fn:String, fd:String, fin:String)
    {
        bookName = fn
        bookDescription = fd
        bookImageName = fin
        
    }
}
