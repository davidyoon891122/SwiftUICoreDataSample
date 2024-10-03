//
//  UserView.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import SwiftUI
import CoreData

struct UserView<Model>: View where Model: UserViewModelProtocol {


    @ObservedObject private var viewModel: Model

    init(viewModel: Model) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    Text(user.name)
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.loadUsers()
            }
        }
    }

}

#Preview {
    let viewContext = CorePersistenceController.preview.container.viewContext
    UserView(viewModel: UserViewModel(viewContext: viewContext))
}
