import UIKit

class LightOutSide {
    var intensivity: Double = 1

    func switchOn() {
        print("Light's switchew on")
    }
    func switchOff() {
        print("Light's switched off")
    }
}

class HeatingCooling {
    var temperature: Double = 21.5
    var mode: String {
        return temperature >= 25 ? "colding" :  "heating"
    }
    
    func start() {
        print("Start \(mode)")
    }
    func stop() {
        print("Stop \(mode)")
    }
}

protocol Command {
    func execute()
}

class LightSwitchOnCommand: Command {
    var light: LightOutSide
    
    init(light: LightOutSide) {
        self.light = light
    }
    
    func execute() {
        light.switchOn()
    }
}

class LightSwitchedOffCommand: Command {
    var light: LightOutSide
    
    init(light: LightOutSide) {
        self.light = light
    }
    
    func execute() {
        light.switchOff()
    }
    
}

class StartHeatingCommand: Command {
    var heater: HeatingCooling
    
    init(heater: HeatingCooling) {
        self.heater = heater
    }
    
    func execute() {
        if heater.temperature < 25 {
            heater.temperature = 25
        }
        heater.start()
    }
}

class StopHeatingCommand: Command {
    var heater: HeatingCooling
    
    init(heater: HeatingCooling) {
        self.heater = heater
    }
    
    func execute() {
        heater.stop()
    }
}

class Program {
    var commands: [Command] = []
    
    func start() {
        commands.forEach { $0.execute() }
    }
}

let light = LightOutSide()
let heater = HeatingCooling()

let lightOnCommand = LightSwitchOnCommand(light: light)
let heatCommand = StartHeatingCommand(heater: heater)

let eveningProgram = Program()
eveningProgram.commands.append(lightOnCommand)
eveningProgram.commands.append(heatCommand)
eveningProgram.start()


let lightOffCommand = LightSwitchedOffCommand(light: light)
let stopHeatCommand = StopHeatingCommand(heater: heater)
let nobodyHereProgram = Program()
nobodyHereProgram.commands.append(lightOffCommand)
nobodyHereProgram.commands.append(stopHeatCommand)
nobodyHereProgram.start()


// Литература
// https://refactoring.guru/ru/design-patterns/command
// https://www.youtube.com/watch?v=c2AVz22FzWY
// https://www.youtube.com/watch?v=YRbpVPsm2JA&list=PLcmaZSNs2TKgGHZ38xh-PaHkCUrehijg1&index=18
