//
//  SetWeekViewController.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
//

import UIKit
import RealmSwift

class SetWeekViewController: UIViewController {
    var enable: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var clr:[String] = ["nezumi", "pi", "lgr", "or", "bl", "gr", "ye", "vi"]
    var images: [UIImage] = [#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi"),#imageLiteral(resourceName: "nezumi")]
    
    @IBOutlet weak var sunbtn: UIButton!
    @IBOutlet weak var monbtn: UIButton!
    @IBOutlet weak var tuebtn: UIButton!
    @IBOutlet weak var wedbtn: UIButton!
    @IBOutlet weak var thubtn: UIButton!
    @IBOutlet weak var fribtn: UIButton!
    @IBOutlet weak var satbtn: UIButton!
    
    var week = Week()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let weeks = realm.objects(Week.self)
        // 先頭のを取り出し
        if let w = weeks.first {
            // データを更新
            // try! realm.write() {
            self.enable[0] = w.w0
            self.enable[1] = w.w1
            self.enable[2] = w.w2
            self.enable[3] = w.w3
            self.enable[4] = w.w4
            self.enable[5] = w.w5
            self.enable[6] = w.w6
            // }
            printbtn()
        }
        else{
            print("DEBUG: no data")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("DEBUG: viewWillDisappear")
        print("enable\(enable)")
        // Realmに保存されてるDog型のオブジェクトを全て取得
        let weeks = realm.objects(Week.self)
        // 先頭の犬を取り出し
        if let w = weeks.first {
            // データを更新
            try! realm.write() {
                w.w0 = self.enable[0]
                w.w1 = self.enable[1]
                w.w2 = self.enable[2]
                w.w3 = self.enable[3]
                w.w4 = self.enable[4]
                w.w5 = self.enable[5]
                w.w6 = self.enable[6]
            }
        }
        else {
            print("DEBUG: no first")
            week.w0 = self.enable[0]
            week.w1 = self.enable[1]
            week.w2 = self.enable[2]
            week.w3 = self.enable[3]
            week.w4 = self.enable[4]
            week.w5 = self.enable[5]
            week.w6 = self.enable[6]
            try! realm.write() {
                realm.add(week)
            }
        }
        
        super.viewWillDisappear(animated)
        print("DEBUG: viewWillDisappear_")
        
        let notification_instance = NotificationController()
        notification_instance.setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sunbtn(_ sender: Any) {
        enable[0] = ( enable[0]+1 )%2
        printbtn()
    }
    
    @IBAction func monbtn(_ sender: Any) {
        enable[1] = ( enable[1]+1 )%2
        printbtn()
    }
    @IBAction func tuebtn(_ sender: Any) {
        enable[2] = ( enable[2]+1 )%2
        printbtn()
    }
    @IBAction func wedbtn(_ sender: Any) {
        enable[3] = ( enable[3]+1 )%2
        printbtn()
    }
    @IBAction func thubtn(_ sender: Any) {
        enable[4] = ( enable[4]+1 )%2
        printbtn()
    }
    @IBAction func fribtn(_ sender: Any) {
        enable[5] = ( enable[5]+1 )%2
        printbtn()
    }
    @IBAction func satbtn(_ sender: Any) {
        enable[6] = ( enable[6]+1 )%2
        printbtn()
    }
    @IBAction func offbtn(_ sender: Any) {
        for i in 0...6{
            enable[i]=0
        }
        printbtn()
    }
    
    func printbtn(){
        for i in 0...6{
            if enable[i] == 0 {
                let nezumiImg = UIImage(named: clr[0])
                images[i] = nezumiImg!
            }
            else{
                let image = UIImage(named: clr[i+1])
                images[i] = image!
            }
        }//i, 0 to 6
        
        sunbtn.setBackgroundImage(images[0], for: .normal)
        monbtn.setBackgroundImage(images[1], for: .normal)
        tuebtn.setBackgroundImage(images[2], for: .normal)
        wedbtn.setBackgroundImage(images[3], for: .normal)
        thubtn.setBackgroundImage(images[4], for: .normal)
        fribtn.setBackgroundImage(images[5], for: .normal)
        satbtn.setBackgroundImage(images[6], for: .normal)
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
