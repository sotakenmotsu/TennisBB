//
//  ContentsViewController.swift
//  TennisBB
//
//  Created by 剱物蒼太 on 2017/01/21.
//  Copyright © 2017年 剱物蒼太. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var LevelSelector: UITextField!
    var LpickerView: UIPickerView = UIPickerView()
    let Llist = ["", "ベテラン", "初心者", "まあまあ", "誰でも"]
    
    @IBOutlet weak var MemberSelector: UITextField!
    var MpickerView: UIPickerView = UIPickerView()
    let Mlist = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        LpickerView.delegate = self
        LpickerView.dataSource = self
        LpickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ContentsViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ContentsViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.LevelSelector.inputView = LpickerView
        self.LevelSelector.inputAccessoryView = toolbar
        
        MpickerView.delegate = self
        MpickerView.dataSource = self
        MpickerView.showsSelectionIndicator = true
        
        self.MemberSelector.inputView = MpickerView
        self.MemberSelector.inputAccessoryView = toolbar


        // Do any additional setup after loading the view.
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
        }else{
            return Mlist.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == LpickerView {
            return Llist[row]
        }else{
            return Mlist[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.LevelSelector.text = Llist[row]
        self.MemberSelector.text = Mlist[row]
    }
    
    func cancel() {
        self.LevelSelector.text = ""
        self.LevelSelector.endEditing(true)
        self.MemberSelector.text = ""
        self.MemberSelector.endEditing(true)
        
    }
    
    func done() {
        self.LevelSelector.endEditing(true)
        self.MemberSelector.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
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
