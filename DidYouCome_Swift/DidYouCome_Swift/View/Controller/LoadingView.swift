//
//  LoadingView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import UIKit
import SwiftyGif

class LoadingView: UIViewController {
    
    let loadingAnimationView = LoadingUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingAnimationView)
        loadingAnimationView.pinEdgesToSuperView()
        loadingAnimationView.loadingGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingAnimationView.loadingGifImageView.startAnimatingGif()
    }

}

extension LoadingView: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        loadingAnimationView.isHidden = true
    }
}
