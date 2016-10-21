//
//  Task.swift
//

import Foundation

enum TaskStatus {
    case Success
    case Fail(Int32)
}

protocol Task {
    var name: String { get }
    
    func execute() -> TaskStatus
    
}

extension Task {
    
    func runCommand(args : String...) -> (output: [String], error: [String], exitCode: Int32) {
        
        var output : [String] = []
        var error : [String] = []
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe
        
        task.launch()
        
        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if let string = String(data: outdata, encoding: .ascii) {
            output = string.components(separatedBy: "\n")
        }
        
        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if let string = String(data: errdata, encoding: .ascii) {
            error = string.components(separatedBy: "\n")
        }
        
        task.waitUntilExit()
        let status = task.terminationStatus
        
        return (output, error, status)
    }
}
