//
//  PhotoPickerBottomPromptView.swift
//  HXPhotoPicker
//
//  Created by Silence on 2023/7/29.
//  Copyright © 2023 洪欣. All rights reserved.
//

import UIKit

class PhotoPickerBottomPromptView: UIToolbar {
    let config: PickerBottomViewConfiguration
    init(config: PickerBottomViewConfiguration) {
        self.config = config
        super.init(frame: .zero)
        initView()
    }
    
    private var promptLb: UILabel!
    private var promptIcon: UIImageView!
    private var promptArrow: UIImageView!
    
    private func initView() {
        let promptIconImage = UIImage.image(for: "hx_picker_photolist_bottom_prompt")?.withRenderingMode(.alwaysTemplate)
        promptIcon = UIImageView(image: promptIconImage)
        promptIcon.size = promptIcon.image?.size ?? CGSize.zero
        addSubview(promptIcon)
        
        promptLb = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        promptLb.text = "无法访问相册中所有照片，\n请允许访问「照片」中的「所有照片」".localized
        promptLb.font = .systemFont(ofSize: 15)
        promptLb.numberOfLines = 0
        promptLb.adjustsFontSizeToFitWidth = true
        addSubview(promptLb)
        
        let promptArrowImage = UIImage.image(for: "hx_picker_photolist_bottom_prompt_arrow")?.withRenderingMode(.alwaysTemplate)
        promptArrow = UIImageView(image: promptArrowImage)
        promptArrow.size = promptArrow.image?.size ?? CGSize.zero
        addSubview(promptArrow)
        
        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didPromptViewClick)
            )
        )
        configColor()
    }
    
    @objc
    private func didPromptViewClick() {
        PhotoTools.openSettingsURL()
    }
    
    private func configColor() {
        if PhotoManager.isDark {
            backgroundColor = config.backgroundDarkColor
            barTintColor = config.barTintDarkColor
            barStyle = config.barDarkStyle
            promptLb.textColor = config.promptTitleDarkColor
            promptIcon.tintColor = config.promptIconDarkColor
            promptArrow.tintColor = config.promptArrowDarkColor
        }else {
            backgroundColor = config.backgroundColor
            barTintColor = config.barTintColor
            barStyle = config.barStyle
            promptLb.textColor = config.promptTitleColor
            promptIcon.tintColor = config.promptIconColor
            promptArrow.tintColor = config.promptArrowColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let viewHeight = height - UIDevice.bottomMargin
        promptIcon.x = 12 + UIDevice.leftMargin
        promptIcon.centerY = viewHeight * 0.5
        promptArrow.x = width - 12 - promptArrow.width - UIDevice.rightMargin
        promptLb.x = promptIcon.frame.maxX + 12
        promptLb.width = promptArrow.x - promptLb.x - 12
        promptLb.centerY = viewHeight * 0.5
        promptArrow.centerY = viewHeight * 0.5
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                configColor()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}