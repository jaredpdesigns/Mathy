//
//  Settings.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/7/21.
//

import SwiftUI

struct Settings: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        VStack(spacing: 0) {
            if verticalSizeClass == .compact {
                HStack {
                    Button(action: { settings.isShowingSheet = false }) {
                        VStack {
                            Image(systemName: "xmark")
                                .font(Font.caption.weight(.bold))
                        }
                        .frame(width: 40, height: 40)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
                        .foregroundColor(.white)
                    }.buttonStyle(.plain)
                    Spacer()
                }.padding(.horizontal)
            } else {
                VStack {
                    Color(UIColor.label)
                        .frame(width: 64, height: 4)
                        .clipShape(Capsule())
                        .opacity(0.125)
                }.padding()
            }
            List {
                Section(header: Text("Operators")) {
                    ForEach(operators, id: \.self) { item in
                        HStack {
                            Label {
                                Text(item.name)
                            } icon: {
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(Color(UIColor.systemBackground))
                                    Image(systemName: "\(item.image).circle.fill")
                                        .foregroundColor(Color(UIColor.label))
                                }.imageScale(.large)
                            }
                            Spacer()
                            if item.image == settings.selectedOperator {
                                Image(systemName: "checkmark")
                                    .imageScale(.small)
                                    .foregroundColor(settings.selectedTheme.colorBG)
                            }
                            
                        }
                        .background(Color(UIColor.systemBackground))
                        .onTapGesture {
                            settings.setOperator(value: item.image)
                        }
                    }
                }
                Section(header: Text("Themes")) {
                    ForEach(themes, id: \.self) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            if item == settings.selectedTheme {
                                Image(systemName: "checkmark")
                                    .imageScale(.small)
                                    .foregroundColor(settings.selectedTheme.colorBG)
                            }
                            
                        }
                        .background(Color(UIColor.systemBackground))
                        .onTapGesture {
                            settings.setTheme(theme: item)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(GlobalSettings())
    }
}
