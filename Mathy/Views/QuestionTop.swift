//
//  QuestionTop.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/9/21.
//

import SwiftUI

struct QuestionTop: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var keyboard = KeyboardResponder()
    @EnvironmentObject var settings: GlobalSettings
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        VStack {
            HStack {
                Text("\(settings.numberOne)")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.white)
                    Image(systemName: "\(settings.selectedOperator).circle.fill")
                        .foregroundColor(.black)
                }
                .font(Font.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 108:64))
                .imageScale(.small)
                Text("\(settings.numberTwo)")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 128:108))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(settings.selectedTheme.colorText)
            .offset(y: orientation.isLandscape ? -keyboard.currentHeight/2:0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuestionTop_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTop().environmentObject(GlobalSettings())
    }
}
