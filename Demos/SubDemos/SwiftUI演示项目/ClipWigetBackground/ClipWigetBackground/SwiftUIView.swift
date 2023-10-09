//
//  SwiftUIView.swift
//  ClipWigetBackground
//
//  Created by weijie.zhou on 2023/5/13.
//

import SwiftUI

//struct HitScrollView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIScrollView {
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.delegate = context.coordinator
//        return scrollView
//    }
//    
//    func updateUIView(_ uiView: UIScrollView, context: Context) {
//        
//    }
//}

struct SwiftUIView: View {
    
    var body: some View {
        ZStack {
            let image = Image("svip_enable")
                .resizable()
                .scaledToFit()
                .background {
                    GeometryReader { geo in
                        Color.clear.preference(key: ImageFrameKey.self, value: geo.frame(in: .named("ZStack")))
                            .onPreferenceChange(ImageFrameKey.self) { rect in
                                imageFrame = rect
                            }
                    }
                }
                .scaleEffect(scale)
                .position(location)
            image
                .overlay {
                    Color.blue.opacity(0.5)
                }
                .mask(image)
//                .position(location)
//                .scaleEffect(scale)
                
            image
                .mask {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: widgetSize.width, height: widgetSize.height)
                        .background {
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: WidgetFrameKey.self, value:geo.frame(in: .named("ZStack")))
                                    .onPreferenceChange(WidgetFrameKey.self) { rect in
                                        widgetFrame = rect
                                    }
                            }
                        }
                }
        }
        .coordinateSpace(name: "ZStack")
        .background {
            GeometryReader { geo in
                Color.clear
                    .preference(key: ContentSizeKey.self, value: geo.size)
                    .onPreferenceChange(ContentSizeKey.self) { size in
                        location = CGPoint(x: size.width/2.0, y: size.height/2.0)
                    }
            }
        }
        .gesture(ExclusiveGesture(dragGesture, magnificationGesture))
        .onAppear {
            if imageFrame.width < widgetSize.width {
                minScale = widgetSize.width / imageFrame.width
            }
            if imageFrame.height < widgetSize.height {
                minScale = widgetSize.height / imageFrame.height
            }
        }
    }
    
    @State var location: CGPoint = CGPoint(x: 150, y: 150)
    @GestureState var startLocation: CGPoint? = nil
    @GestureState var zoomState: ZoomState = .inactive
    @State var startScale: CGFloat = 1.0
    @State var minScale: CGFloat = 1.0
    @State var widgetFrame: CGRect = .zero
    @State var imageFrame: CGRect = .zero
    let widgetSize: CGSize = CGSize(width: 329, height: 155)
    
    enum ZoomState {
        case inactive
        case active(scale: CGFloat)
        
        var scale: CGFloat {
            switch self {
            case .inactive: return 1.0
            case .active(let scale): return scale
            }
        }
    }
    
    var scale: CGFloat {
        startScale * zoomState.scale
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .updating($startLocation, body: { value, startLocation, transaction in
                startLocation = startLocation ?? location
            })
            .onChanged { value in
                let translation = value.translation
                var newLocation = startLocation ?? location
                newLocation.x += translation.width
                newLocation.y += translation.height
                self.location = newLocation
            }
            .onEnded { value in
               ajustLocation()
            }
    }
    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .updating($zoomState) { value, state, transaction in
                state = .active(scale: value)
            }
            .onEnded { value in
                startScale *= value
                ajustScale()
                ajustLocation()
            }
    }
    
    private func ajustScale() {
        if scale < minScale {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                startScale = minScale
            }
        }
    }
    
    private func ajustLocation() {
        var newLocation = self.location
        let width = imageFrame.width/2.0
        let height = imageFrame.height/2.0
        
        let maxLocationX = widgetFrame.minX + width
        let minLocationX = widgetFrame.maxX - width
        if location.x > maxLocationX {newLocation.x = maxLocationX}
        if location.x < minLocationX {newLocation.x = minLocationX}
        
        let maxY = widgetFrame.minY + height
        let minY = widgetFrame.maxY - height
        if location.y > maxY {newLocation.y = maxY}
        if location.y < minY {newLocation.y = minY}
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
            location = newLocation
        }
    }
}


extension View {
    @ViewBuilder func ifdo<Content: View>(condition: @autoclosure ()->Bool, transform: (Self)->Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

extension SwiftUIView {
    struct ContentSizeKey: PreferenceKey {
        static var defaultValue: CGSize = .zero
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        }
    }
    
    struct ImageFrameKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            
        }
    }
    
    struct WidgetFrameKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
