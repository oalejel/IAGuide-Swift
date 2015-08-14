//
//  RoomInfoController.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/12/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit

class RoomInfoController: InfoViewController {
    var roomNumber: Int!
    var classesInfo: NSArray!
    
    init(roomNumber: Int) {
        super.init(nibName: "InfoViewController", bundle: NSBundle.mainBundle())
        self.roomNumber = roomNumber
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the classes dictionary
        let classesPath = NSBundle.mainBundle().pathForResource("Classes", ofType: "plist")
        let classesDictionary = NSDictionary(contentsOfFile: classesPath!)
        classesInfo = classesDictionary!.objectForKey("\(roomNumber)") as! NSArray
        //get a hold of the teacher code array so you can sort class data with the code
        let teachersPath = NSBundle.mainBundle().pathForResource("Teachers", ofType: "plist")
        let teacherCodes = NSArray(contentsOfFile: teachersPath!)
    }
//MARK: Table View
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0 ? "A Day" : "B Day")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}
