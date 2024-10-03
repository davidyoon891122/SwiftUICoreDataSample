//
//  ContentView.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var context

    var body: some View {
        UserView(viewModel: UserViewModel(viewContext: context))
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, CorePersistenceController.preview.container.viewContext)
}
