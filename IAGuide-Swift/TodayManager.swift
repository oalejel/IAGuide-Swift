//
//  DayManager.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/11/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit

enum DayLength {
    case Normal, LateStart, HalfDay, NoSchool
}
enum DayBlock {
    case A, B
}
struct DayType {
    var block: DayBlock
    var length: DayLength
    init(length: DayLength, block: DayBlock) {
        self.block = block
        self.length = length
    }
}

class DayManager: NSObject {
    
    lazy var irregularDays: NSArray? = {
        let irregularsPath = NSBundle.mainBundle().pathForResource("ShortDays", ofType: "plist")
        return NSArray(contentsOfFile: irregularsPath!)
        }()
    
    override init() {
        
    }

    
    class func sharedClassManager() -> DayManager {
        return DayManager()
    }
    
    func dayTypeForDate(date: NSDate) -> DayType {
        return DayType(length: .Normal, block: .A)
    }
}
