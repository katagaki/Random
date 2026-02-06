//
//  TossCoinView.swift
//  Random
//
//  Created by シン・ジャスティン on 3/9/23.
//

import SceneKit
import SwiftUI

struct TossCoinView: View {

    let scene = SCNScene(named: "Scene Assets.scnassets/Sandbox.scn")!

    var body: some View {
        SceneView(scene: scene,
                  pointOfView: scene.rootNode.childNode(withName: "camera", recursively: false)!,
                  preferredFramesPerSecond: 120,
                  antialiasingMode: .multisampling4X)
        .ignoresSafeArea(edges: [.top, .leading, .trailing])
        .safeAreaInset(edge: .bottom) {
                ActionBar(primaryActionText: "Shared.Do.FlipCoin",
                          primaryActionIconName: "hands.sparkles.fill",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    flipCoin()
                }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing])
                    .padding([.top, .bottom], 16.0)
                    .background(Material.bar)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .frame(height: 1/3)
                            .foregroundColor(.primary.opacity(0.2))
                    }
        }
        .onAppear {
            resetScene()
        }
        .navigationTitle("Randomly.Do.CoinFlip.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func flipCoin() {
        resetScene()
        scene.rootNode.childNode(withName: "objects",
                                 recursively: false)!.addChildNode(
                                    coin(rotation: SCNVector3(randRadians(),
                                                              randRadians(),
                                                              randRadians())))
    }

    func resetScene() {
        scene.background.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "worldFloor",
                                 recursively: true)!
            .geometry?.firstMaterial?.diffuse.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "objects", recursively: false)!.enumerateChildNodes { node, _ in
            node.removeFromParentNode()
        }
        scene.rootNode.childNode(withName: "ambientLight", recursively: true)!.light!.intensity = 300
        scene.rootNode.childNode(withName: "topDownLight", recursively: true)!.light!.intensity = 500
    }

    func coin(rotation: SCNVector3) -> SCNNode {
        let diceScene = SCNScene(named: "Scene Assets.scnassets/Coin.scn")
        let diceNode = diceScene!.rootNode.childNodes[0]
        diceNode.physicsBody!.applyForce(SCNVector3(0, 30, 0),
                                         asImpulse: true)
        diceNode.physicsBody!.applyTorque(SCNVector4(0, 3.14, 3.14, randRadians()),
                                          asImpulse: true)
        diceNode.position = SCNVector3(0, 8, 0)
        return diceNode
    }

    func randRadians() -> Float {
        return Float.random(in: 1.0...3.14)
    }

}
