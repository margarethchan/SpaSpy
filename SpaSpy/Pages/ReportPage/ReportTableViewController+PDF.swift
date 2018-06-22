//
//  ReportTableViewController+PDF.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import SimplePDF
import MessageUI

extension ReportTableViewController: MFMailComposeViewControllerDelegate {
    
    public func collectPDFInputs() {
        // COLLECT DATA FOR PDF REPORT
        self.pdf = SimplePDF(pageSize: A4paperSize, pageMargin: pageMargin)
        
        pdf.setContentAlignment(.center)
        let logoImage = #imageLiteral(resourceName: "icon_83.5")
        pdf.addImage(logoImage)
        pdf.addText("Spa Spy Report", font: UIFont.boldSystemFont(ofSize: 20), textColor: .blue)
        pdf.addLineSpace(10.0)
        
        pdf.addText("Reported on: " + currentTimestampFull, font: UIFont.systemFont(ofSize: 10), textColor: .black)
        pdf.addLineSpace(30)
        
        pdf.setContentAlignment(.left)
        pdf.addText("Business Location", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        if self.selectedLocationAddress != "" {
            pdf.addText((self.selectedLocation?.name)!)
            pdf.addText(self.selectedLocationAddress)
            pdf.addText("Coordinates: ")
            pdf.addText("Lat: " + (self.selectedLocation?.coordinate.latitude.description)! + " Long: " + (self.selectedLocation?.coordinate.longitude.description)!)
        } else {
            pdf.addText("No Location Selected")
        }
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Types", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        addBusinessTypeInputs()
        if !self.selectedBusinessTypes.isEmpty {
            self.selectedBusinessTypes.forEach { (type) in
                pdf.addText(type)
            }
        } else {
            pdf.addText("No Business Type Selected")
        }
        pdf.addLineSpace(20.0)
        
        pdf.addText("Red Flags", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        if !self.selectedRedFlags.isEmpty {
            self.selectedRedFlags.forEach { (flag) in
                pdf.addText(flag.description)
            }
        } else {
            pdf.addText("No Red Flags Selected")
        }
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Phone Numbers", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredNumbers)
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Webpages", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredWebpages)
        pdf.addLineSpace(20.0)
        
        let notesTVC = self.tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? NotesTableViewCell
        pdf.addText("Other Notes", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredNotes)
        pdf.addLineSpace(20.0)
        
        pdf.addText("Photos of the Business", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        self.uploadedPhotos.forEach { (image) in
            pdf.addImage(image)
            pdf.beginNewPage()
        }
        
        // Generate PDF data and save to a local file.
        createPDFfile()
    }
    
    private func createPDFfile() {
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            // Generate PDF File Name
            let separators = CharacterSet(charactersIn: "/, ")
            fileName = currentTimestampShort.components(separatedBy: separators).joined(separator: "") + ".pdf"
            let documentsFileName = documentDirectories + "/" + fileName
            pdfData = pdf.generatePDFdata()
            do {
                // Write the PDF to file
                try pdfData?.write(to: URL(fileURLWithPath: documentsFileName), options: .atomicWrite)
                print("\nThe generated pdf can be found at:")
                print("\n\t\(documentsFileName)\n")
                // Alert to Submit PDF via Email
                sendPDFtoEmail()
            } catch {
                print(error)
            }
        }
    }
    
    private func sendPDFtoEmail() {
        let emailAlert = Alert.create(withTitle: "Email PDF to SpaSpy?", andMessage: "Would you like to email a PDF to SpaSpy?", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Yes", style: .default, andHandler: { (_) in
            // Send PDF to My Email
            let mailComposeViewController = MFMailComposeViewController()
            //mailComposeViewController.mailComposeDelegate = self

            if MFMailComposeViewController.canSendMail() {
                mailComposeViewController.delegate = self
                mailComposeViewController.setSubject("Spa Spy Report: " + self.fileName)
                mailComposeViewController.addAttachmentData(self.pdfData!, mimeType: "application/pdf", fileName: self.fileName)
                mailComposeViewController.setToRecipients(["SpaSpyApp@gmail.com"])
                self.present(self.mailComposeViewController, animated: true, completion: nil)
            } else {
                print("No email sending capability on this device")
            }
        }, to: emailAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: emailAlert)
        self.present(emailAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
    }
    
}
