//
//  ContentView.swift
//  TamagotchiApp
//
//  Created by Guo, Dylan (Coll) on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tamagotchiName = ""
    var body: some View {
        Form {
            Section {
                TextField("Please enter your tamagotchi's name.", text: $tamagotchiName)
                let tamagotchi = Tamagotchi(tamagotchiName)
                Text(tamagotchi.displayStats())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
