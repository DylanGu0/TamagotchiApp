//
//  ContentView.swift
//  TamagotchiApp
//
//  Created by Guo, Dylan (Coll) on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tamagotchi = Tamagotchi("Tamagotchi")
    let timer = Timer.publish(every: 1, on:.main, in: .common).autoconnect()
    @State private var timeElapsed = 0
    
    var body: some View {
        Form {
            Text("\(timeElapsed)")
                .padding()
                .onReceive(timer) {_ in
                    if self.timeElapsed < 365 {
                        self.timeElapsed += 1
                    } else {
                        self.timeElapsed = 0
                        tamagotchi.modifyAge(1)
                    }
                } .foregroundColor(.red)
            Section {
                HStack {
                    TextField("Please enter your tamagotchi's name: ", text: $tamagotchi.name)
                }
                Text(tamagotchi.displayStats())
            }

            Section {
                Button("Feed Meal", action: {
                    let modification = tamagotchi.eatMeal()
                    print("You have fed \(tamagotchi.name) a meal. Its hunger is now \(modification.0) and its weight is now \(modification.1)")
                })
                Button("Feed Snack", action: {
                    let modification = tamagotchi.eatSnack()
                    print("You have fed \(tamagotchi.name) a snack. Its hunger is now \(modification.0) and its weight is now \(modification.1)")
                })
                Button("Play", action: {
                    let modification = tamagotchi.play()
                    print("You have played with \(tamagotchi.name). Its happiness is now \(modification.0) and its weight is now \(modification.1)")
                })
                Button("Clean Up", action: {
                    let modification = tamagotchi.cleanUp()
                    print("You have cleaned up \(tamagotchi.name). Its hygiene is now \(modification.0) and its happiness is \(modification.1).")
                })
                Button("Give Medicine", action: {
                    let modification = tamagotchi.giveMedicine()
                    var output = ""
                    if modification {
                        output = "still sick"
                    } else {
                        output = "no longer sick"
                    }
                    print("You have given \(tamagotchi.name) some medicine. \(tamagotchi.name) is now \(output).")
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
