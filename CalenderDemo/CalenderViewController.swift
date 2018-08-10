//
//  CalenderViewController.swift
//  CalenderDemo
//
//  Created by Prashant on 09/08/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    @IBOutlet weak var lblMonthdisplay: UILabel!
    
    var arrweekdays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    var arrMonth = ["January","February","March","April","May","June","July","August","September","Octomber","November","December"]
    var currentDate = String()
    var numberOfdays = Int()
    var firstDayInmonth = Int()
    var currentMonth = Int()
    var currentYear = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDate = CalenderHelper.sharesInstances.getCurrentmonthFirstDate()
        self.reloadCalenderData()
    }
    
    @IBAction func actionnext(_ sender: Any) {
        for i in 0...41{
            calenderCollectionView.deselectItem(at: IndexPath(row: i, section: 1), animated: false)
        }
        let todayDate = CalenderHelper.sharesInstances.dateFormatterGet().date(from: currentDate)
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: todayDate!)
        currentDate = CalenderHelper.sharesInstances.dateFormatterGet().string(from: nextMonth!)
        self.reloadCalenderData()
    }
    
    @IBAction func actionPrevious(_ sender: Any) {
        for i in 0...41{
            calenderCollectionView.deselectItem(at: IndexPath(row: i, section: 1), animated: false)
        }
        let todayDate = CalenderHelper.sharesInstances.dateFormatterGet().date(from: currentDate)
        let nextMonth = Calendar.current.date(byAdding: .month, value: -1, to: todayDate!)
        currentDate = CalenderHelper.sharesInstances.dateFormatterGet().string(from: nextMonth!)
        self.reloadCalenderData()
    }
    
    func reloadCalenderData() {
        let todayDate = CalenderHelper.sharesInstances.dateFormatterGet().date(from: currentDate)
        
        let year = CalenderHelper.sharesInstances.getYear(fromDate: todayDate!)
        let month = CalenderHelper.sharesInstances.getMonth(fromDate: todayDate!)
        
        currentMonth = month;
        currentYear = year;
        
        calenderCollectionView.allowsMultipleSelection = true
        calenderCollectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        let strMonth = arrMonth[month-1]
        lblMonthdisplay.text = "\(strMonth)-\(year)"
        
        firstDayInmonth = CalenderHelper.sharesInstances.getDayOfWeek(currentDate)!
        numberOfdays = CalenderHelper.sharesInstances.numberOfdaysInmonth(currentDate)
        calenderCollectionView.reloadData()
    }
}

extension CalenderViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section==0){
           return arrweekdays.count
        }else{
            return 42
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section==0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateViewCollectionCell", for: indexPath) as! DateViewCollectionCell
            
            cell.backgroundColor = UIColor.black
            cell.isUserInteractionEnabled = false
            cell.viewSelected.isHidden = true
            cell.lblData.textColor = UIColor.white
            cell.lblData.text = arrweekdays[indexPath.row]
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateViewCollectionCell", for: indexPath) as! DateViewCollectionCell
            
            cell.viewSelected.isHidden = false
            cell.backgroundColor = UIColor.clear
            cell.lblData.textColor = UIColor.black
            cell.lblData.backgroundColor  = UIColor.clear
            cell.viewSelected.backgroundColor = UIColor.clear
            
            if (indexPath.row+1) < firstDayInmonth {
                var cellDateis = String()
                if currentMonth == 1 {
                    cellDateis = Utility.sharedInstance.celldateIS(year: currentYear-1, month: 12, day: "01")
                }else{
                    cellDateis = Utility.sharedInstance.celldateIS(year: currentYear, month: currentMonth-1, day: "01")
                }
                
                let  totaldaysinmonth = CalenderHelper.sharesInstances.numberOfdaysInmonth(cellDateis)
                cell.isUserInteractionEnabled = false
                cell.viewSelected.isHidden = true
                cell.lblData.textColor = UIColor.lightGray
                
                cell.lblData.text = "\(totaldaysinmonth - ((firstDayInmonth-(indexPath.row+1))-1))"
            }else{
                if ((indexPath.row+1)-(firstDayInmonth-1)) > numberOfdays{
                    cell.viewSelected.isHidden = true
                    cell.lblData.textColor = UIColor.lightGray
                    cell.isUserInteractionEnabled = false
                    cell.lblData.text = "\(((indexPath.row+1)-(firstDayInmonth-1))-numberOfdays)"
                }else{
                    let cellDateis = Utility.sharedInstance.celldateIS(year: currentYear, month: currentMonth, day: "\((indexPath.row+1)-(firstDayInmonth-1))")
                    
                    if CalenderHelper.sharesInstances.dateisTheSameDay(Date(), dateB: CalenderHelper.sharesInstances.convertDateFromString(date: cellDateis)){
                        collectionView.selectItem(at: indexPath, animated: false, scrollPosition:[])
                        cell.selectedCellItem()
                    }else{
                        collectionView.deselectItem(at: indexPath, animated: false)
                        cell.deselectedCellItem()
                    }
                
                    cell.isUserInteractionEnabled = true
                    cell.lblData.text = "\((indexPath.row+1)-(firstDayInmonth-1))"
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateViewCollectionCell
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition:[])
        cell.selectedCellItem()
//        cell.viewSelected.transform = cell.viewSelected.transform.scaledBy(x: 0.1, y: 0.1)
//        cell.viewSelected.backgroundColor = UIColor.black
//        cell.lblData.textColor = UIColor.white
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
//            cell.viewSelected.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
//            cell.viewSelected.layer.masksToBounds = true
//            cell.viewSelected.layer.cornerRadius = cell.viewSelected.frame.size.height/2
//        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! DateViewCollectionCell
        collectionView.deselectItem(at: indexPath, animated: false)
        cell.deselectedCellItem()
//        cell.viewSelected.layer.masksToBounds = true
//        cell.viewSelected.layer.cornerRadius = cell.viewSelected.frame.size.height/2
//
//        cell.viewSelected.backgroundColor = UIColor.clear
//        cell.lblData.textColor = UIColor.black
//
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
//            cell.viewSelected.transform = cell.viewSelected.transform.scaledBy(x: 0.1, y: 0.1)
//        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.size.width/7, height:(collectionView.frame.size.width/7)-20)
        }else{
            return CGSize(width: collectionView.frame.size.width/7, height: collectionView.frame.size.width/7)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func weekday() -> Int {
        return NSCalendar.current.component(.weekday, from: self)
    }
    
    func firstDayOfTheMonth() -> NSDate {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from:self))! as NSDate
    }
}
