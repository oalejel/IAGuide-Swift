//
//  InfoViewController.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/11/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //set the done button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("dismiss"))
        navigationItem.rightBarButtonItem = doneButton
        //adjust the tableview stuff
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DetailTableCell.self, forCellReuseIdentifier: "cell")
    }

    func dismiss() {
        navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
//tableview shared behavior
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return (section == tableView.numberOfSections() - 1 ? "As of 2015-2016" : "")
    }
    
    //!Should be overriden by subclasses
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
