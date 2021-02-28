//
//  ContentViewController.swift
//  SwipeLetters
//
//  Created by Glenn Posadas on 1/21/21.
//

import AVFoundation
import UIKit

class ContentViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var label: UILabel!
    var text: String?
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ENVManager.currentEnv == .development {
            label.backgroundColor = .blue
        }
        
        label.text = text
        label.sizeToFit()
    }
    
    @IBAction func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let lastChar = text?.last else { return }
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: String(lastChar))
        synthesizer.speak(utterance)
    }
}
