//
//  Week.swift
//  ClassTime
//
//  Created by owner on 2018/02/24.
//  Copyright © 2018年 owner. All rights reserved.
//


import RealmSwift

class Week: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    // week
    @objc dynamic var w0 = 0
    @objc dynamic var w1 = 0
    @objc dynamic var w2 = 0
    @objc dynamic var w3 = 0
    @objc dynamic var w4 = 0
    @objc dynamic var w5 = 0
    @objc dynamic var w6 = 0
    //時限数
    @objc dynamic var classNumber = 0
}

class Classes: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    //時限数
    @objc dynamic var classNumber = 0
}

class Times: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var id = 0
    // week
    @objc dynamic var s_time = Date()
    @objc dynamic var e_time = Date()
    
    @objc dynamic var classN = ""
    
}
