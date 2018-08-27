//
//  File.swift
//  CSE335_Homework_01
//
//  Created by Yangkang Ou on 17/02/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
class calculation{
    var sumIntake = 0.0
    var sumBurned = 0.0
    var average = 0.0
    var weightChange = 0.0
    
    func sum(sumAll:[Int: userReacord]) -> (intake: Double, burned:Double, average:Double, change: Double) {
        var min  = Double.infinity
        var max  = -1.0
        for element in sumAll {
            sumIntake = sumIntake + element.value.foodIntake!
            sumBurned = sumBurned + element.value.exerciesBurned! + element.value.runningBurned!
            average = average + element.value.blood!/7
            if element.value.weight! < min {
                min = element.value.weight!
            }
            if element.value.weight! > max {
                max = element.value.weight!
            }
        }
        weightChange = max - min
        return (sumIntake,sumBurned,average,weightChange)
    }
}

