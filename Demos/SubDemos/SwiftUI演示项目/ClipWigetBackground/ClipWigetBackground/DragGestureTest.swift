//
//  DragGestureTest.swift
//  ClipWigetBackground
//
//  Created by weijie.zhou on 2023/5/13.
//

import SwiftUI

struct DragGestureTest: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                let loc = startLocation ?? location // 2
                startLocation = loc
            }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.pink)
                .frame(width: 100, height: 100)
                .position(location)
                .gesture(
                    simpleDrag
                )
        }
    }
}

struct DragGestureTest_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureTest()
    }
}
