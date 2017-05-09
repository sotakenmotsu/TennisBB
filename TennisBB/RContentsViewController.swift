//
//  ContentsViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/21.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class RContentsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var LevelSelector: UITextField!
    var LpickerView: UIPickerView = UIPickerView()
    let Llist = ["", "ベテラン", "初心者", "まあまあ", "誰でも"]
    
    @IBOutlet weak var MemberSelector: UITextField!
    var MpickerView: UIPickerView = UIPickerView()
    let Mlist = ["", "1人", "2人", "3人", "4人", "5人", "6人", "7人", "8人", "9人", "10人",]
    
    @IBOutlet weak var StartSelector: UITextField!
    var SpickerView: UIPickerView = UIPickerView()
    let Slist = ["", "７時", "９時", "１１時", "１３時", "１５時", "１７時", "１９時"]
    
    @IBOutlet weak var EndSelector: UITextField!
    var EpickerView: UIPickerView = UIPickerView()
    let Elist = ["", "７時", "９時", "１１時", "１３時", "１５時", "１７時", "１９時"]
    
    @IBOutlet weak var DateSelector: UITextField!
    var DatePicker: UIDatePicker = UIDatePicker()
    var toolBar: UIToolbar!
    
    @IBOutlet var Comment: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(RContentsViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(RContentsViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        LpickerView.delegate = self
        LpickerView.dataSource = self
        LpickerView.showsSelectionIndicator = true
        
        self.LevelSelector.inputView = LpickerView
        self.LevelSelector.inputAccessoryView = toolbar
        
        MpickerView.delegate = self
        MpickerView.dataSource = self
        MpickerView.showsSelectionIndicator = true
        
        self.MemberSelector.inputView = MpickerView
        self.MemberSelector.inputAccessoryView = toolbar
        
        SpickerView.delegate = self
        SpickerView.dataSource = self
        SpickerView.showsSelectionIndicator = true
        
        self.StartSelector.inputView = SpickerView
        self.StartSelector.inputAccessoryView = toolbar
        
        EpickerView.delegate = self
        EpickerView.dataSource = self
        EpickerView.showsSelectionIndicator = true
        
        self.EndSelector.inputView = EpickerView
        self.EndSelector.inputAccessoryView = toolbar
        
        DateSelector.placeholder = dateToString(date: NSDate())
        DateSelector.text = dateToString(date: NSDate())
        self.view.addSubview(DateSelector)
        DatePicker = UIDatePicker()
        DatePicker.addTarget(self, action: Selector(("DateEvents")), for: UIControlEvents.valueChanged)
        DatePicker.datePickerMode = UIDatePickerMode.date
        DateSelector.inputView = DatePicker
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.height, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .bordered, target: self, action: "tappedtoolBarBtn:")
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .bordered, target: self, action: "tappedtoolBarBtnToday:")
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        DateSelector.inputAccessoryView = toolBar
        
        // Do any additional setup after loading the view.
    }
    
    func tappedtoolBarBtn(sender: UIBarButtonItem) {
        DateSelector.resignFirstResponder()
    }
    
    func tappedtoolBarBtnToday(sender: UIBarButtonItem) {
        DateSelector.resignFirstResponder()
        DatePicker.date = Date()
//        changeLabelDate(date: Date())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == LpickerView {
            return Llist.count
        }else if pickerView == MpickerView {
            return Mlist.count
        }else if pickerView == SpickerView {
            return Slist.count
        }else{
            return Elist.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == LpickerView {
            return Llist[row]
        }else if pickerView == MpickerView{
            return Mlist[row]
        }else if pickerView == SpickerView{
            return Slist[row]
        }else{
            return Elist[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == LpickerView {
            self.LevelSelector.text = Llist[row]
        }else if pickerView == MpickerView {
            self.MemberSelector.text = Mlist[row]
        }else if pickerView == SpickerView {
            self.StartSelector.text = Slist[row]
        }else{
            self.EndSelector.text = Elist[row]
        }
    }
    
    func cancel() {
        self.LevelSelector.text = ""
        self.LevelSelector.endEditing(true)
        self.MemberSelector.text = ""
        self.MemberSelector.endEditing(true)
        self.StartSelector.text = ""
        self.StartSelector.endEditing(true)
        self.EndSelector.text = ""
        self.EndSelector.endEditing(true)
        
    }
    
    func done() {
        self.LevelSelector.endEditing(true)
        self.MemberSelector.endEditing(true)
        self.StartSelector.endEditing(true)
        self.EndSelector.endEditing(true)
    }
    
    func DateEvent(sender: AnyObject?) {
        var dateSelector: UIDatePicker = sender as! UIDatePicker
        self.DateLabel(date: DatePicker.date as NSDate)
    }
    
    func DateLabel(date: NSDate) {
        DateSelector.text = self.dateToString(date: date)
    }
    
    func dateToString(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date as Date)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func PostButton(_ sender: UIButton) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let content = Contents()
        content.place = LevelSelector.text!
        content.starttime = StartSelector.text!
        content.endtime = EndSelector.text!
        content.member = MemberSelector.text!
        content.level = LevelSelector.text!
        content.comment = Comment.text!
        try! realm.write {
            realm.add (content)
        }
        self.dismiss(animated: true, completion: nil)

    }
}
