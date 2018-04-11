//
//  ViewController.swift
//  ARTest
//
//  Created by anoop mohanan on 03/04/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


class ViewController: UIViewController, ARSCNViewDelegate {

    var currentAngle: Float = 0.0
    
    var earthNode:SCNNode!
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // create sphere node
        let earthNode = SCNNode(geometry: SCNSphere(radius: 0.25))
        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "earth")
        earthNode.position = SCNVector3Make(0, -0.1, -1)
        self.earthNode = earthNode
        // Set the scene to the view
        sceneView.scene = scene
        scene.rootNode.addChildNode(earthNode)
        
        let panGest = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        sceneView.addGestureRecognizer(panGest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
     
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!)

        let x = Float(translation.x)
        let y = Float(-translation.y)
        let anglePan = (sqrt(pow(x,2)+pow(y,2)))*(Float)(Double.pi)/180.0

        var rotationVector = SCNVector4()
        rotationVector.x = x
        rotationVector.y = y
        rotationVector.z = 0.0
        rotationVector.w = anglePan


        self.earthNode.rotation = rotationVector
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
