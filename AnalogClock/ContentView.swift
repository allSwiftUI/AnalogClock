// -----------------------------------------------------------------------------
// File: ContentView.swift
// Package: AnalogClock
//
// Created by: ALLSWIFTUI on 25-09-20
// Copyright © 2020 allSwiftUI · https://allswiftui.com · @allswiftui
// -----------------------------------------------------------------------------

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    let radius: Double = 128.0
    let step: Double = (2 * Double.pi) / 12
    
    @State private var currentDate: Time = Time(date: Date())
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                // Display a circle shape with shadow to represent the background of the clock
                Circle()
                    .stroke(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), lineWidth: 1.0)
                    .frame(width: 300, height: 300, alignment: .center)
                    .shadow(color: .gray, radius: 4)
                Circle()
                    .fill(Color.white)
                    .frame(width: 296, height: 296, alignment: .center)
                
                // Display 12 shapes to represent the hours on the clock
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
                
                // Display Hour as text in format "00:00:00"
                Text("\(currentDate.hours < 10 ? "0":"")\(currentDate.hours):\(currentDate.minutes < 10 ? "0":"")\(currentDate.minutes):\(currentDate.seconds < 10 ? "0":"")\(currentDate.seconds)")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                    .offset(x: 0, y: 70)
            
                // Display the minutes
                ShowMinutes(minutes: currentDate.minutes)
                
                // Display the hours
                ShowHours(hours: currentDate.hours, minutes: currentDate.minutes)
                
                // Display the seconds
                ShowSeconds(seconds: currentDate.seconds)
                    
            }
            .onReceive(timer, perform: { dateTime in
                currentDate.setTime(date: dateTime)
            })
        }
    }
}

// MARK: - Sphere
/// Circle shape to represent the hours on the clock
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

// MARK: - ShowSeconds
/// View to represent and show the seconds on the clock
struct ShowSeconds: View {
    var seconds: Int
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                .frame(width: 8, height: 8, alignment: .center)
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)))
                .position(x: 1, y: 15)
                .frame(width: 2, height: 130, alignment: .center)
        }
        .rotationEffect(Angle(degrees: Double(seconds) * 6))
        //.animation(.linear(duration: 1.0))
    }
}

// MARK: - ShowMinutes
/// View to represent and show the minutes on the clock
struct ShowMinutes: View {
    var minutes: Int
    let color: Color = Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 2.0)
                .frame(width: 16, height: 16, alignment: .center)
            Rectangle()
                .fill(color)
                .cornerRadius(4.0)
                .position(x: 2, y: -8)
                .frame(width: 4, height: 110, alignment: .center)
            Rectangle()
                .fill(color)
                .cornerRadius(10.0)
                .position(x: 5.0, y: -20)
                .frame(width: 10, height: 98, alignment: .center)
        }
        .rotationEffect(Angle(degrees: Double(minutes) * 6))
    }
}

// MARK: - ShowHours
/// View to represent and show the hours on the clock
struct ShowHours: View {
    var hours: Int
    var minutes: Int
    let color: Color = Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 2.0)
                .frame(width: 16, height: 16, alignment: .center)
            Rectangle()
                .fill(color)
                .cornerRadius(4.0)
                .position(x: 2, y: -8)
                .frame(width: 4, height: 90, alignment: .center)
            Rectangle()
                .fill(color)
                .cornerRadius(10.0)
                .position(x: 5.0, y: -20)
                .frame(width: 10, height: 78, alignment: .center)
        }
        .rotationEffect(Angle(degrees: Double(hours * 30) +  Double(minutes) * 0.49))
    }
}

// MARK: - Time in hours, minutes and seconds
/// We manipulate the current date for get the hours, minutes and seconds
struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(date: Date) {
        hours = Calendar.current.component(.hour, from: date)
        minutes = Calendar.current.component(.minute, from: date)
        seconds = Calendar.current.component(.second, from: date)
    }
    
    mutating func setTime(date: Date) {
        hours = Calendar.current.component(.hour, from: date)
        minutes = Calendar.current.component(.minute, from: date)
        seconds = Calendar.current.component(.second, from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
