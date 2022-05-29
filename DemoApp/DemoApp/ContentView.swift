//
//  ContentView.swift
//  DemoApp
//
//  Created by Ceylo on 29/05/2022.
//

import SwiftUI
import ListItemTracking

struct ContentView: View {
    static let itemCount = 100
    @State private var frames = [CGRect?](repeating: nil, count: itemCount)
    
    var list: some View {
        GeometryReader { geometry in
            List(0..<Self.itemCount, id: \.self) { i in
                Text("Item \(i)")
                    .onItemFrameChanged(listGeometry: geometry) { frame in
                        print("rect of item \(i): \(String(describing: frame)))")
                        frames[i] = frame
                    }
            }
            .trackListFrame()
        }
        .border(.black)
    }
    
    var trackedFrames: some View {
        ForEach(0..<Self.itemCount, id: \.self) { i in
            if let frame = frames[i] {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .border(.cyan)
                        .offset(x: frame.origin.x, y: frame.origin.y)
                        .frame(width: frame.width, height: frame.height)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            list
            // just to display all the rects and show that items frame is correct
            // and updated live
            trackedFrames
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
