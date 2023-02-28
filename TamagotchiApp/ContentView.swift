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
    @State private var message: String = "Your actions will be displayed here..."
    
    var body: some View {
        Form {
            if tamagotchi.getAlive() {
                Text("\(timeElapsed)")
                    .frame(width: 300)
                    .onReceive(timer) {_ in
                        if self.timeElapsed == 30 {
                            self.timeElapsed += 1
                            tamagotchi.modifyHunger(2)
                        }
                        else if self.timeElapsed < 60 {
                            self.timeElapsed += 1
                        } else {
                            self.timeElapsed = 0
                            tamagotchi.modifyHappiness(-1)
                            tamagotchi.modifyHygiene(-2)
                            tamagotchi.modifyHunger(2)
                            tamagotchi.modifyAge(1)
                        }
                    } .foregroundColor(.red)
                Text("\(message)")
                    .frame(alignment: .center)
                
                Section {
                    HStack {
                        TextField("Please enter your tamagotchi's name: ", text: $tamagotchi.name)
                    }
                    Text(tamagotchi.displayStats())
                }

                Section {
                    Button("Feed Meal", action: {
                        let modification = tamagotchi.eatMeal()
                        message = "You have fed \(tamagotchi.name) a meal. Its hunger is now \(modification.0) and its weight is now \(modification.1)kg"
                    })
                    Button("Feed Snack", action: {
                        let modification = tamagotchi.eatSnack()
                        message = "You have fed \(tamagotchi.name) a snack. Its hunger is now \(modification.0) and its weight is now \(modification.1)kg"
                    })
                    Button("Play", action: {
                        let modification = tamagotchi.play()
                        message = "You have played with \(tamagotchi.name). Its happiness is now \(modification.0) and its weight is now \(modification.1)kg"
                    })
                    Button("Clean Up", action: {
                        let modification = tamagotchi.cleanUp()
                        message = "You have cleaned up \(tamagotchi.name). Its hygiene is now \(modification.0) and its happiness is \(modification.1)."
                    })
                    Button("Give Medicine", action: {
                        let modification = tamagotchi.giveMedicine()
                        var output = ""
                        if modification {
                            output = "still sick"
                        } else {
                            output = "no longer sick"
                        }
                        message = "You have given \(tamagotchi.name) some medicine. \(tamagotchi.name) is \(output)."
                    })
                }
            } else {
                Text("\(tamagotchi.name) has died. Try to keep better care of it next time!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
