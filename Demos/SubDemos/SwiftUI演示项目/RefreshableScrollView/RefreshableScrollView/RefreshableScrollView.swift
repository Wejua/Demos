//
//  RefreshableScrollView.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/28.
//

import SwiftUI

public struct RefreshableScrollView<Content: View, ItemModel>: View {
    public enum RefreshFooterState: Equatable {
        case hasMoreData
        case noMoreData
    }
    public enum RefreshHeaderState: Equatable {
        case idle
        case pulling(progress: CGFloat)
        case refreshing
    }
    
    public typealias RefreshFuncBlock = (_ loadPage: Int, _ success:@escaping ([ItemModel]) -> Void) -> Void
    public typealias ContentBlock = () -> Content
    public typealias RefreshFooterBlock = (_ state: RefreshFooterState) -> AnyView
    public typealias RefreshHeaderBlock = (_ state: RefreshHeaderState) -> AnyView
    
    @Binding var itemModels: [ItemModel]
    
    private var content: ContentBlock
    private var refreshFunc: RefreshFuncBlock
    private var showsIndicators = false
    private var firstPage: Int = 1
    
    private let coordinate = UUID()
    private let contentCoordinate = UUID()
    @State private var loadPage: Int = 1
    @State private var refreshFooterView: RefreshFooterBlock = { state in
        let text = state == .noMoreData ? "没有更多数据了" : "正在加载更多数据..."
        return AnyView(
            Text(text)
                .font(.system(size: 18))
                .padding([.top, .bottom], 15)
        )
    }
    @State private var refreshHeaderView: RefreshHeaderBlock = { state in
        var text: String
        switch state {
        case .idle:
            text = "继续下拉刷新"
        case .pulling(progress: let progress):
            text = String(format:"继续下拉刷新%.3f", progress)
        case .refreshing:
            text = "正在刷新..."
        }
        return AnyView(
            HStack {
                ProgressView()
                    .opacity(state == .refreshing ? 1.0 : 0.0)
                    .progressViewStyle(.circular)
                Text(text)
            }
        )
    }
    @State private var hasLoadFirstPage: Bool = false
    @State private var refreshFooterState: RefreshFooterState = .hasMoreData
    @State private var refreshHeaderState: RefreshHeaderState = .idle
    @State private var canLoadMore: Bool = true
//    @State var contentHeight: CGFloat = 0.0
//    @State var scrollViewHeight: CGFloat = 0.0
//    @State var scrollViewContentOffset: CGFloat = 0.0
    @State private var showFooterView: Bool = true
    @State private var threshold: CGFloat = 44.0
    @State private var headerHeight: CGFloat = 0.0
    @State private var isLoadingData: Bool = false
    @State private var vStackOffset: CGFloat = 0.0
    @GestureState private var dragOffset: CGFloat = 0.0
    
    public init(showsIndicators: Bool = false, firstPage: Int = 1, itemModels: Binding<[ItemModel]>, content: @escaping ContentBlock, refreshFunc: @escaping RefreshFuncBlock) {
        self.showsIndicators = showsIndicators
        self._itemModels = itemModels
        self.content = content
        self.refreshFunc = refreshFunc
        self.firstPage = firstPage
        self.loadPage = firstPage
    }
    
    public var body: some View {
        GeometryReader { scrollGeo in
            ScrollView(showsIndicators: showsIndicators) {
                LazyVStack(spacing: 0) {
                    HStack {
                        refreshHeaderView(refreshHeaderState)
                            .frame(height: 80)
                            .opacity(refreshHeaderState == .idle ? 0.0 : 1.0)
                            .offset(x: 100)
                    }
                    .background(.blue)
                    .background {
                        GeometryReader { geo in
                            let offset = geo.frame(in: .named(coordinate)).origin.y
                            let _ = headerHeight = geo.size.height
                            if offset == 0.0 {
                                let _ =  refreshHeaderState = .idle
                            } else if offset <= threshold {
                                let _ =  refreshHeaderState = .pulling(progress: offset / threshold)
                            } else if offset > threshold {
                                let _ = refreshHeaderState = .refreshing
                            }
                            Color.clear
                        }
                    }
                    
                    content()
                    
                    HStack {
                        if canLoadMore {
                            refreshFooterView(refreshFooterState)
                                .frame(maxWidth: .infinity)
                                .opacity(showFooterView ? 1.0 : 0.0)
                                .onAppear {
                                    if refreshFooterState == .hasMoreData {
                                        refreshFunc(loadPage, { items in
                                            if items.count == 0 {
                                                refreshFooterState = .noMoreData
                                            } else {
                                                self.itemModels.append(contentsOf: items)
                                                loadPage += 1
                                            }
                                        })
                                    }
                                }
                        }
                    }
                    .background {
                        GeometryReader { geo in
                            let contentHeight = geo.frame(in: .named(contentCoordinate)).origin.y
                            let scrollViewHeight = scrollGeo.size.height
                            let _ = showFooterView = contentHeight < scrollViewHeight ? false : true
                            Color.clear
                        }
                    }
                    .frame(width: scrollGeo.size.width)
                }
                .coordinateSpace(name: contentCoordinate)
                .offset(y: -headerHeight)
                .offset(y: vStackOffset)
                .onChange(of: refreshHeaderState) { state in
                    if (state == .refreshing) {
                        if isLoadingData == false {
                            isLoadingData = true
//                            vStackOffset = headerHeight
                            refreshFunc(firstPage, {items in
                                loadPage = firstPage
                                refreshFooterState = .hasMoreData
//                                withAnimation(.linear(duration: 0.3)) {
//                                    vStackOffset = -headerHeight
//                                }
                                isLoadingData = false
                            })
                        }
                    }
                }
            }
            .coordinateSpace(name: coordinate)
//            .refreshable {
//                refreshFunc(firstPage, {items in
//                    loadPage = firstPage
//                    refreshFooterState = .hasMoreData
//                })
//            }
            .onAppear {
                if hasLoadFirstPage == false {
                    refreshFunc(firstPage, { items in
                        self.itemModels = items
                        loadPage += 1
                        hasLoadFirstPage = true
                    })
                }
            }
        }
        .gesture(
            DragGesture()
                .updating($dragOffset, body: { value, state, transaction in
//                        print("offset: \(dragOffset), \nvalue\(value), \nstate: \(state) \ntransaction: \(transaction)")
                })
                .onEnded({ value in
//                        print("value: \(value)")
                })
        )
    }
    
    public func refreshFooterView(view: @escaping RefreshFooterBlock) -> RefreshableScrollView {
        refreshFooterView = view
        return self
    }
    
    public func refreshHeaderView(view: @escaping RefreshHeaderBlock) -> RefreshableScrollView {
        refreshHeaderView = view
        return self
    }
    
    public func refreshThreshold(threshold: CGFloat) -> RefreshableScrollView {
        self.threshold = threshold
        return self
    }
    
    public func canLoadMore(_ loadMore: Bool) -> RefreshableScrollView {
        canLoadMore = loadMore
        return self
    }
}

struct IdentifiableModel: Identifiable {
    var id = UUID()
}

func testLoadingDataFunc() async {
    sleep(3)
}

struct RefreshableScrollView_Previews: PreviewProvider {
    @State static var models: [IdentifiableModel] = {
        var models = [IdentifiableModel]()
        for _ in 0..<20 {
            models.append(IdentifiableModel())
        }
        return models
    }()
    static var previews: some View {
        RefreshableScrollView(itemModels: $models) {
            LazyVStack {
                ForEach(models) { model in
                    Text("hello:\(model.id)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                }
            }
        } refreshFunc: { loadPage, success in
            Task {
                await testLoadingDataFunc()
                success([])
            }
        }
//        .canLoadMore(false)
    }
}
