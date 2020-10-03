//
//  TableSceneController.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/10/02.
//

import Foundation
import UIKit

var taskItems = ["test1","test2","test3"]
var taskDates = ["10.1","10.1","10.2"]
var taskColor = ["red","orange","yellow"]
var colors = ["red", "orange", "yellow", "green", "blue", "navy", "purple", "white"]
var selectedColor = "white"

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
        selectedColor = "white"
        NSLog("taskFieldDidEndEditing Func : \((taskField.text) ?? "Empty")")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField:UITextField)->Bool{
        
        let newTask :String = taskField.text!
        
        if newTask.count > 0 {
            taskDateFormatter.dateFormat = "M.d"
            taskDates.append(taskDateFormatter.string(from : date))
            
            taskItems.append(newTask)
            taskColor.append(selectedColor)

            let indexPath = IndexPath(row: taskItems.count-1, section:0)
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
                case 1: // Change the color to red.
                    selectedColor = "red"
                case 2: // Change the color to blue.
                    selectedColor = "orange"
                case 3: // Change the color to red.
                    selectedColor = "yellow"
                case 4: // Change the color to blue.
                    selectedColor = "green"
                case 5: // Change the color to red.
                    selectedColor = "blue"
                case 6: // Change the color to blue.
                    selectedColor = "navy"
                case 7: // Change the color to red.
                    selectedColor = "purple"
                default:
                    selectedColor = "white"
                
            }
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
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
                
        let redButton = UIBarButtonItem(image: UIImage(named: "red")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        redButton.tag = 1
        let orangeButton = UIBarButtonItem(image: UIImage(named: "orange")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        orangeButton.tag = 2
        let yellowButton = UIBarButtonItem(image: UIImage(named: "yellow")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        yellowButton.tag = 3
        let greenButton = UIBarButtonItem(image: UIImage(named: "green")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        greenButton.tag = 4
        let blueButton = UIBarButtonItem(image: UIImage(named: "blue")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        blueButton.tag = 5
        let navyButton = UIBarButtonItem(image: UIImage(named: "navy")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        navyButton.tag = 6
        let purpleButton = UIBarButtonItem(image: UIImage(named: "purple")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        purpleButton.tag = 7
        let noneButton = UIBarButtonItem(image: UIImage(named: "none")?.resizeImage(size: CGSize(width: 26, height: 26)).withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: nil, action: #selector(changeColor))
        noneButton.tag = 0
        
        toolbar.setItems([redButton, orangeButton, yellowButton, greenButton, blueButton, navyButton, purpleButton, noneButton], animated: false)
        
        taskField.inputAccessoryView = toolbar

        
        // Do any additional setup after loading the view.
    }
}

extension TableSceneController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.taskDateLabel?.text = taskDates[(indexPath as NSIndexPath).row]
        cell.taskLabel?.text = taskItems[(indexPath as NSIndexPath).row]
        cell.taskColor?.text = ""
        
        let tColor = taskColor[(indexPath as NSIndexPath).row]
        
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
