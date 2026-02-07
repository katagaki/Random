import SwiftUI
import SceneKit

/// A reusable SceneKit view container with standard configuration
struct SceneKitContainer: View {
    let scene: SCNScene

    var body: some View {
        SceneView(scene: scene,
                  pointOfView: scene.rootNode.childNode(withName: "camera", recursively: false)!,
                  preferredFramesPerSecond: 120,
                  antialiasingMode: .multisampling4X)
        .ignoresSafeArea(edges: [.top, .leading, .trailing])
    }
}
