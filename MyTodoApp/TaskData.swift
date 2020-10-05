//
//  TaskData.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/10/05.
//

import Foundation
import UIKit

class TaskData{
    var taskItem: String!
    var taskDate: String!
    var taskColor: String!
    var taskCheck: Bool!
    
    init(taskItem : String, taskDate:String, taskColor:String, taskCheck:Bool){
        self.taskItem = taskItem
        self.taskDate = taskDate
        self.taskColor = taskColor
        self.taskCheck = taskCheck
    }
    
    func setTaskItem(taskItem :String){
        self.taskItem = taskItem
    }
    
    func setTaskDate(taskDate :String){
        self.taskDate = taskDate
    }
    
    func setTaskColor(taskColor :String){
        self.taskColor = taskColor
    }
    
    func setTaskCheck(taskCheck :Bool){
        self.taskCheck = taskCheck
    }
    
    func getTaskItem() -> String{
        return self.taskItem
    }
    
    func getTaskDate() -> String{
        return self.taskDate
    }
    
    func getTaskColor() -> String{
        return self.taskColor
    }
    
    func getTaskCheck() -> Bool{
        return self.taskCheck
    }
    
    func isContainWord(word:String) -> Bool{
        if word.count<=0 {
            return true
        }
        
        if self.taskItem.contains(word){
            return true
        }
        else{
            return false
        }
    }
}
