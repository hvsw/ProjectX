//
//  PatientCard.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct PatientCard: View {
    
    let patient: Patient
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 16) {
                if let patientImage = patient.imageName {
                    Image(patientImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(12)
                        .rotation3DEffect(.degrees(1 * (Bool.random() ? 1 : -1)),
                                          axis: (x: (Bool.random() ? 1 : -1),
                                                 y: (Bool.random() ? 1 : -1),
                                                 z: (Bool.random() ? 1 : -1)))
                        .shadow(color: Color(.systemGray), radius: 4)
                } else {
                    Text(patient.name.initials)
                        .font(.title)
                        .foregroundColor(patient.name.initials.color.isLight() ? Color.black : Color.white)
                        .frame(width: 50, height: 50)
                        .background(Color(.systemFill))
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Data de nascimento")
                            .font(.caption2)
                            .foregroundColor(Color(.secondaryLabel))
                        HStack(spacing: 2) {
                            Text("10/10/1991").bold().font(.body)
                            Text("(\(String(patient.age)) anos)")
                                .font(.footnote)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Última consulta")
                            .font(.caption2)
                            .foregroundColor(Color(.secondaryLabel))
                        HStack(spacing: 2) {
                            Text("10/10/1991").bold().font(.body)
                            Text("(15 dias atrás)")
                                .font(.footnote)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Diagnóstico")
                    .font(.caption2)
                    .foregroundColor(Color(.secondaryLabel))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(patient.comorbities.shuffled(), id: \.id) { comorbity in
                            ComorbityView(comorbity: comorbity)
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color(.systemFill))
        .cornerRadius(12)
    }
}

struct PatientCard_Previews: PreviewProvider {
    static var previews: some View {
        PatientCard(patient: Storage.patients.first!)
    }
}
