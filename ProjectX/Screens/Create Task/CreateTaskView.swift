//
//  CreateTaskView.swift
//  ProjectX
//
//  Created by William Hass on 2020-06-29.
//

import SwiftUI

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView(save: {})
    }
}

struct CreateTaskView: View {
    @State var taskType: Int = 0
    let save: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Criar Tarefa").font(.largeTitle).bold()
                Spacer()
                Button("Salvar", action: save) 
            }
            .padding()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    TaskTypeView(taskType: $taskType)
                    switch taskType {
                    case 0:
                        SymptonTaskOptionsView()
                    case 1:
                        SideEffectsTaskOptionsView()
                    case 2:
                        MedicationTaskOptionsView()
                    default:
                        EmptyView()
                    }
                    HStack(spacing: 8) {
                        Checkbox(marked: .constant(true))
                            .scaleEffect(0.9)
                        Text("Enviar notificações ao paciente")
                            .font(.body)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct TaskTypeView: View {
    @Binding var taskType: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Tipo").font(.callout)
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
    }
}

struct SymptonTaskOptionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Monitorar sintoma").font(.callout)
            TextField("Descrição do sintoma", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            VStack(alignment: .leading, spacing: 8) {
                Text("Sugestões").font(.caption)
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Ansiedade",
                                severity: .veryLow
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Pânico",
                                severity: .low
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Desânimo",
                                severity: .medium
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Mania",
                                severity: .high
                            )
                        )
                    }
                    HStack(spacing: 4) {
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Hiperatividade",
                                severity: .veryHigh
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Desatenção",
                                severity: .high
                            )
                        )
                    }
                }
            }
            .padding(.top, 6)
        }
    }
}

struct SideEffectsTaskOptionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Monitorar efeito colateral").font(.callout)
            TextField("Efeito colateral", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            VStack(alignment: .leading, spacing: 8) {
                Text("Sugestões").font(.caption)
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Dor de cabeça",
                                severity: .high
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Pouco apetite",
                                severity: .medium
                            )
                        )
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Palpitação",
                                severity: .veryLow
                            )
                        )
                    }
                    HStack(spacing: 4) {
                        ComorbityView(
                            comorbity: Comorbity(
                                id: UUID(),
                                name: "Insônia",
                                severity: .low
                            )
                        )
                    }
                }
            }
            .padding(.top, 6)
        }
    }
}

struct MedicationTaskOptionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Uso de medicação").font(.callout)
            TextField("Nome", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                TextField("Dosagem", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)
                Picker("Medida", selection: .constant(0)) {
                    Text("mg").tag(0)
                    Text("g").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
            }
            HStack {
                DatePicker(
                    "Horário",
                    selection: .constant(Date()),
                    displayedComponents: .hourAndMinute)
                    .font(.callout)
                Image(systemName: "plus.circle")
                    .foregroundColor(Color(.systemBlue))
            }
        }
    }
}
