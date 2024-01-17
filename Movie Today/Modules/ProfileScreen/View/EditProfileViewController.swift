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
    
    //MARK: - Properties
    
    var wbImage = SDWebImageManager.shared
    var presenter: EditScreenViewPresenter?
    
    //MARK: - User interface elements
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private lazy var editUserImage: UIButton = {
        let button = UIButton()
        button.backgroundColor = .background
        button.tintColor = .cyan
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var userEmail: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    private lazy var nameLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Full name"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .montserratMedium(ofSize: 18)
        textField.textColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.whiteGray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.size.height))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var mistakeLabel: UILabel = {
        let label = UILabel()
        label.text = "* Name already exist"
        label.textColor = .red
        label.font = .montserratMedium(ofSize: 13)
        return label
    }()
    private lazy var emailLabelTextField: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.backgroundColor = .background
        label.textAlignment = .center
        label.font = .montserratMedium(ofSize: 15)
        label.textColor = .white
        return label
    }()
    private lazy var emailTextField: UITextField = {
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
        button.setTitleColor(.background, for: .normal)
        return button
    }()
    
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
        view.backgroundColor = .background
        view.addSubviews(userImage,
                         editUserImage,
                         nameLabel,
                         userEmail,
                         nameTextField,
                         nameLabelTextField,
                         mistakeLabel,
                         emailTextField,
                         emailLabelTextField,
                         saveChangesButton
        )
        
        // Add target's
        editUserImage.addTarget(target, action: #selector(changeImage), for: .touchUpInside)
        saveChangesButton.addTarget(target, action: #selector(saveChangesTapped), for: .touchUpInside)
        
        // Setup user image
        userImage.layer.cornerRadius = 50
        
        // Setup button's
        editUserImage.layer.cornerRadius = 15
        saveChangesButton.layer.cornerRadius = 25
        
        // Setup text field's
        nameTextField.layer.cornerRadius = 20
        emailTextField.layer.cornerRadius = 20
    }
    
    private func signatureDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
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
        guard let savedImage = userImage.image else { return }
        uploadImageToFirebaseStorage(savedImage, for: id)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension
//MARK: UITextFieldDelegate methods
extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//MARK: UIImagePickerControllerDelegate methods
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
        userImage.image = info[.editedImage] as? UIImage
        userImage.contentMode = .scaleAspectFit
        userImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

//MARK: Firebase methods
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

//MARK: EditScreenViewPresenter methods
extension EditProfileViewController: EditScreenViewPresenter {
    func updateData(_ name: String?, email: String?, image: URL?) {
        guard let name, let email, let image else { return }
        self.nameLabel.text = name
        self.nameTextField.text = name
        self.userEmail.text = email
        self.emailTextField.text = email
        self.wbImage.setImageFromUrl(image: userImage, url: image)
    }
}

//MARK: Constraints
private extension EditProfileViewController {
    
    enum Constans {
        static let fivePoints: CGFloat = 5
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let sideMargin: CGFloat = 24
        static let thiryPoints: CGFloat = 30
        static let fiftyPoints: CGFloat = 50
        static let fiftyFivePoints: CGFloat = 55
        static let seventyPoints: CGFloat = 70
        static let ninetyPoints: CGFloat = 90
        static let oneHundredPoints: CGFloat = 100
        static let twoHundredPoints: CGFloat = 200
    }
    
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            
            // User image
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constans.oneHundredPoints),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            userImage.widthAnchor.constraint(equalToConstant: Constans.oneHundredPoints),
            
            // Edit user image button
            editUserImage.trailingAnchor.constraint(equalTo: userImage.trailingAnchor),
            editUserImage.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
            editUserImage.heightAnchor.constraint(equalToConstant: Constans.thiryPoints),
            editUserImage.widthAnchor.constraint(equalToConstant: Constans.thiryPoints),
            
            // Name label
            nameLabel.topAnchor.constraint(equalTo: editUserImage.bottomAnchor, constant: Constans.twentyPoints),
            nameLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            nameLabel.widthAnchor.constraint(equalToConstant: Constans.seventyPoints),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // User email
            userEmail.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constans.tenPoints),
            userEmail.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            userEmail.widthAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            userEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Name text field
            nameTextField.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: Constans.seventyPoints),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.sideMargin),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.sideMargin),
            nameTextField.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            
            // Name text field label
            nameLabelTextField.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: Constans.tenPoints),
            nameLabelTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: Constans.twentyPoints),
            nameLabelTextField.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            nameLabelTextField.widthAnchor.constraint(equalToConstant: Constans.ninetyPoints),
            
            // Mistake label
            mistakeLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Constans.fivePoints),
            mistakeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.sideMargin),
            mistakeLabel.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            mistakeLabel.widthAnchor.constraint(equalToConstant: Constans.twoHundredPoints),
            
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: mistakeLabel.bottomAnchor, constant: Constans.twentyPoints),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.sideMargin),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.sideMargin),
            emailTextField.heightAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            
            // Email text field
            emailLabelTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: Constans.tenPoints),
            emailLabelTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: Constans.twentyPoints),
            emailLabelTextField.heightAnchor.constraint(equalToConstant: Constans.twentyPoints),
            emailLabelTextField.widthAnchor.constraint(equalToConstant: Constans.fiftyPoints),
            
            saveChangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constans.seventyPoints),
            saveChangesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constans.sideMargin),
            saveChangesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constans.sideMargin),
            saveChangesButton.heightAnchor.constraint(equalToConstant: Constans.fiftyFivePoints),
        ])
    }
}
