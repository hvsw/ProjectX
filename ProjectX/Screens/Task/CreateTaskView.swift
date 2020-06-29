//
//  CreateTaskView.swift
//  ProjectX
//
//  Created by William Hass on 2020-06-29.
//

import SwiftUI

struct CreateTaskView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyVStack {
                Text("Hello, World!")
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Criar Tarefa")
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTaskView()
        }
    }
}
