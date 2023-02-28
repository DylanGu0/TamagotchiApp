//
//  Tamagotchi.swift
//  TamagotchiApp
//
//  Created by Guo, Dylan (Coll) on 14/01/2023.
//

import Foundation

class Tamagotchi: ObservableObject {
    @Published private var age: Int
    @Published private var weight: Int
    @Published private var hunger: Int
    @Published private var happiness: Int
    @Published private var alive: Bool
    @Published private var hygiene: Int
    @Published private var isSick: Bool
    @Published var name: String
    
    init(_ name: String) {
        self.hunger = 5
        self.age = 0
        self.weight = 5
        self.happiness = 5
        self.alive = true
        self.name = name
        self.hygiene = 5
        self.isSick = false
    }

    func getHunger() -> Int {
        return self.hunger
    }
    
    func getIsSick() -> Bool {
        return self.isSick
    }
    
    func getAge() -> Int {
        return self.age
    }
    
    func getHygiene() -> Int {
        return self.hygiene
    }
    
    func getHappiness() -> Int {
        return self.happiness
    }
    
    func getWeight() -> Int {
        return self.weight
    }
    
    func getAlive() -> Bool {
        return self.alive
    }
    
    func modifyHunger(_ change: Int) {
        self.hunger += change
        if self.hunger < 0 {
            self.hunger = 0
        } else if self.hunger > 10 {
            self.hunger = 10
            self.alive = false
        }
    }
    
    func modifyHygiene(_ change: Int) {
        self.hygiene += change
        if self.hygiene < 3 {
            self.isSick = true
        }
        if self.hygiene < 0 {
            self.hygiene = 0
            self.alive = false
        } else if self.hygiene > 10 {
            self.hygiene = 10
        }
    }
    
    func modifyIsSick () {
        self.isSick = !self.isSick
    }
    
    func modifyWeight(_ change: Int) {
        self.weight += change
        if self.weight <= 0 || self.weight > 20 {
            self.alive = false
        }
    }
    
    func modifyHappiness(_ change: Int) {
        self.happiness += change
        if self.happiness <= 0 {
            self.alive = false
            self.happiness = 0
        } else if self.happiness > 10 {
            self.happiness = 10
        }
    }
    
    func modifyAge(_ change: Int) {
        self.age += change
        for i in 1...self.age {
            let randomInt = Int.random(in: 1...self.age)
            if randomInt == i {
                self.alive = false
            }
            
        }
    }
    func eatMeal() -> (Int, Int) {
        modifyHunger(-5)
        modifyWeight(3)
        modifyHygiene(-2)
        return (self.hunger, self.weight)
    }
    
    func eatSnack() -> (Int, Int) {
        modifyHunger(-2)
        modifyWeight(1)
        modifyHygiene(-1)
        return (self.hunger, self.weight)
    }
    
    func cleanUp() -> (Int, Int) {
        modifyHygiene(10)
        modifyHappiness(-3)
        return (self.hygiene, self.happiness)
    }
    
    func play() -> (Int, Int) {
        modifyWeight(-1)
        modifyHappiness(2)
        modifyHygiene(-2)
        modifyHunger(1)
        return (self.happiness, self.weight)
    }
    
    func giveMedicine() -> Bool {
        let temp = Int.random(in: 1...3)
        modifyHappiness(-2)
        if temp == 3 {
            modifyIsSick()
        }
        return self.isSick
    }
    
    func displayStats() -> String {
        let output = """
\(name)'s stats:
Age: \(getAge())
Happiness: \(getHappiness())/10
Weight: \(getWeight()) kg
Hunger: \(getHunger())/10
Hygiene: \(getHygiene())/10
Is sick: \(getIsSick())
"""
        return output
    }
}

