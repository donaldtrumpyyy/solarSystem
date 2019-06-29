//
//  ViewController.swift
//  ArDices
//
//  Created by Corentin de Maupeou on 28/07/2018.
//  Copyright © 2018 Corentin de Maupeou All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = false
        
        let sunNode = SCNNode()
        let mercureNode = SCNNode()
        let venusNode = SCNNode()
        let earthNode = SCNNode()
        let marsNode = SCNNode()
        let jupiterNode = SCNNode()
        let saturneNode = SCNNode()
        let uranusNode = SCNNode()
        let neptuneNode = SCNNode()
        
        //Soleil
        ajouterSphere(textureIMG: "art.scnassets/sun.jpg", node: sunNode, radius: 0.09, x: -0.1, y: 0, z: -0.4)
        addText(string: "Sun", x: -0.1, y: 0.077, z: -0.3)
        rotationSphere(node: sunNode)
        
        //Mercure
        ajouterSphere(textureIMG: "art.scnassets/mercure.jpg", node: mercureNode, radius: 0.01, x: 0.10, y: 0.02, z: -0.3)
        addText(string: "Mercury", x: 0.027, y: 0.020, z: -0.3)
        rotationSphere(node: mercureNode)
        
        //Venus
        ajouterSphere(textureIMG: "art.scnassets/venus.jpg", node: venusNode, radius: 0.04, x: 0.17, y: 0.02, z: -0.3)
        addText(string: "Venus", x: 0.135, y: 0.057, z: -0.3)
        rotationSphere(node: venusNode)
        
        //Terre
        ajouterSphere(textureIMG: "art.scnassets/earth.jpg", node: earthNode, radius: 0.025, x: 0.26, y: 0.02, z: -0.3)
        addText(string: "Earth", x: 0.23, y: 0.040, z: -0.3)
        rotationSphere(node: earthNode)
        
        //Mars
        ajouterSphere(textureIMG: "art.scnassets/mars.jpg", node: marsNode, radius: 0.020, x: 0.35, y: 0.022, z: -0.3)
        addText(string: "Mars", x: 0.32, y: 0.040, z: -0.3)
        rotationSphere(node: marsNode)
        
        //Jupiter
        ajouterSphere(textureIMG: "art.scnassets/jupiter.jpg", node: jupiterNode, radius: 0.06, x: 0.47, y: 0.022, z: -0.3)
        addText(string: "Jupiter", x: 0.43, y: 0.080, z: -0.3)
        rotationSphere(node: jupiterNode)
        
        //Saturne
        ajouterSphere(textureIMG: "art.scnassets/saturne.jpg", node: saturneNode, radius: 0.03, x: 0.62, y: 0.022, z: -0.3)
        addText(string: "Saturn", x: 0.57, y: 0.055, z: -0.3)
        rotationSphere(node: saturneNode)
        
        //Uranus
        ajouterSphere(textureIMG: "art.scnassets/uranus.jpg", node: uranusNode, radius: 0.04, x: 0.80, y: 0.022, z: -0.3)
        addText(string: "Uranus", x: 0.75, y: 0.060, z: -0.3)
        rotationSphere(node: uranusNode)
        
        //Neptune
        ajouterSphere(textureIMG: "art.scnassets/neptune.jpg", node: neptuneNode, radius: 0.03, x: 1.0, y: 0.022, z: -0.3)
        addText(string: "Neptune", x: 0.95, y: 0.055, z: -0.3)
        rotationSphere(node: neptuneNode)
    }
    
    var meteoriteNode = SCNNode()
    var neptuneNode = SCNNode()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            addMeteorite(position: touchLocation)
            
            print(touchLocation)
        }
    }
    
    func addMeteorite(position: CGPoint) {
        let node = meteoriteNode.clone()
        
        node.position = SCNVector3Make(Float(position.x), Float(position.y), -0.05)
        
        ajouterSphere(textureIMG: "art.scnassets/meteorite.jpg", node: node, radius: 0.03, x: Float(position.x), y: Float(position.y), z: -0.05)
        
        rotationSphere(node: node)
        
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func ajouterSpaceShip(postition: Double) {
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let shipNode = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        shipNode.position = SCNVector3Make(0.1, 0.065, -0.4)
        
        sceneView.scene.rootNode.addChildNode(shipNode)
    }
    
    func addText(string: String, x: Double, y: Double, z: Double) {
        let text = SCNText(string: string, extrusionDepth: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        text.materials = [material]
        text.font = UIFont (name: "Arial Black", size: 9.5)
        
        let node = SCNNode()
        node.position = SCNVector3(x, y, z)
        node.scale = SCNVector3(0.002, 0.004, 0.002)
        node.geometry = text
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene.rootNode.addChildNode(node)
    }
   
    
    @objc func ajouterSphere(textureIMG:String, node:SCNNode, radius:CGFloat, x:Float, y:Float, z:Float) {
        let sphere = SCNSphere(radius: radius)
        let texture = SCNMaterial()

        texture.diffuse.contents = UIImage(named: textureIMG)
        
        texture.lightingModel = .phong

        sphere.materials = [texture]
    
        node.position =  SCNVector3Make(x, y, z)
        node.geometry = sphere
  
        sceneView.scene.rootNode.addChildNode(node)
    }
    

    func rotationSphere(node:SCNNode) {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 10)
        let repAction = SCNAction.repeatForever(action)
        
        node.runAction(repAction, forKey: "rotate")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
