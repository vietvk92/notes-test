//
//  FirebaseService.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabaseSwift
import FirebaseFirestoreSwift
import Defaults

struct FireBaseService {
    static let share = FireBaseService()
    
    func getNotesBy<T: Decodable, E: Error>(user: User) -> Future<[T], E> {
        return Future({ promise in
            let ref = Database.database().reference().child("notes")
            let query = ref.queryOrdered(byChild: "userId").queryEqual(toValue: user.id)
            query.observe(.value) { snapshot in
                var data: [T] = []
                for note in snapshot.children {
                    guard let snap = note as? DataSnapshot,
                          let value = snap.value else { return }
                    do {
                        let modelData = try JSONSerialization.data(withJSONObject: value)
                        let model = try JSONDecoder().decode(T.self, from: modelData)
                        data.append(model)
                    } catch let error {
                        print("ERROR: \(error)")
                        promise(.failure(error as! E))
                    }
                }
                promise(.success(data))
            }
        })
    }
    
    func getUsers<T: Decodable, E: Error>() -> Future<[T], E> {
        return Future({ promise in
            let ref = Database.database().reference().child("users")
            ref.observeSingleEvent(of: .value) { snapshot in
                var data: [T] = []
                for note in snapshot.children {
                    guard let snap = note as? DataSnapshot,
                          let value = snap.value else { return }
                    do {
                        let modelData = try JSONSerialization.data(withJSONObject: value)
                        let model = try JSONDecoder().decode(T.self, from: modelData)
                        data.append(model)
                    } catch let error {
                        print("ERROR: \(error)")
                        promise(.failure(error as! E))
                    }
                }
                promise(.success(data))
            }
        })
    }
    
    func addUser<E: Error>(input: InputUserDto) -> Future<User, E> {
        return Future { promise in
            guard let userName = input.username else { return }
            let dbPath = "users"
            let ref = Database.database().reference()
            guard let autoId = ref.child(dbPath).childByAutoId().key else {
                return
            }
            let user = User(id: autoId, userName: userName)
            let itemPath = "\(dbPath)/\(user.userName)"
            ref.child(itemPath).observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    if let userFromSnap = getUserFromSnapShot(data: snapshot) {
                        promise(.success(userFromSnap))
                    } else {
                        promise(.success(user))
                    }
                } else {
                    do {
                        try ref.child(itemPath)
                            .setValue(from: user)
                        promise(.success(user))
                    } catch let error {
                        promise(.failure(error as! E))
                    }
                }
            }
        }
    }
    
    private func getUserFromSnapShot(data: DataSnapshot) -> User? {
        guard let value = data.value else { return nil}
        do {
            let modelData = try JSONSerialization.data(withJSONObject: value)
            let model = try JSONDecoder().decode(User.self, from: modelData)
            return model
        } catch {
            return nil
        }
    }

    func addNote<E: Error>(title: String, content: String) -> Future<Void, E> {
        return Future { promise in
            guard let currentUser = Defaults[.user] else { return }
            let dbPath = "notes"
            let ref = Database.database().reference()
            let note = Note(title: title, content: content, userId: currentUser.id)
            let itemPath = "\(dbPath)/\(note.title)"
            do {
                try ref.child(itemPath)
                    .setValue(from: note)
                promise(.success(()))
            } catch let error {
                promise(.failure(error as! E))
            }
        }
    }

}
