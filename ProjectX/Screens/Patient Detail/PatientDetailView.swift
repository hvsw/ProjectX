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
                HStack {
                    Text("Resumo da semana").font(.title).fontWeight(.medium)
                    Spacer()
                }
                .padding(.top, 4)
                SymptomsView()
                MedicineCard()
                HeartBeatView()
                // TODO: Sleep
                //HealthDataCell(healthData: .heartRate(94))
                HealthDataCell(healthData: .sleep(6, 13))
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

struct HealthDataCell: View {
    
    let healthData: HealthData
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: self.healthData.imageName)
                    Text(self.healthData.humanReadableName)
                        .font(.headline)
                }
                .foregroundColor(self.healthData.color)
                Spacer()
                Text("18 Jun")
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryLabel))
                Image(systemName: "chevron.right.circle")
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                switch self.healthData {
                case .heartRate(let heartRate):
                    Text(String(heartRate))
                        .font(.title)
                        .bold()
                    Text("batimentos por minuto")
                
                case .sleep(let hours, let minutes):
                    HStack(spacing: 2) {
                        Text(String(hours))
                            .font(.title2)
                            .bold()
                        Text("hr")
                    }
                    
                    HStack(spacing: 2) {
                        Text(String(minutes))
                            .font(.title2)
                            .bold()
                        Text("min")
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(12)
        .background(Color(.systemFill))
        .cornerRadius(12)
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            PatientDetailView(patient: Storage.patients.first!)
            NavigationView {
                PatientDetailView(patient: Storage.patients.first!).colorScheme(.dark)
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
                    Image(systemName: "arrow.up")
                        .font(.footnote)
                    Text("3% comparado a semana passada")
                        .font(.footnote)
                }
            }
        }
        .card()
    }
}
