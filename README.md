# ListItemTracking

ListItemTracking allows getting notified about all frame changes for the items in a SwiftUI List.

Minimal usage is as follow:
```swift
struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            List(0..<100) { i in
                Text("Item \(i)")
                    .onItemFrameChanged(listGeometry: geometry) { (frame: CGRect?) in
                        print("rect of item \(i): \(String(describing: frame)))")
                    }
            }
            .trackListFrame()
        }
    }
}
```
