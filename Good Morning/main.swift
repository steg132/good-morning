#!/usr/bin/env swift
//
//  main.swift
//

import Foundation

let VERSION = "1.0.0"

let tasks: [Task] = [UpdateBrewTask(), UpgradeBrewTask()]

func main() {

    for argument in CommandLine.arguments {
        switch argument.lowercased() {
        case "version":
            print(VERSION)
            return
        default: continue
        }
    }

    print("Good Morning Mr. Schumacher!\n")
    
    for task in tasks {
        print("Starting Task: \(task.name)")
        switch task.execute() {
        case .Fail(let code):
            print("Failed with code: \(code)")
            return
        case .Success:
            print("Task Successful!\n")
        }
    }
    
    print("\nHave a good day, Mr. Schumacher!")
}


main()
