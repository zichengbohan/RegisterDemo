//
//  ViewController.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import UIKit
import Foundation

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

class ViewController: UIViewController {
    
    
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Int, FormField>!
    
    // MARK: - Form Fields
       
    private var firstNameField = FormField(title: "First Name", placeholder: "Enter your first name")
    private var lastNameField = FormField(title: "Last Name", placeholder: "Enter your last name")
    private var avatarColorField = AvatarColorFormField()
    private var additionalInfoField = FormField(title: "Additional Info", placeholder: "Enter additional information")
       
        

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

