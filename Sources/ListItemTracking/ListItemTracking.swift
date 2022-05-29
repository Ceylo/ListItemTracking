//
//  ListItemTracking.swift
//  ListItemTracking
//
//  Created by Ceylo on 29/05/2022.
//

import SwiftUI

struct ViewFrameKey: PreferenceKey {
    typealias Value = CGRect?
    static var defaultValue: CGRect? = nil
    static func reduce(value: inout Value, nextValue: () -> Value) {
        fatalError("Not implemented")
    }
}

struct ItemFrameTracking: ViewModifier {
    var listGeometry: GeometryProxy
    var frameUpdated: (CGRect?) -> Void
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { itemGeometry in
                    let itemFrameIgnoringSafeArea = itemGeometry.frame(in: .named("ListFrame.Scroll"))
                    let parentListFrame = listGeometry.frame(in: .global)
                    let parentListOffset = parentListFrame.origin
                    let itemFrame = CGRect(
                        origin: CGPoint(x: itemFrameIgnoringSafeArea.origin.x - parentListOffset.x,
                                        y: itemFrameIgnoringSafeArea.origin.y - parentListOffset.y),
                        size: itemFrameIgnoringSafeArea.size)
                    let visible = parentListFrame.intersects(itemFrameIgnoringSafeArea)
                    
                    Color.clear.preference(key: ViewFrameKey.self,
                                           value: visible ? itemFrame : nil)
                }
            }
            .onPreferenceChange(ViewFrameKey.self) { frame in
                frameUpdated(frame)
            }
    }
}

struct ListFrameTracking: ViewModifier {
    func body(content: Content) -> some View {
        content
            .coordinateSpace(name: "ListFrame.Scroll")
    }
}

public extension View {
    func onItemFrameChanged(listGeometry: GeometryProxy, _ frameUpdated: @escaping (CGRect?) -> Void) -> some View {
        modifier(ItemFrameTracking(listGeometry: listGeometry, frameUpdated: frameUpdated))
    }
    
    func trackListFrame() -> some View {
        modifier(ListFrameTracking())
    }
}
