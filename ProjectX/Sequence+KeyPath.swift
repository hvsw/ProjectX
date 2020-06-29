//
//  Sequence+KeyPath.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import Foundation

extension String {
    var initials: String {
        return self
            .split(separator: " ")
            .map { String($0.first!) }
            .joined()
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

import UIKit

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
