//
//  ContentView.swift
//  TheseKidsMath
//
//  Created by Jared Pendergraft on 7/6/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var settings = GlobalSettings()
    
    var buttonReset: some View {
        Button(action: { settings.getNumbers() }) {
            VStack {
                Image(systemName: "arrow.clockwise")
                    .font(Font.caption.weight(.bold))
            }
            .frame(width: 40, height: 40)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
        }.buttonStyle(.plain)
    }
    
    var buttonSettings: some View {
        Button(action: { settings.isShowingSheet.toggle() }) {
            VStack {
                Image(systemName: "slider.horizontal.3")
                    .font(Font.caption.weight(.bold))
            }
            .frame(width: 40, height: 40)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1).opacity(0.25))
            
        }.buttonStyle(.plain)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if settings.solved {
                    Answer()
                } else {
                    Question()
                }
            }
            .accentColor(settings.selectedTheme.colorBG)
            .navigationBarTitle("What’s the Answer?", displayMode: .inline)
            .navigationBarItems(leading: buttonSettings, trailing: buttonReset)
            .sheet(isPresented: $settings.isShowingSheet, onDismiss: { settings.isShowingSheet = false }) {
                Settings()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
