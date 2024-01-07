//
//  EditProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 26.12.2023.
//

import UIKit

class EditProfileViewController: UIViewController {

    //MARK: - User interface elements
    
    let editProfileView = EditProfileView()
    let userView = UserView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call function's
        setupView()
        signatureDelegate()
        setupConstaints()
    }

    //MARK: - Private methods
    
    private func setupView() {
        
        // Setup view
        view.addSubviews(editProfileView)
        
        // Add target's
        editProfileView.addTargetFofEditButton(target: self, selector: #selector(changeImage))
    }

    private func signatureDelegate() {
        editProfileView.signatureTextFieldDelegate()
    }
    
    @objc func changeImage() {
        
        let cameraIcon = UIImage(systemName: "camera")
        let photoLibrary = UIImage(systemName: "photo")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.choiseImagePicker(.camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.choiseImagePicker(.photoLibrary)
        }
        
        photo.setValue(photoLibrary, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true)
    }
}

//MARK: - Extension

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func choiseImagePicker(_ sourse: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        editProfileView.userImage.image = info[.editedImage] as? UIImage
        editProfileView.userImage.contentMode = .scaleAspectFit
        editProfileView.userImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

private extension EditProfileViewController {
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            editProfileView.topAnchor.constraint(equalTo: view.topAnchor),
            editProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
