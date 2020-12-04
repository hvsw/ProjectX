//
//  PatientDetailView.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

enum HealthData {
    case sleep(Int, Int)
    case heartRate(Int)
    
    var humanReadableName: String {
        switch self {
        case .heartRate:
            return "Frequência Cardíaca"
            
        case .sleep:
            return "Análise de Sono"
        }
    }
    
    var imageName: String {
        switch self {
        case .heartRate:
            return "suit.heart.fill"
            
        case .sleep:
            return "bed.double.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .heartRate:
            return .red
            
        case .sleep:
            return .orange
        }
    }
}

struct PatientDetailView: View {
    let patient: Patient
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 16) {
                PatientCard(patient: patient)
                MedicineCard()
                HStack {
                    Text("Resumo da semana")
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding(.top, 4)
                SymptomsView()
                SleepDataCell()
                HeartBeatView()
                
            }
            .padding()
        }
        .navigationTitle(patient.name)
    }
}

extension View {
    func card(paddingValue: CGFloat = 12) -> some View {
        padding(paddingValue)
            .background(Color(.systemFill))
            .cornerRadius(12)
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            PatientDetailView(patient: Storage.patients.first!)
            NavigationView {
                PatientDetailView(patient: Storage.patients.first(where: { (patient: Patient) -> Bool in
                    return patient.name == "Henrique Valcanaia"
                })!).colorScheme(.dark)
            }
            .colorScheme(.dark)
            .previewDevice("iPhone 8")
//        }
    }
}

struct MedicineCard: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "staroflife.fill").font(.body)
                Text("Medicação").font(.headline).bold()
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus.circle")
                        .font(.headline)
                }
            }
            .foregroundColor(Color.blue)
            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Lamictal 200mg")
                            .font(.headline)
                            .bold()
                        Text("1x por dia às 9:30")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ritalina LA 10mg")
                            .font(.headline)
                            .bold()
                        Text("1x por dia às 9:30")
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                }
            }
        }
        .card()
    }
}

struct HeartBeatView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "waveform.path.ecg").font(.body)
                Text("Frequência Cardíaca (repouso)")
                    .font(.headline).bold()
                Spacer()
            }
            .foregroundColor(Color.red)
            VStack(alignment: .leading, spacing: 4) {
                Text("65 bpm")
                    .font(.title).bold()
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.green)
                        .font(.footnote)
                    Text("3% comparado a semana passada")
                        .font(.footnote)
                }
            }
        }
        .card()
    }
}

struct SleepDataCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "bed.double.fill").font(.body)
                Text("Análise de sono")
                    .font(.headline).bold()
                Spacer()
            }
            .foregroundColor(Color.orange)
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text("6h 45m")
                        .font(.title).bold()
                    Text("(Média por noite)")
                        .font(.caption)
                }
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(systemName: "arrow.up")
                        .foregroundColor(Color(.systemGreen))
                        .font(.footnote)
                    Text("1% comparado a semana passada")
                        .font(.footnote)
                }
            }
        }
        .card()
    }
}
