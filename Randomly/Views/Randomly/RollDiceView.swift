//
//  RollDiceView.swift
//  Random
//
//  Created by シン・ジャスティン on 3/9/23.
//

import SceneKit
import SwiftUI

struct RollDiceView: View {

    let scene = SCNScene(named: "Scene Assets.scnassets/Sandbox.scn")!

    var body: some View {
        SceneView(scene: scene,
                  pointOfView: scene.rootNode.childNode(withName: "camera", recursively: false)!,
                  preferredFramesPerSecond: 120,
                  antialiasingMode: .multisampling4X)
        .ignoresSafeArea(edges: [.top, .leading, .trailing])
        .safeAreaInset(edge: .bottom) {
            ScrollView(.horizontal) {
                ActionBar(primaryActionText: "Shared.Do.RollDice.5",
                          primaryActionIconName: "dice.fill",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    addDice(number: 5)
                }
                    .secondaryAction({
                        HStack(alignment: .center, spacing: 8.0) {
                          Button {
                              addDice(number: 1)
                          } label: {
                              Label("Shared.Do.RollDice", systemImage: "dice.fill")
                                  .bold()
                                  .padding(.horizontal, 4.0)
                                  .frame(minHeight: 42.0)
                          }
                          .buttonStyle(.borderedProminent)
                          .clipShape(RoundedRectangle(cornerRadius: 99))
                          Button {
                              addDice(number: 2)
                          } label: {
                              Label("Shared.Do.RollDice.2", systemImage: "dice.fill")
                                  .bold()
                                  .padding(.horizontal, 4.0)
                                  .frame(minHeight: 42.0)
                          }
                          .buttonStyle(.borderedProminent)
                          .clipShape(RoundedRectangle(cornerRadius: 99))
                          Button {
                              addDice(number: 3)
                          } label: {
                              Label("Shared.Do.RollDice.3", systemImage: "dice.fill")
                                  .bold()
                                  .padding(.horizontal, 4.0)
                                  .frame(minHeight: 42.0)
                          }
                          .buttonStyle(.borderedProminent)
                          .clipShape(RoundedRectangle(cornerRadius: 99))
                          Button {
                              addDice(number: 4)
                          } label: {
                              Label("Shared.Do.RollDice.4", systemImage: "dice.fill")
                                  .bold()
                                  .padding(.horizontal, 4.0)
                                  .frame(minHeight: 42.0)
                          }
                          .buttonStyle(.borderedProminent)
                          .clipShape(RoundedRectangle(cornerRadius: 99))
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing])
            }
            .scrollIndicators(.hidden)
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
        .navigationTitle("Do.DiceRoll.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func addDice(number: Int) {
        resetScene()
        for index in 0..<number {
            scene.rootNode.childNode(withName: "objects",
                                     recursively: false)!.addChildNode(
                                        dice(position: SCNVector3(0, 8 + (Double(index) * 1.5), 10),
                                             rotation: SCNVector3(randRadians(),
                                                                  randRadians(),
                                                                  randRadians())))
        }
        applyForce()
    }

    func resetScene() {
        scene.background.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "worldFloor",
                                 recursively: true)!
            .geometry?.firstMaterial?.diffuse.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "objects", recursively: false)!.enumerateChildNodes { node, _ in
            node.removeFromParentNode()
        }
        scene.rootNode.childNode(withName: "ambientLight", recursively: true)!.light!.intensity = 700
        scene.rootNode.childNode(withName: "topDownLight", recursively: true)!.light!.intensity = 1000
    }

    func dice(position: SCNVector3, rotation: SCNVector3) -> SCNNode {
        let diceScene = SCNScene(named: "Scene Assets.scnassets/Dice.scn")
        let diceNode = diceScene!.rootNode.childNodes[0]
        diceNode.eulerAngles = rotation
        diceNode.position = position
        return diceNode
    }

    func applyForce() {
        for childNode in scene.rootNode.childNode(withName: "objects", recursively: false)!.childNodes {
            childNode.physicsBody!.applyForce(SCNVector3(0, 0, -1.5),
                                              asImpulse: true)
            childNode.physicsBody!.applyTorque(SCNVector4(0.05, 0.05, 0.05, randRadians()),
                                               asImpulse: false)
        }
    }

    func randRadians() -> Float {
        return Float.random(in: -3.14...3.14)
    }

}
