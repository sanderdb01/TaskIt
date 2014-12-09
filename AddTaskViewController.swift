//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by David Sanders on 11/5/14.
//  Copyright (c) 2014 Bitfountain.io. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
   // var mainVC: ViewController!

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonTapped(sender: UIButton)
    {
//        var task = TaskModel(task: self.taskTextField.text, subTask: self.subtaskTextField.text, date: self.dueDatePicker.date, isCompleted: false)
//        
//        //mainVC.taskArray.append(task)
//        mainVC.baseArray[0].append(task)
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.isCompleted = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results
        {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
