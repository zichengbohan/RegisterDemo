//
//  ImagePIckerWithColorView.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import UIKit
import Combine
import PhotosUI

class ImagePIckerWithColorView: UIView, UIColorPickerViewControllerDelegate, PHPickerViewControllerDelegate {
    
    
    
    private let avatarImageView = UIImageView();
    private let avatarImagePickerButton = UIButton();
    private let colorPickerButton = UIButton();
    private var cancellables: Set<AnyCancellable> = [];
    
    init(viewModel: AvatarImagePIckerViewModel) {
        super.init(frame: .zero)
        setupUI()

        viewModel.avatarImage
            .sink { [weak self] image in
//                self?.avatarImageView.image = image
            }
            .store(in: &cancellables)

        viewModel.backgroundColor
            .sink { [weak self] color in
                self?.backgroundColor = color
            }
            .store(in: &cancellables)

    }
    
    private func setupUI() {
        // Add UI elements to the view and set up Auto Layout constraints
        colorPickerButton.backgroundColor = .blue;
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside);
        colorPickerButton.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(colorPickerButton);
        
        avatarImageView.backgroundColor = .yellow
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false;
        avatarImageView.layer.cornerRadius = 35;
        colorPickerButton.addSubview(avatarImageView);
        
        avatarImagePickerButton.translatesAutoresizingMaskIntoConstraints = false;
//        avatarImagePickerButton.backgroundColor = .red
        avatarImagePickerButton.addTarget(self, action: #selector(imagePickeButtonTaped), for: .touchUpInside);
        colorPickerButton.addSubview(avatarImagePickerButton);

        NSLayoutConstraint.activate([
            colorPickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorPickerButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 100),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 100)
        ]);
        
        NSLayoutConstraint.activate([
            avatarImageView.trailingAnchor.constraint(equalTo: colorPickerButton.trailingAnchor, constant: -15),
            avatarImageView.leftAnchor.constraint(equalTo: colorPickerButton.leftAnchor, constant: 15),
            avatarImageView.topAnchor.constraint(equalTo: colorPickerButton.topAnchor, constant: 15),
            avatarImageView.bottomAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: -15)
        ]);
        
        NSLayoutConstraint.activate([
            avatarImagePickerButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 0),
            avatarImagePickerButton.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor, constant: 0),
            avatarImagePickerButton.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0),
            avatarImagePickerButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0)
        ]);
    }
    
    // button Clicked
    @objc func colorPickerButtonTapped() {
        let colorPicker = UIColorPickerViewController();
        colorPicker.delegate = self;
        if #available(iOS 15, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {

                if let topViewController = windowScene.windows
                    .filter({ $0.isKeyWindow })
                    .first?
                    .rootViewController {
                    topViewController.present(colorPicker, animated: true, completion: nil);

                }
            }
        } else {
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                // topViewController 现在是当前的视图控制器
                print("当前视图控制器：\(topViewController)")
                topViewController.present(colorPicker, animated: true, completion: nil);
            }
        }
    }
    
    @objc func imagePickeButtonTaped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images  // 过滤为图片
        configuration.selectionLimit = 1  // 设置选择的图片数量限制
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        if #available(iOS 15, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {
                
                if let topViewController = windowScene.windows
                    .filter({ $0.isKeyWindow })
                    .first?
                    .rootViewController {
                    topViewController.present(picker, animated: true, completion: nil);
                    
                }
            }
        } else {
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                // topViewController 现在是当前的视图控制器
                print("当前视图控制器：\(topViewController)")
                topViewController.present(picker, animated: true, completion: nil);
            }
        }
        
    }
    
    // photo picker delegate method
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
