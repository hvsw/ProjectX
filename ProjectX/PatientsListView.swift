//
//  PatientsListView.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct PatientsListView: View {
    
    let patients: [Patient] = Storage.patients
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.patients, id: \.id) { patient in
                    NavigationLink(destination: PatientDetailView(patient: patient)) {
                        PatientVerticalCard(patient: patient)
                            .padding(18)
                    }
                }
            }
            .listSeparatorStyle(style: .none)
            .navigationTitle("Pacientes")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print("Novo paciente")
                                    }, label: {
                                        Image(systemName: "plus")
                                    })
            )
        }
    }
}

struct PatientsListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PatientsListView()
            PatientsListView()
                .preferredColorScheme(.dark)
        }
    }
}
