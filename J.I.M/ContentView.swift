//
//  ContentView.swift
//  J.I.M
//
//  Brian Nguyen
//  Jaden Faustino
//  Julian Manaois
//  SFSU ENGR 696 Fall 2022

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
                .padding(0.0)
                .imageScale(.large)
                .foregroundColor(.green)
            Text("Welcome to PROJECT JIM")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(red: 0.343, green: 0.30, blue: 4.0, opacity: 2.0))
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
