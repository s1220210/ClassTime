//
//  ViewController.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var enable: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var w_jp:[String] = ["日","月","火","水","木","金","土"]
    
    var week = Week()
    var myClass = Classes()
    var timeArray = try! Realm().objects(Times.self).sorted(byKeyPath: "id", ascending: false)
    let realm = try! Realm()

    @IBOutlet weak var weeklabel: UILabel!
    @IBOutlet weak var cnlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var on_week = ""
    var classes = 0
    var setTime: Array<String> = []
    
   // let setTime_instance = SetTimeViewController()
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
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
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
            classes = cn.classNumber
            let str: String = String(classes)
            cnlabel.text = str + " 時限"
        }
        
        for i in 0..<classes{
            let time = timeArray[i]
            let s = ViewController.dateFormat.string(from: time.s_time)
            let e = ViewController.dateFormat.string(from: time.e_time)
            let s_etime = s+" ~ "+e
            setTime += [s_etime]
        }
    }//override func viewDidLoad() {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSourceプロトコルのメソッド
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes
    }
    
    // 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = String(indexPath.row+1)+" 時限目"
        cell.detailTextLabel!.text = setTime[indexPath.row]
        return cell
    }
    // MARK: UITableViewDelegateプロトコルのメソッド
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }


}

