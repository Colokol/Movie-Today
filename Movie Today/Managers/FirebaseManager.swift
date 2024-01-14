//
//  FirebaseManager.swift
//  Movie Today
//
//  Created by macbook on 14.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() {}
    
    let id = Auth.auth().currentUser?.uid
    let firestore = Firestore.firestore()
    
    //MARK: - Register
    func registerUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self, let result = result, error == nil else { return }
            let ref = Database.database().reference().child("users")
            ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
            NotificationCenter.default.post(name: NSNotification.Name("UserDidAuthenticate"), object: nil)
        }
    }
    //MARK: - Login
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            NotificationCenter.default.post(name: NSNotification.Name("UserDidAuthenticate"), object: nil)
            
        }
    }
    //MARK: - Exit
    func exitMethod() {
        do {
            try Auth.auth().signOut()
            let vc = AuthViewController()
            // набор всех сцен, которые в данный момент подключены к приложению
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               //забираем первое окно из массива
               let window = windowScene.windows.first {
                //делаем его корневым и видимым
                window.rootViewController = vc
                window.makeKeyAndVisible()
                //переход к окну
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
            }
            print("Exit-----------------")
        } catch {
            print("Error exit")
        }
    }
    
    //MARK: - Save to Storage
    func uploadImageToFirebaseStorage(_ image: UIImage, for userId: String) {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Не удалось получить данные из изображения")
                return
            }
            let storageRef = Storage.storage().reference().child("userimages/\(userId)/profile.jpg")
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                guard metadata != nil else {
                    print(error?.localizedDescription)
                    return
                }
                storageRef.downloadURL { url, error in
                    guard let downloadURL = url else {
                        print(error?.localizedDescription)
                        return
                    }
                    self.saveImageUrlToFirebaseDatabase(imageUrl: downloadURL.absoluteString, for: userId)
                }
            }
        }
    
    //MARK: - Save to dataBase(RealTime)
    private func saveImageUrlToFirebaseDatabase( imageUrl: String, for userId: String) {
        let ref = Database.database().reference()
        ref.child("users").child(userId).child("profileImageUrl").setValue(imageUrl) { error, _ in
            if let error = error {
                print("Ошибка при сохранении URL изображения: (error.localizedDescription)")
            } else {
                print("URL изображения успешно сохранен.")
            }
        }
    }
    
    //MARK: - UserInfo from firebase
    //ПЕРВЫЙ МЕТОД УБРАТЬ, НАМ НУЖЕН ВТОРОЙ, КОТОРЫЙ С ФОТКОЙ
    func fetchUserInfo(completion: @escaping (_ name: String?, _ email: String?) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let ref = Database.database().reference().child("users").child(id)
        ref.observeSingleEvent(of: .value) { snapshot, _ in
            if let userData = snapshot.value as? [String: AnyObject] {
                let name = userData["name"] as? String ?? "No name"
                let email = userData["email"] as? String ?? "No email"
                completion(name, email)
            }
        }
        
    }
    
    //ВОТ ЭТОТ НУЖЕН
    func fetchUserInfo(сompletion: @escaping (_ name: String?, _ email: String?, _ image: URL?) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let ref = Database.database().reference().child("users").child(id)
        ref.observeSingleEvent(of: .value) { snapshot, _ in
            if let userData = snapshot.value as? [String: AnyObject] {
                let name = userData["name"] as? String ?? "No name"
                let email = userData["email"] as? String ?? "No email"
                let userImage = userData["profileImageUrl"] as? URL
                self.fetchProfileImageUrl(for: id) { result in
                    switch result {
                    case .success(let success):
                        let url = URL(string: success)
                        сompletion(name, email, url)
                    case .failure(let error):
                        print(error.localizedDescription, "Error in fetchUserInfo firebase")
                    }
                }
            }
        }
    }
    //MARK: - Fetch imageURL
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
    
    
}
