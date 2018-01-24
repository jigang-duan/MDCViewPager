//
//  ViewPager.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

import UIKit
import MaterialComponents.MaterialPageControl

@objc
public protocol MDCViewPagerDelegate: class {
    @objc optional func viewPagerDidChangePage(viewPager: MDCViewPager, at page: Int)
}

@objc
public protocol MDCViewPagerDataSource: class {
    func numberOfPages(inViewPager viewPager: MDCViewPager) -> Int
    func viewPager(_ viewPager: MDCViewPager, viewForAtPage page: Int) -> UIView
    @objc optional func viewPagerShouldShowPageControl(_ viewPager: MDCViewPager) -> Bool
}

public class MDCViewPager: UIView, UIScrollViewDelegate {
    
    @IBOutlet public weak var dataSource: MDCViewPagerDataSource? {
        didSet {
            reloadData()
        }
    }
    
    @IBOutlet public weak var delegate: MDCViewPagerDelegate?
    
    lazy var pageControl: MDCPageControl = {
        let `$` = MDCPageControl()
        `$`.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return `$`
    }()
    
    lazy var scrollView: UIScrollView = {
        let `$` = UIScrollView()
        `$`.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        `$`.isPagingEnabled = true
        `$`.showsHorizontalScrollIndicator = false
        return `$`
    }()
    
    private var pages: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        scrollView.delegate = self
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageControl.addTarget(self, action: #selector(didChangePage(_:)), for: .valueChanged)
        reloadData()
    }
    
    func reloadData() {
        guard let dataSource = self.dataSource else { return }
        
        let numberOfPages = dataSource.numberOfPages(inViewPager: self)
        
        pages.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        addSubview(scrollView)
        
        for i in 0 ..< numberOfPages {
            let boundsLeft = CGFloat(i) * bounds.width
            let pageFrame = bounds.offsetBy(dx: boundsLeft, dy: 0)
            let page = dataSource.viewPager(self, viewForAtPage: i)
            page.frame = pageFrame
            page.clipsToBounds = true
            page.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pages.append(page)
            scrollView.addSubview(page)
        }
        
        let shouldShowPageControl = self.dataSource?.viewPagerShouldShowPageControl?(self) ?? true
        pageControl.isHidden = !shouldShowPageControl
        pageControl.numberOfPages = numberOfPages
        let pageControlSize = pageControl.sizeThatFits(bounds.size)
        pageControl.frame = CGRect(x: 0,
                                   y: bounds.height - pageControlSize.height,
                                   width: bounds.width,
                                   height: pageControlSize.height)
        
        addSubview(pageControl)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let count = pages.count
        guard count > 0 else {
            return
        }
//        var safeAreaInset: CGFloat = 0
//        if #available(iOS 11.0, *) {
//            safeAreaInset = min(self.safeAreaInsets.top, 10)
//        }
        let boundsWidth = bounds.width
        let boundsHeight = bounds.height
        for i in 0...count - 1 {
            let boundsLeft = CGFloat(i) * boundsWidth
            let pageFrame = bounds.offsetBy(dx: boundsLeft, dy: 0)
            let page = pages[i]
            page.frame = pageFrame
        }
        let pageControlSize = pageControl.sizeThatFits(bounds.size)
        pageControl.frame = CGRect(x: 0, y: boundsHeight - pageControlSize.height, width: boundsWidth,
                                   height: pageControlSize.height)
        let scrollWidth: CGFloat = boundsWidth * CGFloat(pages.count)
        scrollView.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight)
        scrollView.contentSize = CGSize(width: scrollWidth, height: boundsHeight)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidScroll(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndDecelerating(scrollView)
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        self.delegate?.viewPagerDidChangePage?(viewPager: self, at: page)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    @objc private func didChangePage(_ sender: MDCPageControl) {
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width
        scrollView.setContentOffset(offset, animated: true)
        self.delegate?.viewPagerDidChangePage?(viewPager: self, at: sender.currentPage)
    }
}
