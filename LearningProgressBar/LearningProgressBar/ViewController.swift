//
//  ViewController.swift
//  LearningProgressBar
//
//  Created by Changhao Li on 2019/8/29.
//  Copyright © 2019 Changhao Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let progressBar = GradientProgressView(frame: CGRect(x: 0, y: 0, width: 240, height: 120), lineWith: 10)
        progressBar.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        progressBar.animateToProgress(0.8)
        view.addSubview(progressBar)
    }


}

