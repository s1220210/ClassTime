//
//  ViewController.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    var enable: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var w_jp:[String] = ["日","月","火","水","木","金","土"]
    
    var week = Week()
    var myClass = Classes()
    let realm = try! Realm()

    @IBOutlet weak var weeklabel: UILabel!
    @IBOutlet weak var cnlabel: UILabel!
    var on_week = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let weeks = realm.objects(Week.self)
        // 先頭のを取り出し
        if let w = weeks.first {
            // データを更新
            self.enable[0] = w.w0
            self.enable[1] = w.w1
            self.enable[2] = w.w2
            self.enable[3] = w.w3
            self.enable[4] = w.w4
            self.enable[5] = w.w5
            self.enable[6] = w.w6
        }
        
        for i in 0...6{
            if enable[i] == 1 {//指定あり
                on_week = on_week + " " + w_jp[i]
            }
            weeklabel.text = on_week
        }//i, 0 to 6
        
        let classNumbers = realm.objects(Classes.self)
        // 先頭の犬を取り出し
        if let cn = classNumbers.first {
            // データを更新
            let str: String = String(cn.classNumber)
            cnlabel.text = str + " 時限"
        }
    }//override func viewDidLoad() {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

