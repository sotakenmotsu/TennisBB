//
//  ContentsViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/21.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import Firebase


class RContentsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var PlaceView: UITextField!
    
    @IBOutlet weak var LevelSelector: UITextField!
    var LpickerView: UIPickerView = UIPickerView()
    var level: Int = 0
    
    @IBOutlet weak var MemberSelector: UITextField!
    var MpickerView: UIPickerView = UIPickerView()
    var member: Int = 0
    
    @IBOutlet weak var StartSelector: UITextField!
    var SpickerView: UIPickerView = UIPickerView()
    var start: Int = 0
    
    @IBOutlet weak var EndSelector: UITextField!
    var EpickerView: UIPickerView = UIPickerView()
    var end: Int = 0
    
    @IBOutlet weak var DateSelector: UITextField!
    var DatePicker: UIDatePicker = UIDatePicker()
    var toolBar: UIToolbar!
    
    @IBOutlet var Comment: UITextView!
    
    @IBOutlet var postbutton: UIButton!
    
    var database: Firestore!
    var ref: DocumentReference? = nil
    
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
        
        DateSelector.placeholder = dateToString(Date())
        DateSelector.text = dateToString(Date())
        self.view.addSubview(DateSelector)
        DatePicker = UIDatePicker()
        DatePicker.addTarget(self, action: #selector(DateEvent), for: UIControlEvents.valueChanged)
        DatePicker.datePickerMode = UIDatePickerMode.date
        DateSelector.inputView = DatePicker
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.height, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .bordered, target: self, action: #selector(self.tappedtoolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .bordered, target: self, action: #selector(tappedtoolBarBtnToday(_:)))
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        DateSelector.inputAccessoryView = toolBar
        
        Comment.text = "コメント"
        Comment.delegate = self
        Comment.textColor = UIColor.lightGray
        
        self.view.backgroundColor = ColorManager.maincolor
        postbutton.backgroundColor = ColorManager.buttoncolor
        postbutton.setTitleColor(.white, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    func tappedtoolBarBtn(_ sender: UIBarButtonItem) {
        DateSelector.resignFirstResponder()
    }
    
    func tappedtoolBarBtnToday(_ sender: UIBarButtonItem) {
        DatePicker.date = Date()
        changeLabelDate(Date())
    }
    
    func DateEvent(_ sender: AnyObject?) {
        var dateSelector: UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(DatePicker.date as Date)
    }
    
    func changeLabelDate(_ date: Date) {
        DateSelector.text = self.dateToString(date)
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
            return 5
        }else if pickerView == MpickerView {
            return 30
        }else if pickerView == SpickerView {
            return 12
        }else{
            return 12
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == LpickerView {
            return "Lv.\(row)"
        }else if pickerView == MpickerView{
            return "\(row)人"
        }else if pickerView == SpickerView{
            return "\(row+8)"
        }else{
            return "\(row+8)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == LpickerView {
            self.LevelSelector.text = "Lv.\(row)"
            self.level = row
        }else if pickerView == MpickerView {
            self.MemberSelector.text = "\(row)人"
            self.member = row
        }else if pickerView == SpickerView {
            self.StartSelector.text = "\(row+8)時"
        }else{
            self.EndSelector.text = "\(row+8)時"
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
    
    func DateLabel(_ date: Date) {
        DateSelector.text = self.dateToString(date)
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let comps: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekday], from: date)
        var weekdays: Array = [nil, "日","月","火","水","木","金","土"]
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date as Date)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if Comment.textColor == UIColor.lightGray {
            Comment.text = nil
            Comment.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if  (Comment.text?.isEmpty)! {
            Comment.text = "コメント"
            Comment.textColor = UIColor.lightGray
        }
    }
    
    func showalert() {
        let alert: UIAlertController = UIAlertController(title: "未記入の場所があります", message: "入力してください", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func PostButton(_ sender: UIButton) {
        
        if PlaceView.text == "" {
            self.showalert()
        }else if StartSelector.text == "" {
            self.showalert()
        }else if EndSelector.text == "" {
            self.showalert()
        }else if MemberSelector.text == "" {
            self.showalert()
        }else if LevelSelector.text == "" {
            self.showalert()
        }else if Comment.text == "コメント" {
            self.showalert()
        }else{
            let board = Board(place: String, date: Int, startTIme: Int, endTime: Int, member: Int, level: Int, comment: String, uid: String)
            self.dismiss(animated: true, completion: nil)
            ref = database.collection("Boards").addDocument(data:
                board.toDictionary())
        }
    }
    
    @IBAction func backbutton(_ segue: UIStoryboard) {
        self.view.backgroundColor = ColorManager.buttoncolor
    }
}

