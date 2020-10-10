//
//  CalendarSceneController.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/10/10.
//

import UIKit
import FSCalendar

class CalendarSceneController: UIViewController,FSCalendarDelegate, FSCalendarDataSource{

    var date = Date()
    let dateFormatter = DateFormatter()

    //Date var
    @IBOutlet var dateLabel: UILabel!

    @IBAction func settingButton(_ sender: Any) {
        self.dateLabel.text = "TEST";
    }

    @IBOutlet var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        
        
        self.dateLabel.text = dateFormatter.string(from: date)
        
        //calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택할 수 있도록
        //calendar.clipsToBounds = true //달력 구분 선 제거
                 
        calendarInit(calendar: calendar)
        
        calendar.delegate = self
        calendar.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func calendarInit(calendar: FSCalendar!){
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "M월"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        
    }
    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return true
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
 
    
 
}

