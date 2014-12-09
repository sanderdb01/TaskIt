//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by David Sanders on 11/5/14.
//  Copyright (c) 2014 Bitfountain.io. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel: TaskModel!
    
    //var mainVC: ViewController!

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println(self.detailTaskModel.task)
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBarButtonTapped(sender: UIBarButtonItem) {
//        var task = TaskModel(task: self.taskTextField.text, subTask: self.subtaskTextField.text, date: self.dueDatePicker.date, isCompleted: false)
//        //mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = task
//        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        self.detailTaskModel.task = self.taskTextField.text
        self.detailTaskModel.subtask = self.subtaskTextField.text
        self.detailTaskModel.date = self.dueDatePicker.date
        self.detailTaskModel.isCompleted = detailTaskModel.isCompleted
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func cancelBarButtonTapped(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
