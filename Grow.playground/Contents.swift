import PlaygroundSupport
import SpriteKit
// This file is done, no more changes should be made here


// You can change the view's size to whatever size you want
let viewSize = CGSize(width: 600, height: 600)

// Creates the view
let sceneView = SKView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: viewSize))
sceneView.ignoresSiblingOrder = true
//sceneView.showsNodeCount = true
//sceneView.showsDrawCount = true
//sceneView.showsFPS = true

// Creates the scene
let gameScene = GameScene(size: viewSize)

// Sets the scene of view
sceneView.presentScene(gameScene)

// Sets the view of the playground page
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

// Keeps the game loop running
PlaygroundPage.current.needsIndefiniteExecution = true

