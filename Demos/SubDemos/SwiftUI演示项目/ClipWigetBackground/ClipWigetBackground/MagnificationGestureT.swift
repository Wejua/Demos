//
//  MagnificationGesture.swift
//  ClipWigetBackground
//
//  Created by weijie.zhou on 2023/5/13.
//

import SwiftUI

struct MagnifyView: View {
    @State private var currentScale: CGFloat = 1.0
    @GestureState private var zoomState: CGFloat = 1.0
    var scale: CGFloat {
        currentScale * zoomState
    }

    var magnification: some Gesture {
        return MagnificationGesture()
            .updating($zoomState) { value, scale, transaction in
//                withAnimation {
                scale = value
//                }
            }
            .onChanged { value in
//                withAnimation {
                    currentScale *= value
//                }
            }
            .onEnded { value in
                // do nothing
            }
    }
    
    var body: some View {
        GeometryReader {geo in
            Image("logo3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width*scale, height: geo.size.height*scale, alignment: .center)
                .scaleEffect(scale, anchor: .center)
                .gesture(magnification)
        }
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnifyView()
    }
}
