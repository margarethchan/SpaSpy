//
//  NumbersTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NumbersTableViewCell: UITableViewCell {

    lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Numbers"
        return label
    }()
    
    lazy var numbersTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Listed Phone Numbers"
        tf.backgroundColor = .lightGray
        tf.borderStyle = .roundedRect
        return tf
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
        contentView.addSubview(numbersLabel)
        contentView.addSubview(numbersTextField)
    }
    
    private func setUpConstraints() {
        numbersLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView)
        }

        numbersTextField.snp.makeConstraints { (make) in
            make.top.equalTo(numbersLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
