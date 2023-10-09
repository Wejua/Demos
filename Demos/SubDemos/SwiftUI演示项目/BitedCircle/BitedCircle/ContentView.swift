//
//  ContentView.swift
//  BitedCircle
//
//  Created by weijie.zhou on 2023/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DemoView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DemoView: View {
    struct BiteCircle: Shape {
        func path(in rect: CGRect) -> Path {
            let offset = rect.maxX - 26
            let crect = CGRect(origin: .zero, size: CGSize(width: 26, height: 26)).offsetBy(dx: offset, dy: offset)

            var path = Rectangle().path(in: rect)
            path.addPath(Circle().path(in: crect))
            return path
        }
    }
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color.blue)
                .mask(BiteCircle().fill(style: .init(eoFill: true)))     // << here !!
                .shadow(color: .black.opacity(0.5), radius: 4, x: 2, y: 2)

//            Circle()
//                .frame(width: 22, height: 22)
//                .foregroundColor(.blue)
//                .offset(x: 18, y: 18)
        }

    }
}
