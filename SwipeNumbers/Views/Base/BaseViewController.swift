//
//  BaseViewController.swift
//  WhereIsABC
//
//  Created by Glenn Posadas on 12/11/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return [.top, .bottom]
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return false
    }
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
