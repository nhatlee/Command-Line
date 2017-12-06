//
//  main.swift
//  Panagram
//
//  Created by nhatlee on 12/6/17.
//  Copyright © 2017 nhatlee. All rights reserved.
//

import Foundation

let panagram = Panagram()
if CommandLine.argc < 2 {
    panagram.interactiveMode()
} else {
    panagram.staticMode()
}

