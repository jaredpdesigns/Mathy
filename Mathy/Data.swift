//
//  Data.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/7/21.
//

import SwiftUI

//Models

struct Operator: Hashable {
    var name, image: String
}

struct Theme: Hashable {
    var name: String
    var colorBG: Color
    var colorText: Color?
}

let operators: [Operator] = [
    Operator(name: "Add", image: "plus"),
    Operator(name: "Subtract", image: "minus"),
    Operator(name: "Multiply", image: "multiply")
]

let themes: [Theme] = [
    Theme(name: "🫐 Blueberry", colorBG: .accentColor),
    Theme(name: "🍌 Banana", colorBG: Color(UIColor(hexString: "#FFC72C")!)),
    Theme(name: "🐼 Panda", colorBG: .gray),
    Theme(name: "🎃 Halloween", colorBG: .orange),
    Theme(name: "🦄 Unicorn", colorBG: Color(UIColor(hexString: "#ff808c")!))
]

// Shared Data

class GlobalSettings: ObservableObject {
    @Published var numberOne: Int = 0
    @Published var numberTwo: Int = 0
    
    @Published var answer: String = ""
    @Published var answerCorrect: Bool = false
    
    @Published var selectedOperator: String = operators[0].image
    @Published var selectedTheme: Theme = themes[0]
    
    @Published var solved: Bool = false
    @Published var solution: Double = 0
    
    @Published var isShowingSheet: Bool = false
    @Published var isAnimating: Bool = false
    
    func reset() {
        solved = false
        answer = ""
        answerCorrect = false
    }
    
    func getNumbers() {
        reset()
        numberOne = Int.random(in: 1..<12)
        numberTwo = Int.random(in: 1..<12)
        getSolution()
    }
    
    func getSolution() {
        switch selectedOperator {
        case "minus":
            solution = Double(numberOne - numberTwo)
        case "multiply":
            solution = Double(numberOne * numberTwo)
        case "divide":
            solution = Double(numberOne)/Double(numberTwo)
        default:
            solution = Double(numberOne + numberTwo)
        }
    }
    
    func checkAnswer() {
        solved = true
        if answer == String(solution.removeZerosFromEnd()) {
            answerCorrect = true
        } else {
            answerCorrect = false
        }
    }
    
    func setOperator(value: String) {
        selectedOperator = value
    }
    
    func setTheme(theme: Theme) {
        selectedTheme = theme
    }
    
    func animateStuff() {
        DispatchQueue.main.async { [self] in
            withAnimation(.spring()){
                self.isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.spring()){
                        self.isAnimating = false
                    }
                }
            }
        }
    }
}

// Color extension

extension UIColor {
    convenience init?(hexString: String?) {
        let input: String! = (hexString ?? "")
            .replacingOccurrences(of: "#", with: "")
            .uppercased()
        var alpha: CGFloat = 1.0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        switch (input.count) {
        case 3 /* #RGB */:
            red = Self.colorComponent(from: input, start: 0, length: 1)
            green = Self.colorComponent(from: input, start: 1, length: 1)
            blue = Self.colorComponent(from: input, start: 2, length: 1)
            break
        case 4 /* #ARGB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 1)
            red = Self.colorComponent(from: input, start: 1, length: 1)
            green = Self.colorComponent(from: input, start: 2, length: 1)
            blue = Self.colorComponent(from: input, start: 3, length: 1)
            break
        case 6 /* #RRGGBB */:
            red = Self.colorComponent(from: input, start: 0, length: 2)
            green = Self.colorComponent(from: input, start: 2, length: 2)
            blue = Self.colorComponent(from: input, start: 4, length: 2)
            break
        case 8 /* #AARRGGBB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 2)
            red = Self.colorComponent(from: input, start: 2, length: 2)
            green = Self.colorComponent(from: input, start: 4, length: 2)
            blue = Self.colorComponent(from: input, start: 6, length: 2)
            break
        default:
            NSException.raise(NSExceptionName("Invalid color value"), format: "Color value \"%@\" is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments:getVaList([hexString ?? ""]))
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func colorComponent(from string: String!, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString)
            .substring(with: NSRange(location: start, length: length))
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent: UInt64 = 0
        Scanner(string: fullHex)
            .scanHexInt64(&hexComponent)
        return CGFloat(Double(hexComponent) / 255.0)
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
