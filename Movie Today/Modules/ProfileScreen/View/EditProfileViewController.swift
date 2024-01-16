//
//  EditProfileViewController.swift
//  Movie Today
//
//  Created by Nikita on 26.12.2023.
//

import UIKit
import Firebase
import FirebaseStorage

final class EditProfileViewController: UIViewController {

    //MARK: - User interface elements
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    var editUserImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.tintColor = .cyan
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
     var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var userEmail: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
     var nameLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
     var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .montserratMedium(ofSize: 18)
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.whiteGray.cgColor
         textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    var mistakeLabel: UILabel = {
        let label = UILabel()
        label.text = "* Name already exist"
        label.textColor = .red
        label.font = .montserratMedium(ofSize: 13)
        return label
    }()
    var emailLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .montserratMedium(ofSize: 18)
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = .cyan
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call function's
        setupView()
        signatureDelegate()
        setupConstaints()
        fetchUserInfo()
    }

    //MARK: - Private methods
    
    private func setupView() {
        
        // Setup view
        view.addSubviews(editProfileView)
        
        // Add target's
        editProfileView.addTargetFofEditButton(target: self, selector: #selector(changeImage))
        editProfileView.addTargetsForSaveChengesButton(target: self, selector: #selector(saveChangesTapped))
    }

    private func signatureDelegate() {
        editProfileView.signatureTextFieldDelegate()
    }
    
    func fetchUserInfo() {
        guard let id = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let ref = Database.database().reference().child("users").child(id)
        ref.observeSingleEvent(of: .value) { snapshot, _ in
            if let userData = snapshot.value as? [String: AnyObject] {
                let name = userData["name"] as? String ?? "No name"
                let email = userData["email"] as? String ?? "No email"
                DispatchQueue.main.async {
                    self.editProfileView.nameLabel.text = name
                    self.editProfileView.nameTextField.text = name
                    self.editProfileView.userEmail.text = email
                    self.editProfileView.emailTextField.text = email
                }
                self.fetchProfileImageUrl(for: id) { result in
                    switch result {
                    case .success(let success):
                        let url = URL(string: success)
                        DispatchQueue.main.async {
                            self.editProfileView.userImage.sd_setImage(with: url)
                        }
                    case .failure(let error):
                        print(String(describing: error))
                    }
                }
            }
        }
    }

    
    func fetchProfileImageUrl(for userId: String, completion: @escaping (Result<String, Error>) -> Void) {
        let userImageRef = Database.database().reference().child("users/\(userId)/profileImageUrl")
        userImageRef.observeSingleEvent(of: .value) { snapshot in
            guard let imageUrl = snapshot.value as? String else {
                completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL изображения не найден"])))
                return
            }
            completion(.success(imageUrl))
        }
    }
    
    //MARK: - @objc methods
    
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
    
    @objc func saveChangesTapped() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let savedImage = editProfileView.userImage.image else { return }
        uploadImageToFirebaseStorage(savedImage, for: id)
        navigationController?.popViewController(animated: true)
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

extension EditProfileViewController {
    
    func uploadImageToFirebaseStorage(_ image: UIImage, for userId: String) {
        // Предположим, что у вас есть UIImage
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Не удалось получить данные из изображения")
            return
        }
        
        // Создание ссылки на хранилище для конкретного пользователя
        let storageRef = Storage.storage().reference().child("user_images/\(userId)/profile.jpg")
        
        // Загрузка изображения
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard metadata != nil else {
                print("\(String(describing: error?.localizedDescription)) Привет")
                return
            }
            
            // Получение URL изображения после успешной загрузки
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("\(String(describing: error?.localizedDescription)) пока")
                    return
                }
                
                // Сохранение URL изображения в профиле пользователя в Firebase Database
                saveImageUrlToFirebaseDatabase(downloadURL.absoluteString, for: userId)
            }
        }
        
        func saveImageUrlToFirebaseDatabase(_ imageUrl: String, for userId: String) {
            let ref = Database.database().reference()
            ref.child("users").child(userId).child("profileImageUrl").setValue(imageUrl) { error, _ in
                if let error = error {
                    print("Ошибка при сохранении URL изображения: \(error.localizedDescription)")
                } else {
                    print("URL изображения успешно сохранен.")
                }
            }
        }
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
