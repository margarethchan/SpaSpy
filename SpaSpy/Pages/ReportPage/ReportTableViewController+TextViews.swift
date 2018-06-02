//
//  ReportTableViewController+TextViews.swift
//  SpaSpy
//
//  Created by C4Q on 6/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

extension ReportTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView.tag {
        case 2:
            if textView.text == "Other Type of Business" {
                textView.text = ""
            }
        case 4:
            if textView.text == "Listed Phone Numbers" {
                textView.text = ""
            }
        case 5:
            if textView.text == "Listed Web Pages" {
                textView.text = ""
            }
        case 6:
            if textView.text == "Other Notes" {
                textView.text = ""
            }
        default:
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView.tag {
        case 2:
            if textView.text == "" {
                textView.text = "Other Type of Business"
            }
        case 4:
            if textView.text == "" {
                textView.text = "Listed Phone Numbers"
            } else {
                self.enteredNumbers = textView.text
            }
        case 5:
            if textView.text == "" {
                textView.text = "Listed Web Pages"
            } else {
                self.enteredWebpages = textView.text
            }
        case 6:
            if textView.text == "" {
                textView.text = "Other Notes"
            } else {
                self.enteredNotes = textView.text
            }
        default:
            textView.text = ""
        }
    }
}
