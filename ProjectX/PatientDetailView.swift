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
        VStack {
            PatientCard(patient: patient)
                .padding(12)
            
            List {
                Section(header: Text("Dados")) {
                    HealthDataCell(healthData: .heartRate(94))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    HealthDataCell(healthData: .sleep(6, 13))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }.navigationTitle(patient.name)
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientDetailView(patient: Storage.patients.first!)
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
