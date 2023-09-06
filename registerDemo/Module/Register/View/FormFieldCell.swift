//
//  FormFieldCell.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import UIKit


class FormFieldCell: UITableViewCell {
    
    static let reuseIdentifier = "FormFieldCell"
    
    // 添加你需要的界面元素，例如标题标签和文本框
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect // 可以根据需要自定义外观
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 在初始化方法中设置界面元素和约束
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 添加标题标签和文本框到单元格视图
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        // 设置标题标签约束
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 120) // 根据需要调整宽度
        ]);
        
        // 设置文本框约束
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // 配置单元格显示的表单字段
    func configure(with formField: FormField) {
        titleLabel.text = formField.title
        textField.placeholder = formField.placeholder
    }
}
