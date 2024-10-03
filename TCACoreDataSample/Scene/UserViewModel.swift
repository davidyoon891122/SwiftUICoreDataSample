//
//  UserViewModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import Foundation
import CoreData

protocol UserViewModelProtocol: ObservableObject {

    var users: [User] { get }

    func loadUsers()
    func addItem()
    func deleteItem(indexSet: IndexSet)

}

final class UserViewModel {

    private let viewContext: NSManagedObjectContext

    @Published var users: [User] = []

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

}

extension UserViewModel: UserViewModelProtocol {

    func addItem() {

        let user = User(context: viewContext)
        user.name = "Adam"
        user.age = 90

        viewContext.insert(user)

        self.loadUsers()

    }

    func loadUsers() {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]

        do {
            self.users = try self.viewContext.fetch(request)
        } catch {
            print("Load users error: \(error.localizedDescription)")
        }
    }

    func deleteItem(indexSet: IndexSet) {
        indexSet.map { self.users[$0] }.forEach(self.viewContext.delete)

        do {
            try self.viewContext.save()
            self.users.remove(atOffsets: indexSet)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

    }

}
