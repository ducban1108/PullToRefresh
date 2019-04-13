//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Vũ on 4/5/19.
//  Copyright © 2019 Vũ. All rights reserved.
//

import UIKit

import UIKit

struct Student {
    var name: String
    var school: String
}

class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
            refreshControl.attributedTitle = NSAttributedString(string: "Refresh Data...")
            refreshControl.tintColor = UIColor.green
            if #available(iOS 11.0, *) {
                tableView.refreshControl = refreshControl
            } else {
                tableView.addSubview(refreshControl)
            }
        }
    }
    
    var listStudent = [
        Student(name: "Nhung", school: "Mai Anh Tuan"),
        Student(name: "Hang", school: "Tran Phu")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = listStudent[(indexPath as NSIndexPath).row].name
        cell.detailTextLabel?.text = listStudent[(indexPath as NSIndexPath).row].school
        
        return cell
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        let newStudent = Student(name: "Hong Anh", school: "Tran Duy Hung")
        
        // insert at index 0
        listStudent.insert(newStudent, at: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
}

