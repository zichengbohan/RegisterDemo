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
    
    static let reuseIdentifier = "AvatarFormFieldCell"
    
    // titleLabel UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }();
    
    private let avatarImage: UIView = {
        let image = ImagePIckerWithColorView(viewModel: AvatarImagePIckerViewModel());
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.isUserInteractionEnabled = true;
        setUI();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(titleLabel);
        contentView.addSubview(avatarImage);
        //set titleLabel constraint
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 120) // 根据需要调整宽度
        ]);
        
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
                        avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 100)
            
        ]);
    }
    
    // config cell's value to show
    func configure(with formField: FormField) {
        titleLabel.text = formField.title
    }
    
}
