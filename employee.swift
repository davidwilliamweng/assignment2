//
//  employee.swift
//  cellFun
//
//  Created by Qin Mao on 2018/5/27.
//  Copyright © 2018年 MAGNUMIUM. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding{
    
    struct keys {
        static let name = "name";
        static let days = "days";
    }
    
  
    
    private var _name = "";
    private var _days = "";
    
    override init() {}
    init(name: String, days: String) {
        self._name = name;
        self._days = days;
    }
    required init(coder decoder: NSCoder) {
        if let nameObj = decoder.decodeObject(forKey: keys.name) as?
            String {
            _name = nameObj;
        }
        
        if let daysObj = decoder.decodeObject(forKey: keys.days) as? String{
            _days=daysObj;
        }
    }
    func encode(with coder: NSCoder) {
        coder.encode(_name, forKey: keys.name);
        coder.encode(_days, forKey: keys.days);
    }
    
    var Name: String{
        get{
            return _name;
        }
        set {
            _name = newValue
        }
        }
    var days: String{
        get{
            return _days;
        }
        set {
            _days = newValue;
        }
    }
    
    
    
}
