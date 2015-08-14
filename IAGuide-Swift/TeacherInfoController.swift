//
//  TeacherInfoController.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/12/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit

class TeacherInfoController: InfoViewController {
    var teacherNumber: Int!
    
    init(teacherNumber: Int) {
        super.init(nibName: "InfoViewController", bundle: NSBundle.mainBundle())
        self.teacherNumber = teacherNumber
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//MARK: Table View
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Sem 1 A Day"
        case 1:
            return "Sem 1 B Day"
        case 2:
            return "Sem 2 A Day"
        case 3:
            return "Sem 2 B Day"
        default:
            return nil
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //2 sections for each semester, each being either for A/B day
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableCell
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        return cell
    }
}
