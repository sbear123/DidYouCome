//
//  LoadingUIView.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/14.
//

import UIKit
import SwiftyGif

class LoadingUIView: UIView {
    
    let loadingGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "loading.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: -1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(loadingGifImageView)
        loadingGifImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingGifImageView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        loadingGifImageView.heightAnchor.constraint(equalToConstant: 267).isActive = true
    }
}
