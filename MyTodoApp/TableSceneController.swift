//
//  TableSceneController.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/10/02.
//

import Foundation
import UIKit

var items = ["test1","test2","test3"]
var dates = ["10.1","10.1","10.2"]
var color = ["red","orange","yellow"]
class TableSceneController: UIViewController, UITextFieldDelegate {
    
    //Variable
    var date = Date()
    let dateFormatter = DateFormatter()
    let taskDateFormatter = DateFormatter()

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
    
    //Text Field Controll
    func textFieldDidBeginEditing(_ textField: UITextField){
        self.taskField.becomeFirstResponder()
        NSLog("taskFieldDidEndEditing Func : \((taskField.text) ?? "Empty")")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField:UITextField)->Bool{
        
        let newTask :String = taskField.text!
        
        if newTask.count > 0 {
            taskDateFormatter.dateFormat = "M.d"
            dates.append(taskDateFormatter.string(from : date))
            
            items.append(newTask)
            color.append("purple")

            let indexPath = IndexPath(row: items.count-1, section:0)
            self.taskTable.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
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
    
    //Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        
        
        
        NSLog(dateFormatter.string(from: date))
        self.dateLabel.text = dateFormatter.string(from: date)
        // Do any additional setup after loading the view.
    }
}

extension TableSceneController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.taskDateLabel?.text = dates[(indexPath as NSIndexPath).row]
        cell.taskLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.taskColor?.text = ""
        
        let tColor = color[(indexPath as NSIndexPath).row]
        
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
            default :
                cell.taskColor?.backgroundColor = UIColor.white
            
        }

        
        

        
        return cell
    }
    
}

