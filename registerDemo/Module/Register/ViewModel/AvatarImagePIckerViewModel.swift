//
//  AvatarImagePIckerViewModel.swift
//  registerDemo
//
//  Created by playcrab on 2023/9/6.
//

import Foundation
import Combine
import UIKit

class AvatarImagePIckerViewModel {
    // 输入
    var selectedAvatarImage: CurrentValueSubject<UIImage?, Never> = .init(nil)
    var selectedColor: CurrentValueSubject<UIColor, Never> = .init(.red)
    
    // 输出
    var avatarImage: AnyPublisher<UIImage?, Never> {
        return selectedAvatarImage.eraseToAnyPublisher()
    }
    
    var backgroundColor: AnyPublisher<UIColor, Never> {
        return selectedColor.eraseToAnyPublisher()
    }
    
    func selectAvatarImage(_ image: UIImage?) {
        selectedAvatarImage.value = image
    }
    
    func selectColor(_ color: UIColor) {
        selectedColor.value = color
    }
}

