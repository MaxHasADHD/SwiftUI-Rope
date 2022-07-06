//
//  Plug.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import Foundation

class Plug: ObservableObject {
    
    enum State {
        case immutable(CGPoint)
        case moving(_ by: CGSize, originalPosition: CGPoint)
        
        var value: CGPoint {
            switch self {
                case .immutable(let p):
                    return p
                case .moving(let translation, let originalPosition):
                    return originalPosition.applying(.init(translationX: translation.width, y: translation.height))
            }
        }
    }
    
    @Published var state: State
    var position: CGPoint {
        state.value
    }
    
    init(position: CGPoint) {
        state = .immutable(position)
    }
    
    func move(by translation: CGSize) {
        switch state {
            case .immutable:
                state = .moving(translation, originalPosition: position)
            case .moving(_, let originalPosition):
                state = .moving(translation, originalPosition: originalPosition)
        }
    }
    
    func endMoving() {
        state = .immutable(state.value)
    }
}
