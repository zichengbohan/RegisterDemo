//
//  UserRegisterViewModel.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import Foundation
import UIKit

// MARK: - ViewModel

class RegistrationViewModel {
    @Published var user = User()
    
    func updateUserFirstName(_ firstName: String) {
        user.firstName = firstName
    }
    
    func updateUserLastName(_ lastName: String) {
        user.lastName = lastName
    }
    
    func updateAvatarColor(_ color: UIColor) {
        user.avatarColor = color
    }
    
    func updateAdditionalInfo(_ info: String) {
        user.additionalInfo = info
    }
    
    func createUserAccount() {
        // Implement API call to create user account (MOCK)
        print("Creating user account...")
    }
}
