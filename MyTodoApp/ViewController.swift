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

    @IBOutlet var dateLebel: UILabel!
    
    @IBAction func settingButton(_ sender: Any) {
        self.dateLebel.text = "TEST"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        
        self.dateLebel.text = dateFormatter.string(from: date)
        // Do any additional setup after loading the view.
    }


}

