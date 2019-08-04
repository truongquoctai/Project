//
//  AddEventVC.swift
//  HomeWorkWeek6
//
//  Created by Trương Quốc Tài on 7/23/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class AddEventVC: UIViewController {

    var dateTime :String = ""
    @IBOutlet weak var lblShow: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnAddEvent: UIButton!
    @IBOutlet weak var tvInput: UITextView!
    @IBAction func onChanged(_ sender: Any) {
        self.dateTime = "\(self.datePicker.date)"
    }
    
    @IBAction func onBtnAddEvent(_ sender: Any) {
        let day = self.datePicker.date.getDay()
        let month = self.datePicker.date.getMonth()
        let year = self.datePicker.date.getYear()
        let note = self.tvInput.text ?? ""
        Utilities.share.addNote(dataNote.init(day, month, year, note))
        let vc = Utilities.share.createVCWith(nameSB.nameSB, nameVC.CalendarVC)
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.datePickerMode = .date
        self.datePicker.locale = Locale(identifier: "en_GB")
        self.btnAddEvent.layer.cornerRadius = self.btnAddEvent.frame.height/2
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tvInput.text = ""
    }

}
