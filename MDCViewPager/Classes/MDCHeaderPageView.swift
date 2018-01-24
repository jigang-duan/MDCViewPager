//
//  MDCHeaderPageView.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

import UIKit
import Kingfisher
import MaterialComponents.MaterialInk

public class MDCHeaderPageView: UIView {
    
    static let FrameHeight = CGFloat(440)
    
    let textColor = UIColor(red: 10 / 255, green: 49 / 255, blue: 66 / 255, alpha: 1)
    let fontAbril = UIFont(name: "AbrilFatface-Regular", size: 36)
    let fontHelvetica = UIFont(name: "Helvetica", size: 14)
    let cyanBoxColor = UIColor(red: 0.19, green: 0.94, blue: 0.94, alpha: 1)
    let descColor = UIColor(white: 0.54, alpha: 1)
    
    var labelString = "Header Page" {
        didSet {
            layoutIfNeeded()
        }
    }

    var descString = "Leave the tunnel and the rain is fallin amazing things happen when you wait" {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var imageURL: URL? {
        didSet {
            imageView.kf.setImage(with: imageURL,
                                  placeholder: placeholderImage,
                                  options: [.transition(.fade(1))])
        }
    }

    lazy var label: UILabel = {
        let `$` = UILabel()
        `$`.font = fontAbril
        `$`.textColor = textColor
        `$`.lineBreakMode = .byWordWrapping
        `$`.numberOfLines = 2
        return `$`
    }()
    
    lazy var labelDesc: UILabel = {
        let `$` = UILabel()
        `$`.lineBreakMode = .byWordWrapping
        `$`.numberOfLines = 3
        `$`.font = fontHelvetica
        `$`.textColor = descColor
        `$`.autoresizingMask = .flexibleWidth
        return `$`
    }()
    
    lazy var cyanBox: UIView = {
        let `$` = UIView()
        `$`.backgroundColor = cyanBoxColor
        return `$`
    }()
    
    lazy var imageView: UIImageView = {
        let `$` = UIImageView()
        `$`.contentMode = .scaleAspectFill
        `$`.autoresizingMask = .flexibleHeight
        return `$`
    }()
    
    public init(title: String, desc: String, image: URL? = nil) {
        self.init()
        self.labelString = title
        self.descString = desc
        self.imageURL = image
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        imageView.kf.setImage(with: imageURL,
                              placeholder: placeholderImage,
                              options: [.transition(.fade(1))])
        addSubview(imageView)
        addSubview(label)
        addSubview(labelDesc)
        addSubview(cyanBox)
        
        let inkOverlay = ShrineInkOverlay(frame: bounds)
        inkOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(inkOverlay)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelWidth = CGFloat(250)
        let labelWidthFrame = CGRect(x: frame.size.width - labelWidth,
                                     y: 90, width: labelWidth, height: 40)
        
        let labelDescWidth = CGFloat(200)
        let labelDescWidthFrame = CGRect(x: frame.size.width - labelDescWidth - 10,
                                         y: 190, width: labelDescWidth, height: 40)
        
        label.attributedText = attributedString(labelString, lineHeightMultiple: 0.8)
        label.sizeToFit()
        label.frame = labelWidthFrame
        
        labelDesc.attributedText = attributedString(descString, lineHeightMultiple: 1.2)
        labelDesc.sizeToFit()
        labelDesc.frame = labelDescWidthFrame
        
        let cyanBoxFrame = CGRect(x: frame.size.width - 210, y: 180, width: 100, height: 8)
        cyanBox.frame = cyanBoxFrame
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 60)
    }
    
    func attributedString(_ string: String,
                          lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attrString = NSMutableAttributedString(string: string)
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle,
                                range:NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    lazy var placeholderImage: UIImage? = {
        let bundlePath = Bundle(for: MDCHeaderPageView.self).bundlePath + "/MDCViewPager.bundle"
        let bundle = Bundle(path: bundlePath)
        if let placeholder = bundle?.path(forResource: "placeholder", ofType: "png") {
            return UIImage(contentsOfFile: placeholder)
        }
        return nil
    }()
}

class ShrineInkOverlay: UIView, MDCInkTouchControllerDelegate {
    
    fileprivate var inkTouchController: MDCInkTouchController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cyan = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 0.2)
        self.inkTouchController = MDCInkTouchController(view:self)
        self.inkTouchController!.defaultInkView.inkColor = cyan
        self.inkTouchController!.addInkView()
        self.inkTouchController!.delegate = self
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
