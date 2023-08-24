//
//  ViewController.swift
//  SpriteKitTest
//
//  Created by Oleksandr Smakhtin on 24/08/2023.
//

import UIKit
import SpriteKit

class MainVC: UIViewController {
    
    //MARK: - UI
    private lazy var mainView = SKView(frame: view.frame)
    
    private lazy var sceneOne = SceneOne(size: view.frame.size)
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .black
        // add subviews
        addSubviews()
        // configure scenes
        mainView.presentScene(sceneOne)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(mainView)
    }

}

