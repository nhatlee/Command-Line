//
//  StringExtension.swift
//  Panagram
//
//  Created by nhatlee on 12/6/17.
//  Copyright © 2017 nhatlee. All rights reserved.
//

import Foundation
extension String {
    func isAnagramOf(_ s: String) -> Bool {
        //remove capitalization and whitespace from both Strings
        let lowerSelf = self.lowercased().replacingOccurrences(of: " ", with: "")
        let lowerOther = s.lowercased().replacingOccurrences(of: " ", with: "")
        //sort and compare the characters
        return lowerSelf.sorted() == lowerOther.sorted()
    }
    
    func isPalindrome() -> Bool {
        //Remove capitalization and whitespace
        let f = self.lowercased().replacingOccurrences(of: " ", with: "")
        //Create a second string with the reversed characters
        let s = String(f.reversed())
        //If they are equal, it is a palindrome
        return  f == s
    }
}
