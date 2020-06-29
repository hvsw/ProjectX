//
//  PatientsListView.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

enum ComorbitySeverity {
    case veryLow, low, medium, high, veryHigh
    
    var color: Color {
        switch self {
        case .veryLow:
            return .blue
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .orange
        case .veryHigh:
            return .red
        }
    }
}

struct Comorbity: Identifiable {
    let id: UUID
    let name: String
    let severity: ComorbitySeverity
}

struct Patient: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let comorbities: [Comorbity]
    var imageName:String? {
        switch self.name {
        case "Camilla Romero":
            return "camilla"
        
        case "Guilherme Gades":
            return "gades"
            
        case "Henrique Valcanaia":
            return "henrique"
        
        case "William Hass":
            return "william"
        
        case "Steve Jobs":
            return "steve"
        
        case "Elon Musk":
            return "elon"
        
        default:
            return nil
        }
    }
}

let comorbities = [
    Comorbity(id: UUID(), name: "Obesidade", severity: .medium),
    Comorbity(id: UUID(), name: "Endocardite", severity: .high),
    Comorbity(id: UUID(), name: "Asma", severity: .low),
    Comorbity(id: UUID(), name: "Depressão", severity: .veryHigh),
    Comorbity(id: UUID(), name: "Alergia", severity: .veryLow),
]

extension String {
    var initials: String {
        return self
            .split(separator: " ")
            .map { String($0.first!) }
            .joined()
    }
}

import UIKit

extension Float {
    func modulate(from: [Float], to: [Float], limit: Bool) -> Float {
        let result = to[0] + (((self - from[0]) / (from[1] - from[0])) * (to[1] - to[0]));

        if (limit) {
            if (to[0] < to[1]) {
                if (result < to[0]) { return to[0] }
                if (result > to[1]) { return to[1] }
            }
            else {
                if (result > to[0]) { return to[0] }
                if (result < to[1]) { return to[1] }
            }
        }

        return result
    }
}

extension String {
    
    var asciiSum: Int {
        return self.reduce(0) { (result:Int, char:Character) -> Int in
            return result + Int(char.asciiValue ?? 0)
        }
    }
    
    var color: UIColor {
//        let min = 1
//        let max = 4
//        let intArray: [Int] = Array(min...max)
//        let sum = Float(self.initials.asciiSum)
//        let from: [Float] = Array(Float("AA".asciiSum)...Float("ZZ".asciiSum))
//        let to: [Float] = Array(0.0...1.0)
//        let hue = sum.modulate(from: from,
//                               to: to,
//                               limit: true)
//        return UIColor(hue: CGFloat(hue),
//                       saturation: 1,
//                       brightness: 1,
//                       alpha: 1)
        
        var hash = 0
        let colorConstant = 131
        let maxSafeValue = Int.max / colorConstant
        for char in self.unicodeScalars {
            if hash > maxSafeValue {
                hash = hash / colorConstant
            }
            hash = Int(char.value) + ((hash << 5) - hash)
        }
        let finalHash = abs(hash) % (256*256*256);
        //let color = UIColor(hue:CGFloat(finalHash)/255.0 , saturation: 0.40, brightness: 0.75, alpha: 1.0)
        let color = UIColor(red: CGFloat((finalHash & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((finalHash & 0xFF00) >> 8) / 255.0,
                            blue: CGFloat((finalHash & 0xFF)) / 255.0,
                            alpha: 1.0)
        return color
    }
}

extension Sequence {
    func sorted<String>(_ keyPath: KeyPath<Element, String>) -> [Element] {
        return self.sorted { (lhs: Self.Element, rhs: Self.Element) -> Bool in
            return false
//            let aString = lhs[keyPath: keyPath]
//            let bString = rhs[keyPath: keyPath]
//            return "1212e12".compare(bString) == ComparisonResult.orderedAscending
//            return lhs[keyPath: keyPath].compare(rhs[keyPath: keyPath])  == .orderedAscending
        }
    }
}

struct PatientDetailView: View {
    let patient: Patient
    
    var body: some View {
        Text(patient.name)
    }
}

struct PatientsListView: View {
    
    let patients: [Patient] = [
        "Camilla Romero",
        "Guilherme Gades",
        "Henrique Valcanaia",
        "William Hass",
        "Steve Jobs",
        "Elon Musk",
        "Bill Gates",
    ]
    .map { (patientName: String) -> Patient in
        return Patient(id: UUID(),
                       name: patientName,
                       age: Int.random(in: 1...90),
                       comorbities: comorbities)
    }
    .sorted(\.name)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.patients, id: \.id) { patient in
                    NavigationLink(destination: PatientDetailView(patient: patient)) {
                        PatientCell(patient: patient)
                            .padding(8)
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

struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorColor = .clear
                UITableView.appearance().separatorStyle = self.style
            }
            .onDisappear {
                UITableView.appearance().separatorStyle = .singleLine
            }
    }
}

extension View {
    
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PatientsListView()
            PatientsListView()
                .preferredColorScheme(.dark)
        }
    }
}

extension UIColor {

    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    func isLight(threshold: Float = 0.5) -> Bool {
        let originalCGColor = self.cgColor

        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return true
        }
        guard components.count >= 3 else {
            return true
        }

        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
}

struct PatientCell: View {
    
    let patient: Patient
    
    var body: some View {
        HStack(alignment: .top) {
            
            if let patientImage = patient.imageName {
                Image(patientImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(12)
                    .rotation3DEffect(.degrees(2 * (Bool.random() ? 1 : -1)),
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
            
            VStack(alignment: .leading) {
                Text(patient.name)
                    .font(.title)
                    .foregroundColor(Color(.label))
                
                Text(String(patient.age))
                    .font(.callout)
                    .foregroundColor(Color(.secondaryLabel))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(patient.comorbities.shuffled(), id: \.id) { comorbity in
                            ComorbityView(comorbity: comorbity)
                        }
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemFill))
        .cornerRadius(12)
    }
}

struct ComorbityView: View {
    let comorbity: Comorbity
    
    var body: some View {
        Text(comorbity.name)
            .font(.subheadline)
            .foregroundColor(Color(.label))
            .padding(4)
            .background(Color(.secondarySystemFill))
            .cornerRadius(4)
            .colorMultiply(comorbity.severity.color)
    }
}
