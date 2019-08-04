//
//  CalendarVC.swift
//  HomeWorkWeek6
//
//  Created by Trương Quốc Tài on 7/23/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseNavigationBarDelegate {

    @IBOutlet weak var vNavigationBar: BaseNavigationBar!
    @IBOutlet weak var lblMon: UILabel!
    @IBOutlet weak var lblTue: UILabel!
    @IBOutlet weak var lblWed: UILabel!
    @IBOutlet weak var lblThu: UILabel!
    @IBOutlet weak var lblFri: UILabel!
    @IBOutlet weak var lblSat: UILabel!
    @IBOutlet weak var lblSun: UILabel!
    @IBOutlet weak var clvCalendar: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvCalendar.delegate = self
        self.clvCalendar.dataSource = self
        setRegister()
        self.setBaseNavigationBar()
        self.vNavigationBar.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.clvCalendar.reloadData()
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        if(delegate.listNote.count != 0){
//            for i: Int in 0 ... delegate.listNote.count - 1{
//                print("\(delegate.listNote[i].day) / \(delegate.listNote[i].month) / \(delegate.listNote[i].year)")
//            }
//            print("**************")
//        }
//        else{
//            print("No note")
//        }
    }
    //MARK: - BaseNavigationBarDelegate
    func touchUpInsideBtnRight(_ view: UIView, _ btnRight: UIButton) {
        let vc = Utilities.share.createVCWith(nameSB.nameSB, nameVC.AddEventVC)
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellBegin: Int = showDayInCell(section)[1]
        let numDayOfMonth: Int = showDayInCell(section)[0]
        if(cellBegin + numDayOfMonth > 35){
            return 42
        }
        else{
             return 35
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let clvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClvCell", for: indexPath) as! ClvCell
        let cellStart = showDayInCell(indexPath.section)[1]  //lấy được cell đầu tiên của tháng
        let numDayOfMonth = showDayInCell(indexPath.section)[0] // lấy ra số ngày của tháng
        clvCell.imgNote.backgroundColor = UIColor.white
        if (indexPath.row >= cellStart && indexPath.row < (cellStart + numDayOfMonth)){
            clvCell.lblDate.text = "\(indexPath.row - cellStart + 1)"
            //show note
            let delegate = UIApplication.shared.delegate as! AppDelegate
            if delegate.listNote.count != 0{
                for i: Int in 0 ... delegate.listNote.count-1{
                    if ( (indexPath.section + 1)  == delegate.listNote[i].month && (indexPath.row - cellStart + 1) == delegate.listNote[i].day){
                        clvCell.imgNote.backgroundColor = UIColor.orange
                    }
                }
            }
        }
        else
        {
            clvCell.lblDate.text = ""
        }
       
        return clvCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/7, height: self.view.frame.width/7)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader // set tên tháng ở header
        {
            let reuserCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSectionCell", for: indexPath) as! HeaderSectionCell
            reuserCell.lblMonth.text = setNameMonth(indexPath.section + 1)
            return reuserCell
        }
        else
        {
            return UICollectionReusableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let cellStart = self.showDayInCell(indexPath.section)[1]
        if delegate.listNote.count != 0{
            for i: Int in 0 ... delegate.listNote.count-1{
                if (delegate.listNote[i].day == (indexPath.row - cellStart + 1) && delegate.listNote[i].month == indexPath.section+1){
                    delegate.arrNote.append(indexPath.row - cellStart + 1)    //ngày
                    delegate.arrNote.append(indexPath.section + 1)      //Tháng
                    let vc = Utilities.share.createVCWith(nameSB.nameSB, nameVC.DetailEventVC)
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - Other Function
    func setRegister(){
        //registerUICollectionView
        self.clvCalendar.register(ClvCell.self, forCellWithReuseIdentifier: "ClvCell")
        self.clvCalendar.register(UINib(nibName: "ClvCell", bundle: nil), forCellWithReuseIdentifier: "ClvCell")
        //Register HeaderSection
        self.clvCalendar.register(HeaderSectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSectionCell")
        self.clvCalendar.register(UINib(nibName: "HeaderSectionCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderSectionCell")
        
    }
    
    func setNameMonth(_ number : Int) -> String{
        var nameMonth: String
        switch number {
        case 1:
            nameMonth = "January"
        case 2:
            nameMonth = "February"
        case 3:
            nameMonth = "March"
        case 4:
            nameMonth = "April"
        case 5:
            nameMonth = "May"
        case 6:
            nameMonth = "June"
        case 7:
            nameMonth = "July"
        case 8:
            nameMonth = "August"
        case 9:
            nameMonth = "September"
        case 10:
            nameMonth = "October"
        case 11:
            nameMonth = "November"
        case 12:
            nameMonth = "December"
        default:
            nameMonth = ""
        }
        return nameMonth
    }
    func showDayInCell(_ IndexPathSection: Int) -> [Int]{// hàm trả về 2 giá trị là ngày đầu tiên của tháng nằm ở cell thứ mấy và số ngày của tháng đó
        var numDayOfMonth : Int = 0
        var firstDayInMonth: String = ""
        var cellStart :Int = -1
        switch (IndexPathSection + 1) { //lấy ra số ngày của tháng và ngày đầu tiên của tháng
        case 1:
            numDayOfMonth  = "10/01/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/01/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 2:
            numDayOfMonth  = "10/02/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/02/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 3:
            numDayOfMonth  = "10/03/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/03/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 4:
            numDayOfMonth  = "10/04/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/04/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 5:
            numDayOfMonth  = "10/05/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/05/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 6:
            numDayOfMonth  = "10/06/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/06/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 7:
            numDayOfMonth  = "10/07/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/07/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 8:
            numDayOfMonth  = "10/08/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/08/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 9:
            numDayOfMonth  = "10/09/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/09/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 10:
            numDayOfMonth  = "10/10/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/10/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 11:
            numDayOfMonth  = "10/11/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/11/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        case 12:
            numDayOfMonth  = "10/12/2019".toDateWith(format: "dd/MM/yyyy").getDaysInMonth()
            firstDayInMonth = "10/12/2019".toDateWith(format: "dd/MM/yyyy").getFirstDayInMonth().toStringWith(format: "EE")
        default:
            break
        }
        switch firstDayInMonth {// từ ngày đầu tiên của tháng lấy ra đc vị trí cell của ngày đầu tiên
        case "Mon":
            cellStart = 0
        case "Tue":
            cellStart = 1
        case "Wed":
            cellStart = 2
        case "Thu":
            cellStart = 3
        case "Fri":
            cellStart = 4
        case "Sat":
            cellStart = 5
        case "Sun":
            cellStart = 6
        default:
            break
        }
        return [numDayOfMonth,cellStart] // số ngày của tháng và cell đầu tiên của tháng
    }
    func setBaseNavigationBar(){
        let imageRight = UIImage.init(named: "ico_right")
        self.vNavigationBar.btnRight.setImage(imageRight, for: .normal)
        self.vNavigationBar.lblMid.text = "2019"
    }
    
}

//MARK: - extension
extension Date {
    func currentLocale() -> Locale {
        let locale = Locale(identifier: "en_GB")
        //        if languageCode == "EN" {
        //            locale = Locale(identifier: "en_GB")
        //        }
        //        if languageCode == "VT" {
        //            locale = Locale(identifier:         "vi_VN")
        //        }
        //locale = Locale(identifier: "vi_VN")
        return locale
    }
    
    func getDaysInMonth() ->  Int{
        let calendar = Calendar.current
        //        calendar.locale = Locale(identifier: "vi_VN")
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    func strDateNoYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func nameMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func nameYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getMonth() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.month!
    }
    func getYear() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.year!
    }
    func getDay() -> Int {
        let calendar = Calendar.current
        let composents = calendar.dateComponents([.day, .month, .year], from: self)
        return composents.day!
    }
    
    func toStringWith(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = self.currentLocale()
        return dateFormatter.string(from: self).capitalized
    }
    
    func getFirstDayInMonth() -> Date {
        let month = self.getMonth()
        let year = self.getYear()
        let stringDate : String = String(format: "%.2d%.2d%d", 01, month, year)
        return stringDate.toDateWith(format: "ddMMyyyy")
    }
    
    func getLastDayInMonth() -> Date {
        let month = self.getMonth()
        let year = self.getYear()
        let lastDay = self.getDaysInMonth()
        let stringDate : String = String(format: "%.2d%.2d%d", lastDay, month, year)
        return stringDate.toDateWith(format: "ddMMyyyy")
    }
    
    func subNumberMinutes(_ minutes: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.setValue(-minutes, for: .minute)
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}

extension String {
    func toDateWith(format: String) -> Date {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = format
        dataFormatter.locale = Locale(identifier: "en_GB")
        return dataFormatter.date(from: self) ?? Date()
    }
}
