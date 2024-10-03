//
//  ContentView.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        UserView()
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, CorePersistenceController.preview.container.viewContext)
}
