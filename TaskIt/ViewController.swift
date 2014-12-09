//
//  ViewController.swift
//  TaskIt
//
//  Created by David Sanders on 11/4/14.
//  Copyright (c) 2014 Bitfountain.io. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    //var taskArray:[Dictionary<String, String>] = []
    //var taskArray:[TaskModel] = []
    
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
          // Do any additional setup after loading the view, typically from a nib.
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
//
//        //let task1:Dictionary<String, String> = ["task": "Study French", "subtask": "Verbs", "date": "01/14/2014"]
//        //let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date":"01/14/2014"]
//        //let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg Day", "date":"01/14/2014"]
//        let date1 = Date.from(year: 2014, month: 05, day: 20)
//        let date2 = Date.from(year: 2014, month: 03, day: 03)
//        let date3 = Date.from(year: 2014, month: 12, day: 13)
//        
//        let task1:TaskModel = TaskModel(task: "Study French", subTask: "Verbs", date: date1, isCompleted:false)
//        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burger", date: date2, isCompleted:false)
//        
//        let taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: date3, isCompleted:false)]
//        
//        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, isCompleted: true)]
//        
//        self.baseArray = [taskArray, completedArray]
//        
//        //taskArray = [task1, task2, task3]
//        
//        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
//        func sortByDate (taskOne:TaskModel, taskTwo:TaskModel) -> Bool
//        {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
        
//        taskArray = taskArray.sorted(sortByDate)
        
//        baseArray[0] = baseArray[0].sorted{
//            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
//            //comparison logic here
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
        
//        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showTaskDetail"
        {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            //could also pass in the indexPath as the sender, then we would make indexPath = sender and no ! would be needed
            let indexPath = self.tableView.indexPathForSelectedRow()
            //let thisTask = taskArray[indexPath!.row]
            //let thisTask = baseArray[indexPath!.section][indexPath!.row]
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask
            //detailVC.mainVC = self
        }
        else if segue.identifier == "showAddTask"
        {
            let addTaskVC = segue.destinationViewController as AddTaskViewController
            //addTaskVC.mainVC = self
        }
    }
    @IBAction func addBarButtonTapped(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("showAddTask", sender: nil)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
        //return self.baseArray.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fetchedResultsController.sections![section].numberOfObjects
        //return baseArray[section].count
        //return self.taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //let thisTask = baseArray[indexPath.section][indexPath.row]
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        cell.taskLabel.text = thisTask.task
        cell.subtaskLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    //UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "To Do"
        }
        else
        {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //let thisTask = baseArray[indexPath.section][indexPath.row]
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            //var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: true)
            //baseArray[1].append(newTask)
            thisTask.isCompleted = true
        }
        else
        {
            //var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, isCompleted: false)
            //self.baseArray[0].append(newTask)
            thisTask.isCompleted = false
        }
        
        //self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
        //self.tableView.reloadData()
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()

    }
    
    // NSFetchedControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //Helper
    
    func taskFetchRequest() -> NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController
    {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultsController
        
    }

}










