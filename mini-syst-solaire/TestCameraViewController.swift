//
//  TestCameraViewController.swift
//  solarSystem
//
//  Created by Corentin de Maupeou on 10/15/18.
//  Copyright © 2018 Corentin de Maupeou. All rights reserved.
//

import UIKit
import ARKit

class TestCameraViewController: UIViewController {

    @IBOutlet weak var ARSceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showBoundingBoxes]
        ARSceneView.session.run(config)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
