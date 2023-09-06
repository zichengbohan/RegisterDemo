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
    
    private var avatarImageViewModel: AvatarImagePIckerViewModel;
    
    private let avatarImageView = UIImageView();
    private let avatarImagePickerButton = UIButton();
    private let colorPickerButton = UIButton();
    private var cancellables: Set<AnyCancellable> = [];
    
    init(viewModel: AvatarImagePIckerViewModel) {
        avatarImageViewModel = viewModel;
        super.init(frame: .zero);
        
        setupUI()
//        avatarImageViewModel = viewModel;

        viewModel.avatarImage
            .sink { [weak self] image in
                self?.avatarImageView.image = image
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
    
    // MARK: button Clicked
    @objc func colorPickerButtonTapped() {
        let colorPicker = UIColorPickerViewController();
        colorPicker.delegate = self;
        presentNewVC(viewController: colorPicker);
    }
    
    @objc func imagePickeButtonTaped() {
        PHPhotoLibrary.requestAuthorization { status in
               switch status {
               case .authorized:
                   // 用户已授权相册访问权限，可以执行相册操作
                   DispatchQueue.main.async {
                       self.popUpImagePicker();
                   }
                   break
               case .denied, .restricted:
                   // 用户拒绝了相册访问权限，或者权限受到了限制
                   // 提示用户打开设置中的隐私设置以授予权限
                   break
               case .notDetermined:
                   // 用户还没有做出选择，可以在此提供一个说明或者再次请求权限
                   break
               @unknown default:
                   break
               }
           }
        
        
    }
    
    // MARK: private Method
    // 唤起相册
    private func popUpImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images  // 过滤为图片
        configuration.selectionLimit = 1  // 设置选择的图片数量限制
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        presentNewVC(viewController: picker);
    }
    private func presentNewVC(viewController: UIViewController) {
        if #available(iOS 15, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {
                
                if let topViewController = windowScene.windows
                    .filter({ $0.isKeyWindow })
                    .first?
                    .rootViewController {
                    topViewController.present(viewController, animated: true, completion: nil);
                    
                }
            }
        } else {
            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                // topViewController 现在是当前的视图控制器
                print("当前视图控制器：\(topViewController)")
                topViewController.present(viewController, animated: true, completion: nil);
            }
        }
    }
    
    // MARK: photo picker delegate method
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true, completion: nil)
        picker.dismiss(animated: true, completion: nil);
        let itemProvider = results.first?.itemProvider
        itemProvider?.loadObject(ofClass: UIImage.self) { (loadedObject, error) in
            if let error = error {
                // Handle the error, e.g., print an error message or display an alert.
                print("Error loading image: \(error)")
            } else if let image = loadedObject as? UIImage {
                // You have successfully loaded the UIImage, now you can use it.
                DispatchQueue.main.async {
                    self.avatarImageViewModel.selectedAvatarImage.send(image);
                    // Update your UI with the loaded image, e.g., assign it to an imageView.
//                    self.imageView.image = image
                }
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
