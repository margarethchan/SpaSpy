//
//  FlagTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FlagTableViewCell: UITableViewCell {

//    var value : Bool = false
    
    // label
    lazy var flagLabel: UILabel = {
        let label = UILabel()
        label.text = "Flag Description"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
//        label.backgroundColor = .green
        return label
    }()
    
//    lazy var switchObject: UISwitch = {
//       let s = UISwitch()
//        s.onTintColor = .red
//        s.tintColor = .gray
////        s.backgroundColor = .cyan
//        return s
//    }()

//    @objc func flagSelected(sender: UISwitch) {
//        self.value = sender.isOn
//    }
    
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    
            // Configure the view for the selected state
        }
    
    // custom table view cell
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func configureCell(withFlagDescription: String, selected: Bool) -> Bool {
        self.flagLabel.text = withFlagDescription
        self.isSelected = selected
        return selected
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
//        contentView.addSubview(switchObject)
        contentView.addSubview(flagLabel)
    }
    
    private func setUpConstraints() {
//        switchObject.snp.makeConstraints { (make) in
//            make.centerY.equalTo(contentView.snp.centerY)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
//
//        }


        flagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.trailing.equalTo(contentView)
//            make.trailing.equalTo(switchObject.snp.leading).offset(-5)
        }
        
        
        
    }
    
    
    
}
