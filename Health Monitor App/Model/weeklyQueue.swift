//
//  weeklyQueue.swift
//  CSE335_Homework_01
//
//  Created by Yangkang Ou on 16/02/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
class weeklyQueue{
    //declare
    var queueRecord : [Int : userReacord] = [Int: userReacord] ()
    var queueWeekly = queue<userReacord>()
    var count = 1
    init() { }
    
    func add(u: userReacord){
        if(count <= 7){
            queueRecord[count] = u
            queueWeekly.push(u)
        }
        else{
            queueWeekly.pop()
            queueWeekly.push(u)
            queueRecord[count%7] = u
        }
        
        count = count + 1
    }
    
    struct queue<Element>  {
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
    
}
