//
//  ContentView.swift
//  firstapp
//
//  Created by Dominic Sprenger on 09.09.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Button(action: {
                showingAlert = true
            })
            { Text("Click Me!")
                    .padding()
                 }
                .buttonStyle(MyNewPrimitiveButtonStyle(color: .blue))
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Hallo"), message: Text("Test"))
                } //alert doenst work :(
        }
    }
}

struct ContentView2: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
 
struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
   
    struct MyButton: View {
        @State private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {

            return configuration.label
                .foregroundColor(.black)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.pressed = pressing
                }
                if pressing {
                    print("The start of my longpress")
                    
                } else {
                    print("The end of my longpress")
                }
            }, perform: { })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
