//
//  ZoomableScrollView.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/5/3.
//

import SwiftUI

struct TestZoomableScrollView: View {

    @State private var scale: CGFloat = 1.0
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            if scale < maxAllowedScale / 2 {
                scale = maxAllowedScale
            } else {
                scale = 1.0
            }
        }
    }
    
    var body: some View {
            VStack(alignment: .center) {
                Spacer()
                ZoomableScrollView(scale: $scale) {
                    Image("logo3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .frame(width: 300, height: 300)
                .border(.black)
                .gesture(doubleTapGesture)
                Spacer()
                Text("Change the scale")
                Slider(value: $scale, in: 0.5...maxAllowedScale + 0.5)
                .padding(.horizontal)
                Spacer()
            }
    }
}

struct TestZoomableScrollView_Proviews: PreviewProvider {

    static var previews: some View {
        TestZoomableScrollView()
    }
}


let maxAllowedScale = 4.0

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    
    private var content: Content
    @Binding private var scale: CGFloat

    init(scale: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self._scale = scale
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = maxAllowedScale
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bouncesZoom = true

//      Create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)

        return scrollView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content), scale: $scale)
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        uiView.zoomScale = scale
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {

        var hostingController: UIHostingController<Content>
        @Binding var scale: CGFloat

        init(hostingController: UIHostingController<Content>, scale: Binding<CGFloat>) {
            self.hostingController = hostingController
            self._scale = scale
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }

        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            self.scale = scale
        }
    }
}

