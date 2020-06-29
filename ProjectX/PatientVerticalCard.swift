//
//  PatientVerticalCard.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct PatientVerticalCard: View {
    
    let patient: Patient
    
    var body: some View {
        VStack {
            VStack(spacing: 2) {
                HStack {
                    Spacer()
                    LastVisitView()
                }
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
                        .padding(4)
                } else {
                    Text(patient.name.initials)
                        .font(.title)
                        .foregroundColor(patient.name.initials.color.isLight() ? Color.black : Color.white)
                        .frame(width: 50, height: 50)
                        .background(Color(.systemFill))
                        .cornerRadius(12)
                }
                
                HStack(alignment: VerticalAlignment.firstTextBaseline) {
                    Text(patient.name)
                        .font(.title)
                        .foregroundColor(Color(.label))
                    
                    Text(String("(\(patient.age))"))
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(patient.comorbities.shuffled(), id: \.id) { comorbity in
                        ComorbityView(comorbity: comorbity)
                    }
                }
            }
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            
        }
        .padding(20)
        .background(Color(.systemFill))
        .cornerRadius(12)
    }
}

struct PatientVerticalCard_Previews: PreviewProvider {
    static var previews: some View {
        PatientVerticalCard(patient: Storage.patients.first!)
    }
}

