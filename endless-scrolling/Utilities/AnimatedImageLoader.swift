//
//  AnimatedImageLoader.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 11/01/2026.
//

import Gifu
import SwiftUI

struct AnimatedImageLoader: UIViewRepresentable {
    let imageURL: URL

    func makeUIView(context: Context) -> UIView {
        let container = UIView()

        // add activity indicator to the container
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        container.addSubview(activityIndicator)

        // add gif image to the container
        let imageView = GIFImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        container.addSubview(imageView)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: container.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: container.centerYAnchor
            ),
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            imageView.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ),
        ])

        imageView.animate(
            withGIFURL: imageURL,
            loopBlock: {
                // stop loading loading indicators animation and remove it from the container
                // make GIF go from completely transparent to fully visible
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 1
                    }
                }
            }
        )

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
