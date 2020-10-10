//
//  ViewController.swift
//  MyTodoApp
//
//  Created by Macbook Pro on 2020/09/28.
//

import UIKit


class ViewController: UIViewController {

    var date = Date()
    let dateFormatter = DateFormatter()

    //Date var
    @IBOutlet var dateLabel: UILabel!

    @IBAction func settingButton(_ sender: Any) {
        self.dateLabel.text = "TEST";
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        
        
        self.dateLabel.text = dateFormatter.string(from: date)
        // Do any additional setup after loading the view.
    }


}

