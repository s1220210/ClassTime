//
//  ScheduleViewController.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleViewController: UIViewController {

    @IBOutlet weak var classNumber: UITextField!
    
    var myClass = Classes()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Realmに保存されてるDog型のオブジェクトを全て取得
        let classNumbers = realm.objects(Classes.self)
        // 先頭の犬を取り出し
        if let cn = classNumbers.first {
            // データを更新
            let str: String = String(cn.classNumber)
            classNumber.text = str
            // write()に渡すブロックの外だと例外発生
            //      dog.name = "First"
        }
        else{
            let str: String = classNumber.text!
            myClass.classNumber = Int(str)!
            try! realm.write() {
                realm.add(myClass)
            }
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        let week = realm.objects(Week.self)
        let time = realm.objects(Times.self)
        

        if let w = week.first{
            if let t = time.first{
                let notification_instance = NotificationController()
                notification_instance.setData()
            }
        }
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        // Realmに保存されてるDog型のオブジェクトを全て取得
        let classNumbers = realm.objects(Classes.self)
        // 先頭の犬を取り出し
        if let cn = classNumbers.first {
            // データを更新
            try! realm.write() {
                let str: String = classNumber.text!
                cn.classNumber = Int(str)!
            }
        }
        super.viewWillDisappear(animated)
        print("DEBUG: viewWillDisappear_scheduleviewcontroller")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
