//
//  ReportDriverVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ReportDriverVC: UIViewController {

     //MARK:- IBOUTLET
    @IBOutlet weak var reportTextView: UITextView!
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

       reportTextView.text = "Enter report reason here..."
        reportTextView.textColor = UIColor.lightGray
    }
    


}
 //MARK:- TEXTVIEW DELEGATE METHOD
extension ReportDriverVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reportTextView.textColor == UIColor.lightGray {
            reportTextView.text = nil
            reportTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reportTextView.text.isEmpty {
            reportTextView.text = "Enter report reason here..."
            reportTextView.textColor = UIColor.lightGray
        }
    }
}
