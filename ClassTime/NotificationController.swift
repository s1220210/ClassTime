//
//  NotificationController.swift
//  ClassTime
//
//  Created by owner on 2018/03/30.
//  Copyright © 2018年 owner. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class NotificationController: UIViewController {
    var enable: [Int] = [0, 0, 0, 0, 0, 0, 0]
    var classNumber = 0
    var weekN = 0
    
    var week = Week()
    var myClass = Classes()
    var timeArray = try! Realm().objects(Times.self).sorted(byKeyPath: "id", ascending: false)
    let realm = try! Realm()
    
    func setData(){
        // Do any additional setup after loading the view.
        weekN = 0
        
        print("DEBUG:setData()------")
        
        //通知全部消す
        let center = UNUserNotificationCenter.current()
        
        // 全ての通知済みの通知を削除する
        center.removeAllDeliveredNotifications()
        // 全てのpendingな通知を削除する
        center.removeAllPendingNotificationRequests()
        print("通知全削除----------")
 
        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
        
        //ここまで
        
        let weeks = realm.objects(Week.self)
        if let w = weeks.first {
            self.enable[0] = w.w0
            self.enable[1] = w.w1
            self.enable[2] = w.w2
            self.enable[3] = w.w3
            self.enable[4] = w.w4
            self.enable[5] = w.w5
            self.enable[6] = w.w6
        }
        
        let classNumbers = realm.objects(Classes.self)
        if let cn = classNumbers.first {
            self.classNumber = cn.classNumber
        }
        
        for n in 0...6{
            if enable[n]==1 { //もし該当する曜日なら
                weekN = n
                for k in 0..<classNumber{ //時間設定
                    print("classNumber:",classNumber)
                    setNotification(time: timeArray[k])
                }
            }
        }
    }//setData()
    
    

    
    func setNotification(time: Times) {
        let content = UNMutableNotificationContent()
        content.title = time.classN
        content.body  = SetTimeViewController.dateFormat.string(from: time.s_time) + " ~ " + SetTimeViewController.dateFormat.string(from: time.e_time)    // bodyが空だと音しか出ない
        content.sound = UNNotificationSound.default()
        
        // ローカル通知が発動するtrigger（日付マッチ）を作成
        let calendar = NSCalendar.current
        
        //時間指定
        var dateComponents = calendar.dateComponents([.weekday, .hour, .minute], from: time.s_time as Date)
        dateComponents.weekday = weekN+1
        
        //トリガー設定および繰り返し
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: true)
        
        // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
        let notification_id = String(weekN+1) + "_" + String(time.id)
        let request = UNNotificationRequest.init(identifier: notification_id, content: content, trigger: trigger)
        
        // ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
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

