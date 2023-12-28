//
//  InitialUIMethods.swift
//  Movie Today
//
//  Created by Timofey Spodeneyko on 28.12.2023.
//

import UIKit

private func createMetadataLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 16)
    return label
}

private func createMetadataIcon(systemName: String) -> UIImageView {
    let imageView = UIImageView(image: UIImage(systemName: systemName))
    imageView.tintColor = .gray
    imageView.contentMode = .scaleAspectFit
    return imageView
}

private func createDivider() -> UIView {
    let view = UIView()
    view.backgroundColor = .gray
    view.widthAnchor.constraint(equalToConstant: 1).isActive = true
    view.heightAnchor.constraint(equalToConstant: 24).isActive = true
    return view
}

private func configureButton(_ button: UIButton, title: String, systemImageName: String, backgroundColor: UIColor, isLargeIcon: Bool = false) {
    var config = UIButton.Configuration.filled()
    config.title = title
    config.baseForegroundColor = .white
    config.baseBackgroundColor = backgroundColor
    config.imagePlacement = .leading
    config.cornerStyle = .capsule
    config.imagePadding = 10

    if isLargeIcon {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .large)
        config.image = UIImage(systemName: systemImageName, withConfiguration: largeConfig)
    } else {
        config.image = UIImage(systemName: systemImageName)
    }
    button.configuration = config
}
