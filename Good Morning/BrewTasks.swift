//
//  UpdateBrewTask.swift
//

import Foundation

internal class UpdateBrewTask: Task {
    let name = "Update Brew"
    
    func execute() -> TaskStatus {
        let (_, _, status) = runCommand(args: "brew", "update")
        if status == 0 {
            return .Success
        }
        return .Fail(status)
    }
}

internal class UpgradeBrewTask: Task {
    let name = "Upgrade Brew"
    let forceUpgrade = ["git", "node"]
    
    func execute() -> TaskStatus {
        let (outdated, _, status) = runCommand(args: "brew", "outdated")
        
        guard status == 0 else {
            return .Fail(status)
        }
        
        var toUpgrade = [String]()
        if outdated.count > 0 {
            print("Outdated Casks:")
            for sz in outdated {
                print("\t\(sz)")
                if forceUpgrade.contains(sz) {
                    toUpgrade.append(sz)
                }
            }
        }
        
        if toUpgrade.count > 0 {
            print("Upgrading:")
            for sz in toUpgrade {
                print("\t\(sz)")
            }
        }
        
        for cask in toUpgrade {
            print("Upgrading \(cask)...")
            let _ = runCommand(args: "brew", "upgrade", cask)
        }
        
        return .Success
        
    }
}


