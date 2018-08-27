//
//  userRecord.swift
//  CSE335_Homework_01
//
//  Created by Yangkang Ou on 14/02/2018.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
class userReacord {
    var runningBurned: Double? = nil
    var exerciesBurned: Double? = nil
    var foodIntake: Double? = nil
    var weight: Double? = nil
    var blood: Double? = nil
    init(r:Double, e:Double, f:Double, w:Double, b:Double){
        self.runningBurned = r;
        self.exerciesBurned = e;
        self.foodIntake = f;
        self.weight = w;
        self.blood = b;
    }
}
