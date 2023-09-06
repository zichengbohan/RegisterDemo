//
//  RegisterVC.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import Foundation
import UIKit

struct FormField: Hashable {
    var title: String
    var placeholder: String
    
    // Implement the hash(into:) method to calculate the hash value
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(placeholder)
    }
    
    // Implement the equality operator (==) for comparing instances
    static func == (lhs: FormField, rhs: FormField) -> Bool {
        return lhs.title == rhs.title && lhs.placeholder == rhs.placeholder
    }
}

class RegisterVC: UITableViewController {
    //    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Int, FormField>!
    
    // MARK: - Form Fields
    
    private var firstNameField = FormField(title: "First Name", placeholder: "Enter your first name")
    private var lastNameField = FormField(title: "Last Name", placeholder: "Enter your last name")
    //    private var avatarColorField = AvatarColorFormField()
    private var additionalInfoField = FormField(title: "Additional Info", placeholder: "Enter additional information")
    
    override func viewDidLoad() {
        super.viewDidLoad();
        title = "Register";
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(FormFieldCell.self, forCellReuseIdentifier: FormFieldCell.reuseIdentifier);
        // Create the data source
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, formField) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: FormFieldCell.reuseIdentifier, for: indexPath) as! FormFieldCell
            cell.configure(with: formField)
            return cell
        });
        
        // Set up the form fields
        let formFields: [FormField] = [firstNameField, lastNameField, additionalInfoField]
        var snapshot = NSDiffableDataSourceSnapshot<Int, FormField>()
        snapshot.appendSections([0])
        snapshot.appendItems(formFields)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        
    }
}



