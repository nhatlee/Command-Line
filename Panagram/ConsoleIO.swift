//
//  ConsoleIO.swift
//  Panagram
//
//  Created by nhatlee on 12/6/17.
//  Copyright © 2017 nhatlee. All rights reserved.
//
import Foundation

enum OutputType {
    case error
    case standard
}

class ConsoleIO {
    func getInput() -> String {
        //grab a handle to stdin
        let keyboard = FileHandle.standardInput
        //read any data on the stream
        let inputData = keyboard.availableData
        //Convert the data to a string
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        //emove any newline characters and return the string
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            //The sequence \u{001B}[;m is used in the standard case to reset the terminal's text color back to the default.
            print("\u{001B}[;m\(message)")
        case .error:
            //The sequence \u{001B}[0;31m are control characters that cause Terminal to change the color of the following text strings to red.
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func printUsage() {
        
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) -a string1 string2")
        writeMessage("or")
        writeMessage("\(executableName) -p string")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
}
