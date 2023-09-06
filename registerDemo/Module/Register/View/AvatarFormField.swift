//
//  AvatarFormField.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import Foundation
import UIKit

struct AvatarFormField {
    var selectedColor: UIColor = .white // Default color
    
    // Additional properties or methods specific to avatar color selection can be added here
}

class AvatarFormFieldCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setupView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let avatar = UILabel();
        self.addSubview(avatar);
    }
    
}
