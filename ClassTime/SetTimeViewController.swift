//
//  SetTimeViewController.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
// 課題：timeArrayの並び　idがちゃんと一つずつなのか？多分なってるけどわからない
//"id == 0"とかで判断したら(id =何時間目)

import UIKit
import Eureka
import RealmSwift
import UserNotifications

class SetTimeViewController: FormViewController {
    
    var classNumber = 0;
/*
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */
    let userDefault = UserDefaults.standard

    
    
    let date = Date()
    
    var startTime: Array<Date> = []
    var endTime: Array<Date> = []
    
    
    var myClass = Classes()
    //var time: Time!   // 追加する
    
    let realm = try! Realm()
    var timeArray = try! Realm().objects(Times.self).sorted(byKeyPath: "id", ascending: false)
    
    static var dateFormat: DateFormatter = {
        let f = DateFormatter()
        //f.dateFormat = "yyyy/MM/dd"
        f.dateStyle = .none
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Realmに保存されてるDog型のオブジェクトを全て取得
        let classNumbers = realm.objects(Classes.self)
        // 先頭の犬を取り出し
        if let cn = classNumbers.first {
            // データを更新
            self.classNumber = cn.classNumber
        }
        
        startTime = [Date](repeating: date, count: classNumber)//初期化
        endTime = [Date](repeating: date, count: classNumber)//初期化
        
        //Realmから得たDate()を各Time配列にデータを上書き
        print("DEBUG: timeArray.count = ",timeArray.count)
        for i in 0..<classNumber{
            if i < timeArray.count{
                let time = timeArray[i]
                startTime[i] = time.s_time
                endTime[i] = time.e_time
                print("didLoad, start: ",startTime[i])
                print("didLoad, end: ",endTime[i])
            }
        }
        
        
        
        
        for i in 0..<classNumber{
            
        form
            // Profile
            +++ Section("\(i+1)時限")
            <<< TimeRow(){
                $0.title = "開始時刻"
                $0.onChange{row in
                    //self.userDefault.setValue(row.value, forKey: "Time")
                    //print(type(of: row.value))
                    //print("self.userDefault:",self.userDefault.value(forKey: "Time")!)
                    self.startTime[i] = row.value ?? Date()
                }
            }
            <<< TimeRow(){
                $0.title = "終了時刻"
                $0.onChange{row in
                    self.endTime[i] = row.value ?? Date()
                }
            }
        }
            
            
        
        form
            // Button
            +++ Section()
            <<< ButtonRow(){
                $0.title = "Save"
                $0.onCellSelection{ [unowned self] cell, row in
                    self.printAll()
                }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.printAll()
    }
    
    private func printAll(){
        
        print("start:", startTime[0])
        print("end:", endTime[0])
        
        for i in 0..<classNumber{
        print("f.string:",SetTimeViewController.dateFormat.string(from: self.startTime[i]))
            SetTimeViewController.dateFormat.string(from: self.startTime[i])
        }
        
        let n = timeArray.count
        for i in 0..<classNumber{
            
            if i < n{
                let time = timeArray[i]
                // データを更新
                try! realm.write() {
                    time.s_time = startTime[i]
                    time.e_time = endTime[i]
                    time.classN = String(i+1) + "限目";
                    time.id = i
                }
            }
            else{
                //var time: Time!
                let time = Times()
                time.s_time = startTime[i]
                time.e_time = endTime[i]
                time.classN = String(i) + "限目";
                time.id = i
                try! realm.write() {
                    realm.add(time)
                }
            }
            
            
        }//for i in 0..<classNumber{
        
        print("printAll()")
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
