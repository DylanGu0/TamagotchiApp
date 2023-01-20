//
//  ContentView.swift
//  TamagotchiApp
//
//  Created by Guo, Dylan (Coll) on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tamagotchiName = "Tamagotchi" {
        didSet {
            tamagotchi = Tamagotchi(tamagotchiName)
        }
    }
    @State private var tamagotchi = Tamagotchi("Tamgotchi")
    var body: some View {
        Form {
            Section {
                TextField("Please enter your tamagotchi's name: ", text: $tamagotchiName)
                Text(tamagotchi.displayStats())
            }

            VStack (alignment: .leading, spacing: 5){
                Button("Feed Meal", action: {
                    let modification = tamagotchi.eatMeal()
                    print("You have fed \(tamagotchiName) a meal. Its hunger is now \(modification.0) and its weight is now \(modification.1)")
                    tamagotchi.modifyHygiene(-2)
                })
                Button("Feed Snack", action: {
                    let modification = tamagotchi.eatSnack()
                    print("You have fed \(tamagotchiName) a snack. Its hunger is now \(modification.0) and its weight is now \(modification.1)")
                    tamagotchi.modifyHygiene(-1)
                })
                Button("Play", action: {
                    let modification = tamagotchi.play()
                    print("You have played with \(tamagotchiName). Its happiness is now \(modification.0) and its weight is now \(modification.1)")
                    tamagotchi.modifyHygiene(-2)
                })
                Button("Clean Up", action: {
                    print("You have cleaned up \(tamagotchiName). Its hygiene is now \(tamagotchi.cleanUp()).")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
