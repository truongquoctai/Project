
//
//  DetailEventVC.swift
//  HomeWorkWeek6
//
//  Created by Trương Quốc Tài on 7/23/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class DetailEventVC: UIViewController {
    @IBOutlet weak var lblShow: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func onBtnRemove(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let day: Int = delegate.arrNote[0]
        let month: Int = delegate.arrNote[1]
        for i: Int in 0 ... delegate.listNote.count - 1{
            if(day == delegate.listNote[i].day && month == delegate.listNote[i].month){
                Utilities.share.deleleUser(day, month, 2019)
                break
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onBtnSave(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let day = delegate.arrNote[0]
        let month = delegate.arrNote[1]
        for i: Int in 0 ... delegate.listNote.count - 1{
            if(day == delegate.listNote[i].day && month == delegate.listNote[i].month){
               delegate.listNote[i].note =  self.tvNote.text
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNote()
    }
    
    func setNote(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        self.lblDay.text = "\(delegate.arrNote[0])"
        self.lblMonth.text = "\(delegate.arrNote[1])"
        self.lblYear.text = "2019"
        let day = delegate.arrNote[0]
        let month = delegate.arrNote[1]
        for i: Int in 0 ... delegate.listNote.count - 1{
            if(day == delegate.listNote[i].day && month == delegate.listNote[i].month){
                self.tvNote.text = delegate.listNote[i].note
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.arrNote.removeAll()
    }
}
