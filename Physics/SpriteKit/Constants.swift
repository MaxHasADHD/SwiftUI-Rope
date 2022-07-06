//
//  Constants.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import CoreGraphics

enum Layer {
    static let background: CGFloat = 0
    static let crocodile: CGFloat = 1
    static let vine: CGFloat = 1
    static let prize: CGFloat = 2
    static let foreground: CGFloat = 3
}

enum PhysicsCategory {
    static let crocodile: UInt32 = 1
    static let vineHolder: UInt32 = 2
    static let vine: UInt32 = 4
    static let prize: UInt32 = 8
}

enum GameConfiguration {
    static let vineDataFile = "VineData.plist"
    static let canCutMultipleVinesAtOnce = false
}

