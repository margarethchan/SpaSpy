//
//  WebpagesTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WebpagesTableViewCell: UITableViewCell {

    // Medium Scrollable Text View
    
    lazy var webpagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Web Pages"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var webpagesTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Listed Web Pages"
        tv.isEditable = true
        tv.textColor = .lightGray
        tv.isScrollEnabled = true
        tv.layer.borderWidth = 1
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
        contentView.addSubview(webpagesLabel)
        contentView.addSubview(webpagesTextView)
    }
    
    private func setUpConstraints() {
        webpagesLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
        }
        
        webpagesTextView.snp.makeConstraints { (make) in
            make.top.equalTo(webpagesLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(60)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
