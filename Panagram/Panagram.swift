//
//  Panagram.swift
//  Panagram
//
//  Created by nhatlee on 12/6/17.
//  Copyright © 2017 nhatlee. All rights reserved.
//

import Foundation

enum OptionType: String {
    case palindrome = "p"
    case anagram = "a"
    case help = "h"
    case quit = "q"
    case unknown
    
    init(value: String) {
        switch value {
        case "a": self = .anagram
        case "p": self = .palindrome
        case "h": self = .help
        case "q": self = .quit
        default: self = .unknown
        }
    }
}

class Panagram {
    
    let consoleIO = ConsoleIO()
    
    func interactiveMode() {
        //print a welcome message
        consoleIO.writeMessage("Welcome to Panagram. This program checks if an input string is an anagram or palindrome.")
        //shouldQuit breaks the infinite loop that is started in the next line.
        var shouldQuit = false
        while !shouldQuit {
            //Prompt the user for input and convert it to one of the two options, if possible
            consoleIO.writeMessage("Type 'a' to check for anagrams or 'p' for palindromes type 'q' to quit.")
            let (option, value) = getOption(consoleIO.getInput())
            
            switch option {
            case .anagram:
                //If the option was for anagrams, prompt the user for the two strings to compare.
                consoleIO.writeMessage("Type the first string:")
                let first = consoleIO.getInput()
                consoleIO.writeMessage("Type the second string:")
                let second = consoleIO.getInput()
                
                //Write the result out. The same logic flow applies to the palindrome option.
                if first.isAnagramOf(second) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)")
                } else {
                    consoleIO.writeMessage("\(second) is not an anagram of \(first)")
                }
            case .palindrome:
                consoleIO.writeMessage("Type a word or sentence:")
                let s = consoleIO.getInput()
                let isPalindrome = s.isPalindrome()
                consoleIO.writeMessage("\(s) is \(isPalindrome ? "" : "not ")a palindrome")
            case .quit:
                shouldQuit = true
            default:
                //If the user enters an unknown option, print an error and start the loop again
                consoleIO.writeMessage("Unknown option \(value)", to: .error)
            }
        }
    }
    
    func staticMode() {
        //You first get the number of arguments passed to the program
        let argCount = CommandLine.argc
        //take the first “real” argument (the option argument)
        let argument = CommandLine.arguments[1]
        //he index(_:offsetBy:) method is simply skipping the first character in the argument’s string, which in this case is the hyphen (`-`) character before the option
        let (option, value) = getOption(argument.substring(from: argument.index(argument.startIndex, offsetBy: 1)))
        
        //switch based on what argument you were passed, to determine what operation will be performed.
        switch option {
        case .anagram:
            //In the case of an anagram, there must be four command-line arguments passed in
            if argCount != 4 {
                if argCount > 4 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
                consoleIO.printUsage()
            } else {
                //store the two strings in local variables, check them to see if they are anagrams of each other, and print the result.
                let first = CommandLine.arguments[2]
                let second = CommandLine.arguments[3]
                
                if first.isAnagramOf(second) {
                    consoleIO.writeMessage("\(second) is an anagram of \(first)")
                } else {
                    consoleIO.writeMessage("\(second) is not an anagram of \(first)")
                }
            }
        case .palindrome:
            //In the case of a palindrome, you must have three arguments. The first is the executable path, the second is the -p option and finally the string to check. If you don't have three arguments, then print an error message.
            if argCount != 3 {
                if argCount > 3 {
                    consoleIO.writeMessage("Too many arguments for option \(option.rawValue)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option.rawValue)", to: .error)
                }
                consoleIO.printUsage()
            } else {
                //Check the string to see if it is a palindrome and print the result.
                let s = CommandLine.arguments[2]
                let isPalindrome = s.isPalindrome()
                consoleIO.writeMessage("\(s) is \(isPalindrome ? "" : "not ")a palindrome")
            }
        //If the -h option was passed in, then print the usage information.
        case .help:
            consoleIO.printUsage()
        case .unknown, .quit:
            //If an unknown option is passed, print the usage information.
            consoleIO.writeMessage("Unknown option \(value)")
            consoleIO.printUsage()
        }
    }
    
    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
}
