//
//  TableSceneController.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/10/02.
//

import Foundation
import UIKit

//var taskItems = ["test1","test2","test3","tttt","tete","tete3","tt te", "test5"]
//var taskDates = ["10.1","10.1","10.2","10.2","10.2","10.2","10.2","10.2"]
//var taskColor = ["red","orange","yellow","green","blue","navy","purple","red"]
//var taskChecks = ["0","0","0","0","0","0","0","0"]

var taskItem :[TaskData] = []
var taskSearchItems :[TaskData] = []
var taskSearchItemsIndex :[Int] = []
var searchWord :String = ""



var colors = ["red", "orange", "yellow", "green", "blue", "navy", "purple", "white"]

var selectedColor = "white"

class TableSceneController: UIViewController, UITextFieldDelegate {
    
    //Variable
    var date = Date()
    let dateFormatter = DateFormatter()
    let taskDateFormatter = DateFormatter()
    let toolbar = UIToolbar()
    
    var selectedButton = UIBarButtonItem()
    var redButton = UIBarButtonItem()
    var orangeButton = UIBarButtonItem()
    var yellowButton = UIBarButtonItem()
    var greenButton = UIBarButtonItem()
    var blueButton = UIBarButtonItem()
    var navyButton = UIBarButtonItem()
    var purpleButton = UIBarButtonItem()
    var noneButton = UIBarButtonItem()
    var flexSpace = UIBarButtonItem()
    var selectedIndex :Int = -1
    
    //date var
    @IBOutlet var dateLabel: UILabel!

    //textfield var
    @IBOutlet weak var taskField: UITextField!{
        didSet{
            taskField.delegate = self
            taskField.clearButtonMode = .whileEditing
        }
    }

    //table var
    @IBOutlet var taskTable: UITableView!{
        didSet{
            taskTable.delegate = self
            taskTable.dataSource = self
        }
    }
    
    //taskSearch var
    @IBAction func searchTaskButton(_ sender: Any) {
        let alert = UIAlertController(title: "검색", message: "",preferredStyle: .alert)
        
        alert.addTextField(){ (searchTextField) in
            
        }
        let ok = UIAlertAction(title: "확인", style: .default) {(ok) in
                     //code
            if let word = alert.textFields?[0].text {
                if word.isEmpty{
                    searchWord = ""
                }
                searchWord = word
            }
            self.searchTask(searchWord: searchWord)
            self.taskTable.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) {(cancel) in
                    //code
            searchWord = ""
            self.searchTask(searchWord: searchWord)
            self.taskTable.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }
    
    //Text Field Controll
    func textFieldDidBeginEditing(_ textField: UITextField){
        self.taskField.becomeFirstResponder()
        selectedColor = "white"
        selectedButton = setBarButton(colorName: "none", actionName: "")
        toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
       
        NSLog("taskFieldDidEndEditing Func : \((taskField.text) ?? "Empty")")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField:UITextField)->Bool{
        
        let newTask :String = taskField.text!
        
        if newTask.count > 0 {
            taskDateFormatter.dateFormat = "M.d"
            
            taskItem.append(TaskData(taskItem: newTask, taskDate: taskDateFormatter.string(from : date), taskColor: selectedColor, taskCheck: false))

            /*
            // USE CLASS
            taskDates.append(taskDateFormatter.string(from : date))
            
            taskItems.append(newTask)
            taskColor.append(selectedColor)
            taskChecks.append("0")
             */
            searchWord = ""
            searchTask(searchWord: searchWord)
            let indexPath = IndexPath(row: taskSearchItems.count-1, section:0)
            self.taskTable.insertRows(at: [indexPath], with: UITableView.RowAnimation.none)
            
            NSLog("Add Task : "+taskDateFormatter.string(from: date)+" " + newTask)
        }
        
        taskField.text = ""
        taskField.resignFirstResponder()
        
        return true
    }
    
    //Table View Controll
    override func viewWillAppear(_ animated: Bool) {
            taskTable.reloadData()
    }
    
    //Change Color Func
    @objc func changeColor(_ sender: Any)
    {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
                case 0: // Change the color to blue.
                    selectedColor = "white"
                    selectedButton = setBarButton(colorName: "none", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 1: // Change the color to red.
                    selectedColor = "red"
                    selectedButton = setBarButton(colorName: "red", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 2: // Change the color to blue.
                    selectedColor = "orange"
                    selectedButton = setBarButton(colorName: "orange", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 3: // Change the color to red.
                    selectedColor = "yellow"
                    selectedButton = setBarButton(colorName: "yellow", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 4: // Change the color to blue.
                    selectedColor = "green"
                    selectedButton = setBarButton(colorName: "green", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 5: // Change the color to red.
                    selectedColor = "blue"
                    selectedButton = setBarButton(colorName: "blue", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 6: // Change the color to blue.
                    selectedColor = "navy"
                    selectedButton = setBarButton(colorName: "navy", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                case 7: // Change the color to red.
                    selectedColor = "purple"
                    selectedButton = setBarButton(colorName: "purple", actionName: "")
                    toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
                    
                    taskField.inputAccessoryView = toolbar
                default:
                    selectedColor = "white"
                
            }
        }
    }
    
    func searchTask(searchWord :String){
        taskSearchItems.removeAll()
        taskSearchItemsIndex.removeAll()
        var count = 0
        for task in taskItem{
            
            if task.isContainWord(word: searchWord){
                taskSearchItems.append(task)
                taskSearchItemsIndex.append(count)
            }
            count+=1
        }
    }
    
    func initialTaskItem(){
        
        taskItem.append(TaskData(taskItem : "test1", taskDate : "10.1", taskColor : "red", taskCheck : false))
        taskItem.append(TaskData(taskItem : "test2", taskDate : "10.1", taskColor : "orange", taskCheck : false))
        taskItem.append(TaskData(taskItem : "test3", taskDate : "10.2", taskColor : "yellow", taskCheck : false))
        taskItem.append(TaskData(taskItem : "tttt", taskDate : "10.2", taskColor : "green", taskCheck : false))
        taskItem.append(TaskData(taskItem : "tete", taskDate : "10.3", taskColor : "blue", taskCheck : false))
        taskItem.append(TaskData(taskItem : "tete3", taskDate : "10.3", taskColor : "navy", taskCheck : false))
        taskItem.append(TaskData(taskItem : "tt te", taskDate : "10.4", taskColor : "purple", taskCheck : false))
        taskItem.append(TaskData(taskItem : "test5", taskDate : "10.4", taskColor : "red", taskCheck : false))
        searchTask(searchWord: searchWord)
    }
    
    func setBarButton(colorName : String, actionName : String) -> UIBarButtonItem{
        if actionName == "changeColor" {
            return UIBarButtonItem(image: UIImage(named: colorName)?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        }
        else{
            return UIBarButtonItem(image: UIImage(named: colorName)?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
    }
    
    
    //Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        
        
        
        NSLog(dateFormatter.string(from: date))
        self.dateLabel.text = dateFormatter.string(from: date)
        
        
        // ToolBar
        toolbar.sizeToFit()
            
        redButton = setBarButton(colorName: "red", actionName: "changeColor")
        redButton.tag = 1
        orangeButton = setBarButton(colorName: "orange", actionName: "changeColor")
        orangeButton.tag = 2
        yellowButton = setBarButton(colorName: "yellow", actionName: "changeColor")
        yellowButton.tag = 3
        greenButton = setBarButton(colorName: "green", actionName: "changeColor")
        greenButton.tag = 4
        blueButton = setBarButton(colorName: "blue", actionName: "changeColor")
        blueButton.tag = 5
        navyButton = setBarButton(colorName: "navy", actionName: "changeColor")
        navyButton.tag = 6
        purpleButton = setBarButton(colorName: "purple", actionName: "changeColor")
        purpleButton.tag = 7
        noneButton = setBarButton(colorName: "none", actionName: "changeColor")
        noneButton.tag = 0
        
        selectedButton = setBarButton(colorName: "none", actionName: "")
        flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton, flexSpace, selectedButton], animated: false)
        
        taskField.inputAccessoryView = toolbar

        
        //Initial Task Item For TEST
        initialTaskItem()
        
        // Do any additional setup after loading the view.
    }
}

extension TableSceneController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskSearchItems.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        cell.taskDateLabel?.text = taskSearchItems[(indexPath as NSIndexPath).row].getTaskDate()
        cell.taskLabel?.text = taskSearchItems[(indexPath as NSIndexPath).row].getTaskItem()
        
        cell.taskColor?.text = ""
        if taskSearchItems[(indexPath as NSIndexPath).row].getTaskCheck() == false{
            cell.taskCheck?.image = UIImage(named: "white")
        }
        else{
            cell.taskCheck?.image = UIImage(named: "check")
        }
        
        
        let tColor = taskSearchItems[(indexPath as NSIndexPath).row].getTaskColor()
        
        /*
         USE CLASS
         
        cell.taskDateLabel?.text = taskDates[(indexPath as NSIndexPath).row]
        cell.taskLabel?.text = taskItems[(indexPath as NSIndexPath).row]
        
        cell.taskColor?.text = ""
        if taskChecks[(indexPath as NSIndexPath).row] == "0"{
            cell.taskCheck?.image = UIImage(named: "white")
        }
        else{
            cell.taskCheck?.image = UIImage(named: "check")
        }
        let tColor = taskColor[(indexPath as NSIndexPath).row]
        */
        
        
        switch tColor{
            case "red" :
                cell.taskColor?.backgroundColor = UIColor.red
            case "orange" :
                cell.taskColor?.backgroundColor = UIColor.orange
            case "yellow" :
                cell.taskColor?.backgroundColor = UIColor.yellow
            case "green" :
                cell.taskColor?.backgroundColor = UIColor.green
            case "blue" :
                cell.taskColor?.backgroundColor = UIColor.blue
            case "navy" :
                cell.taskColor?.backgroundColor = UIColor.systemIndigo
            case "purple" :
                cell.taskColor?.backgroundColor = UIColor.purple
            case "white" :
                cell.taskColor?.backgroundColor = UIColor.white
            default :
                cell.taskColor?.backgroundColor = UIColor.white
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("diselect")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        if selectedIndex == indexPath.row{
            print("double click")
            if taskSearchItems[indexPath.row].getTaskCheck() == true{
                taskSearchItems[indexPath.row].setTaskCheck(taskCheck: false)
            }
            else{
                taskSearchItems[indexPath.row].setTaskCheck(taskCheck: true)
            }
            selectedIndex = -1
            tableView.reloadData()
        }
        else{
            selectedIndex = indexPath.row
        }
        
        /*
         USE CLASS
        if selectedIndex == indexPath.row{
            print("double click")
            if taskChecks[indexPath.row] == "1"{
                taskChecks[indexPath.row] = "0"
            }
            else{
                taskChecks[indexPath.row] = "1"
            }
            selectedIndex = -1
            tableView.reloadData()
        }
        else{
            selectedIndex = indexPath.row
        }
         */
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completion in completion(true)
            
            taskItem.remove(at: taskSearchItemsIndex[indexPath.row])
            taskSearchItems.remove(at :indexPath.row)
            
            /*
            USE CLASS
            taskItems.remove(at :indexPath.row)
            taskDates.remove(at: indexPath.row)
            taskColor.remove(at: indexPath.row)
             */
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
       
        delete.image = UIImage(systemName: "trash")
        // delete.image = #imageLiteral(resourceName: "trash")
            return UISwipeActionsConfiguration(actions: [delete])
        
    }
/*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskItems.remove(at :indexPath.row)
            taskDates.remove(at: indexPath.row)
            taskColor.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
                
            } else if editingStyle == .insert {
                // Not used in our example, but if you were adding a new row, this is where you would do it.
            }
        }
 */
}

extension UIImage {
  func resizeImage(size: CGSize) -> UIImage {
    
    let originalSize = self.size
    let ratio: CGFloat = {
        return originalSize.width > originalSize.height ? 1 / (size.width / originalSize.width) : 1 / (size.height / originalSize.height)
    }()

    return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: self.imageOrientation)
  }
}
