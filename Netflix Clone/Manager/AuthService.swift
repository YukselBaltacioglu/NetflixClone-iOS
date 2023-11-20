//
//  AuthService.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 18.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreInternal 


class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    
    
    /// A method to regiter the user
    /// - Parameters:
    ///   - userRequest: The users informations (email, password)
    ///   - completion: A completion with two values...
    ///   - Bool: wasRegistered: Determined if the user was registered and saved in database coorectly
    ///   - Error?: An optional error if Firebase provides once
    ///
    public func registerUser(with userRequest: UserRegisterRequest,
            completion: @escaping(Bool,Error?)->Void) {
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = result?.user else{
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData(["email": email]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    
    public func signIn(with userRequest: UserRequest,
                             completion: @escaping(Error?)->Void) {
        
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
        
    }
    
    public func signOut(completion: @escaping(Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    
    
}
