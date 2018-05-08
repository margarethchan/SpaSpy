//
//  NotesTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NotesTableViewCell: UITableViewCell {

    // Large Scrollable Text View
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        return label
    }()
    
    lazy var notesTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Other Notes"
        tv.backgroundColor = .lightGray
        tv.textColor = .gray
        tv.isScrollEnabled = true
        tv.font = UIFont.systemFont(ofSize: 17)
        return tv
    }()
    
    // Small Scrollable Text View
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // custom table view cell
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(notesLabel)
        contentView.addSubview(notesTextView)
    }
    
    private func setUpConstraints() {
        notesLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView)
        }
        
        notesTextView.snp.makeConstraints { (make) in
            make.top.equalTo(notesLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(100)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
