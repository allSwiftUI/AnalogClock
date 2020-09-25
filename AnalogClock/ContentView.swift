// -----------------------------------------------------------------------------
// File: ContentView.swift
// Package: AnalogClock
//
// Created by: ALLSWIFTUI on 25-09-20
// Copyright © 2020 allSwiftUI · https://allswiftui.com · @allswiftui
// -----------------------------------------------------------------------------

import SwiftUI

struct ContentView: View {
    
    let radius: Double = 128.0
    let maximum: Double = 2 * Double.pi
    let step: Double = (2 * Double.pi) / 12
    @State var angle: Double = 0
    
    var body: some View {
        VStack {
            ZStack {
                // Sphere
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), lineWidth: 1.0)
                    .frame(width: 300, height: 300, alignment: .center)
                    .shadow(color: .gray, radius: 4)
                Circle()
                    .fill(Color.white)
                    .frame(width: 296, height: 296, alignment: .center)
                
                //
                Group {
                    Sphere(radius: radius, angle: 0)                //  3
                    Sphere(radius: radius, angle: step * -1)        //  2
                    Sphere(radius: radius, angle: step * -2)        //  1
                    Sphere(radius: radius, angle: step * -3)        // 12
                    Sphere(radius: radius, angle: step * -4)        // 11
                    Sphere(radius: radius, angle: step * -5)        // 10
                    Sphere(radius: radius, angle: step * -6)        //  9
                }
                Group {
                    Sphere(radius: radius, angle: step * -7)        //  8
                    Sphere(radius: radius, angle: step * -8)        //  7
                    Sphere(radius: radius, angle: step * -9)        //  6
                    Sphere(radius: radius, angle: step * -10)       //  5
                    Sphere(radius: radius, angle: step * -11)       //  4
                }

            }
        }
    }
}

struct Sphere: View {
    var radius: Double
    var angle: Double
    
    var body: some View {
        Circle()
            .fill(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            .position(x: CGFloat(5 + radius * cos(angle)), y: CGFloat(5 + radius * sin(angle)))
            .frame(width: 10, height: 10, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
