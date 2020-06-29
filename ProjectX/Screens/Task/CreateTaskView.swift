//
//  CreateTaskView.swift
//  ProjectX
//
//  Created by William Hass on 2020-06-29.
//

import SwiftUI

struct CreateTaskView: View {
    
    @State var taskType: Int = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tipo").font(.title)
                        Spacer()
                    }
                    Picker(selection: $taskType,
                           label: Text("Picker")) {
                        Text("Sintoma").tag(0)
                        Text("Efeito colateral").tag(1)
                        Text("Medicação").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Spacer()
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sintoma").font(.title)
                    TextField("Sintoma", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sugestões").font(.caption)
                        HStack {
                            ComorbityView(
                                comorbity: Comorbity(
                                    id: UUID(),
                                    name: "Ansiedade",
                                    severity: .high
                                )
                            )
                            ComorbityView(
                                comorbity: Comorbity(
                                    id: UUID(),
                                    name: "Pânico",
                                    severity: .veryHigh
                                )
                            )
                            ComorbityView(
                                comorbity: Comorbity(
                                    id: UUID(),
                                    name: "Apetite",
                                    severity: .low
                                )
                            )
                            ComorbityView(
                                comorbity: Comorbity(
                                    id: UUID(),
                                    name: "Dor de cabeça",
                                    severity: .low
                                )
                            )
                        }
                    }
                    .padding(.top, 6)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Medicação").font(.title)
                    TextField("Nome", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Dosagem", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                    VStack {
                        DatePicker(
                            "Horário",
                            selection: .constant(Date()),
                            displayedComponents: .date)
                    }
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .navigationBarItems(trailing: Button("Salvar") {})
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
