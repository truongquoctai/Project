//
//  Utilities.swift
//  week6
//
//  Created by Trương Quốc Tài on 7/23/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit


class Utilities: NSObject {
    static let share = Utilities()
    
    
    func createVCWith(_ nameStoryBoard : String, _ nameVC: String) -> UIViewController {
        return UIStoryboard.init(name: nameStoryBoard, bundle: nil).instantiateViewController(withIdentifier: nameVC)
    }
    func addNote(_ note : dataNote) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.listNote.append(note)
    }
    
    func deleleUser(_ day: Int,_ month: Int,_ year: Int) {
        let index = findNote(day, month, year)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if(index == -1){
            print("can't find note to remove")
        }
        else{
            delegate.listNote.remove(at: index)
        }
    }
    func updateNote(_ day: Int,_ month: Int,_ year: Int,_ newNote: String) {
        let index = findNote(day, month, year)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if(index == -1){
            print("can't find note to update")
        }
        else{
            delegate.listNote[index].note = newNote
        }
    }
    
    func findNote(_ day: Int,_ month: Int,_ year: Int) -> Int{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        for i: Int in 0 ... delegate.listNote.count
        {
            if(delegate.listNote[i].day == day && delegate.listNote[i].month == month && delegate.listNote[i].year == year){
                return i
            }
        }
        return -1
    }
}

class dataNote {
    var day: Int
    var month: Int
    var year: Int
    var note: String
    init(_ day: Int,_ month: Int,_ year: Int,_ note: String) {
        self.day = day
        self.month = month
        self.year = year
        self.note = note
    }
    
}

