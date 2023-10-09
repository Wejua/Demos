////
////  ZoomableScrollView.swift
////  HotWidget
////
////  Created by weijie.zhou on 2023/5/3.
////
//
//import SwiftUI
//
////struct TestZoomableScrollView: View {
////
////    @State private var scale: CGFloat = 1.0
////
////    var doubleTapGesture: some Gesture {
////        TapGesture(count: 2).onEnded {
////            if scale < maxAllowedScale / 2 {
////                scale = maxAllowedScale
////            } else {
////                scale = 1.0
////            }
////        }
////    }
////
////    var body: some View {
////            VStack(alignment: .center) {
////                Spacer()
////                ZoomableScrollView(scale: $scale) {
////                    Image("logo3")
////                        .resizable()
////                        .scaledToFit()
////                        .frame(width: 200, height: 200)
////                }
////                .frame(width: 300, height: 300)
////                .border(.black)
////                .gesture(doubleTapGesture)
////                Spacer()
////                Text("Change the scale")
////                Slider(value: $scale, in: 0.5...maxAllowedScale + 0.5)
////                .padding(.horizontal)
////                Spacer()
////            }
////    }
////}
//
////struct TestZoomableScrollView_Proviews: PreviewProvider {
////
////    static var previews: some View {
////        TestZoomableScrollView()
////    }
////}
//
//
//
//class ChangedHitAreaScrollView: UIScrollView {
//    var image: UIImage
//
//    init(image: UIImage) {
//        self.image = image
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let view = super.hitTest(point, with: event)
//        return view
//    }
//
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let isInside = super.point(inside: point, with: event)
//        return isInside
//    }
//}
//
////struct ClippingImageView<Content: View>: UIViewRepresentable {
////    var widgetView: Content
////
////    var scrollView: UIScrollView = {
////        let scrollView = UIScrollView()
//////        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
////        scrollView.maximumZoomScale = maxAllowedScale
////        scrollView.minimumZoomScale = 1
////        scrollView.showsVerticalScrollIndicator = false
////        scrollView.showsHorizontalScrollIndicator = false
////        scrollView.bouncesZoom = true
////        return scrollView
////    }()
////
////    func makeUIView(context: Context) -> UIView {
////        let view = UIView()
////        view.addSubview(scrollView)
////        scrollView.delegate = context.coordinator
////        return view
////    }
////
////    func updateUIView(_ uiView: UIView, context: Context) {
////
////    }
////}
//
//let maxAllowedScale = 4.0
//
//struct ZoomableScrollView<Content: View>: UIViewRepresentable {
//
//    private var image: UIImage
//    private var widgetSize: CGSize
//    private var content: Content
//    @Binding private var scale: CGFloat
//    private var scrollView: UIScrollView = UIScrollView()
//    @State private var imageV: UIImageView?
//    @State private var imageV2: UIImageView?
//    @State private var view: UIView = UIView()
//
//    init(image: UIImage, widgetSize: CGSize, scale: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
//        self.image = image
//        self.widgetSize = widgetSize
//        self._scale = scale
//        self.content = content()
//    }
//
//    func makeUIView(context: Context) -> UIView {
//        let imageV = UIImageView(image: self.image)
//        let imageV2 = UIImageView(image: self.image)
//        imageV.addGestureRecognizer(scrollView.panGestureRecognizer)
//        if let gesture = scrollView.pinchGestureRecognizer {
//            imageV.addGestureRecognizer(gesture)
//        }
//        DispatchQueue.main.async {
//            self.imageV = imageV
//            self.imageV2 = imageV2
//        }
//
//        view.addSubview(imageV)
//        view.addSubview(scrollView)
//        scrollView.addSubview(imageV2)
//
//        // set up the UIScrollView
//        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
//        scrollView.maximumZoomScale = maxAllowedScale
//        scrollView.minimumZoomScale = 1
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.bouncesZoom = true
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        scrollView.widthAnchor.constraint(equalToConstant: widgetSize.width).isActive = true
//        scrollView.heightAnchor.constraint(equalToConstant: widgetSize.height).isActive = true
//        scrollView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
//        scrollView.contentSize = imageV2.image?.size ?? .zero
//
////      Create a UIHostingController to hold our SwiftUI content
//        let hostedView = context.coordinator.hostingController.view!
//        hostedView.translatesAutoresizingMaskIntoConstraints = true
//        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        hostedView.frame = view.bounds
////        view.addSubview(hostedView)
//
//        return view
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(hostingController: UIHostingController(rootView: self.content), scale: $scale, imageV2: imageV2, imageV: imageV, view: self.scrollView)
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // update the hosting controller's SwiftUI content
//        context.coordinator.hostingController.rootView = self.content
//        scrollView.zoomScale = scale
//        guard let imageV = imageV, let imageV2 = imageV2 else {return}
//        imageV.frame = imageV2.convert(imageV2.bounds, to: uiView.coordinateSpace)
////        assert(context.coordinator.hostingController.view.superview == uiView)
//    }
//
//    class Coordinator: NSObject, UIScrollViewDelegate {
//
//        var hostingController: UIHostingController<Content>
//        @Binding var scale: CGFloat
//        var imageV2: UIImageView?
//        var imageV: UIImageView?
//        var view: UIView
//
//        init(hostingController: UIHostingController<Content>, scale: Binding<CGFloat>, imageV2: UIImageView?, imageV: UIImageView?, view: UIView) {
//            self.hostingController = hostingController
//            self._scale = scale
//            self.imageV2 = imageV2
//            self.imageV = imageV
//            self.view = view
//        }
//
//        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//            return imageV2
//        }
//
//        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//            self.scale = scale
//        }
//
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            guard let imageV = imageV, let imageV2 = imageV2 else {return}
//            imageV.frame = imageV2.convert(imageV2.bounds, to: view.coordinateSpace)
//        }
//    }
//}
//
//struct Test: View {
//    @State private var scale: CGFloat = 1.0
//
//    var body: some View {
//        VStack {
//            ZoomableScrollView(image: UIImage(named: "logo3")!, widgetSize: CGSize(width: 329, height: 155), scale: $scale) {
//                Text("hello")
//                    .background(.red)
//            }
//            .frame(width: 300, height: 300)
//        }
//    }
//}
//
//struct ZoomableScrollView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Test()
//    }
//}
//
