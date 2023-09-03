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
        .overlay {
            ZStack(alignment: .bottom) {
                Color.clear
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
                                  LargeButtonLabel(iconName: "dice.fill",
                                                   text: "Shared.Do.RollDice")
                                  .bold()
                                  .frame(maxWidth: .infinity)
                              }
                              .buttonStyle(.borderedProminent)
                              .clipShape(RoundedRectangle(cornerRadius: 99))
                              Button {
                                  addDice(number: 2)
                              } label: {
                                  LargeButtonLabel(iconName: "dice.fill",
                                                   text: "Shared.Do.RollDice.2")
                                  .bold()
                                  .frame(maxWidth: .infinity)
                              }
                              .buttonStyle(.borderedProminent)
                              .clipShape(RoundedRectangle(cornerRadius: 99))
                              Button {
                                  addDice(number: 3)
                              } label: {
                                  LargeButtonLabel(iconName: "dice.fill",
                                                   text: "Shared.Do.RollDice.3")
                                  .bold()
                                  .frame(maxWidth: .infinity)
                              }
                              .buttonStyle(.borderedProminent)
                              .clipShape(RoundedRectangle(cornerRadius: 99))
                              Button {
                                  addDice(number: 4)
                              } label: {
                                  LargeButtonLabel(iconName: "dice.fill",
                                                   text: "Shared.Do.RollDice.4")
                                  .bold()
                                  .frame(maxWidth: .infinity)
                              }
                              .buttonStyle(.borderedProminent)
                              .clipShape(RoundedRectangle(cornerRadius: 99))
                            }
                        })
                        .frame(maxWidth: .infinity)
                        .padding([.leading, .trailing])
                        .padding(.top, 8.0)
                        .padding(.bottom, 16.0)
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            resetScene()
        }
        .navigationTitle("Randomly.Do.DiceRoll.ViewTitle")
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
    }

    func resetScene() {
        scene.background.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "worldFloor",
                                 recursively: true)!
            .geometry?.firstMaterial?.diffuse.contents = UIColor.systemBackground
        scene.rootNode.childNode(withName: "objects", recursively: false)!.enumerateChildNodes { node, _ in
            node.removeFromParentNode()
        }
    }

    func dice(position: SCNVector3, rotation: SCNVector3) -> SCNNode {
        let diceScene = SCNScene(named: "Scene Assets.scnassets/Dice.scn")
        let diceNode = diceScene!.rootNode.childNodes[0]
        diceNode.physicsBody!.applyForce(SCNVector3(0, 0, -1.5),
                                         asImpulse: true)
        diceNode.physicsBody!.applyTorque(SCNVector4(0.05, 0.05, 0.05, randRadians()),
                                          asImpulse: false)
        diceNode.eulerAngles = rotation
        diceNode.position = position
        return diceNode
    }

    func randRadians() -> Float {
        return Float.random(in: -3.14...3.14)
    }

}
