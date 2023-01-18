//
//  Tamagotchi.swift
//  TamagotchiApp
//
//  Created by Guo, Dylan (Coll) on 14/01/2023.
//

import Foundation

class Tamagotchi {
    private var age: Int
    private var weight: Int
    private var hunger: Int
    private var happiness: Int
    private var alive: Bool
    private var hygiene: Int
    private var isSick: Bool
    let name: String
    
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
        self.hunger += change
        if self.hygiene < 3 {
            self.isSick = true
        } else if self.hygiene < 0 {
            self.hygiene = 0
            self.alive = false
        } else if self.hygiene > 10 {
            self.hygiene = 10
        }
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
        } else if self.happiness > 10 {
            self.happiness = 10
        }
    }
    
    func eatMeal() -> (Int, Int) {
        modifyHunger(-1)
        modifyWeight(1)
        return (self.hunger, self.weight)
    }
    
    func eatSnack() -> (Int, Int) {
        modifyHunger(-5)
        modifyWeight(2)
        return (self.hunger, self.weight)
    }
    
    func cleanUp() -> Int {
        modifyHygiene(10)
        return self.hygiene
    }
    
    func play() -> (Int, Int) {
        modifyWeight(-1)
        modifyHappiness(2)
        return (self.happiness, self.weight)
    }
    
    func displayStats() -> String {
        let output = """
\(name)'s stats:
Age: \(getAge()) years
Happiness: \(getHappiness())/10
Weight: \(getWeight()) kg
Hunger: \(getHunger())/10
"""
        return output
    }
}

