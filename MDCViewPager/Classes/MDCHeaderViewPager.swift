//
//  MDCHeaderViewPager.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

import UIKit

public class MDCHeaderViewPager: MDCViewPager {
    
    public struct DataSouce {
        var labelString: String
        var descString: String
        var imageURL: URL?
        
        public init(lable: String, desc: String, imageURL: URL? = nil) {
            self.labelString = lable
            self.descString = desc
            self.imageURL = imageURL
        }
    }
    
    private var childViews: [MDCHeaderPageView] = []
    
    public var dataSouces: [DataSouce] = [] {
        didSet {
            childViews.removeAll()
            dataSouces.forEach {
                childViews.append(MDCHeaderPageView(
                    title: $0.labelString,
                    desc: $0.descString,
                    image: $0.imageURL
                ))
            }
            reloadData()
        }
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
        self.dataSource = self
        reloadData()
    }
}

extension MDCHeaderViewPager: MDCViewPagerDataSource {
    
    public func numberOfPages(inViewPager viewPager: MDCViewPager) -> Int {
        return childViews.count
    }
    
    public func viewPager(_ viewPager: MDCViewPager, viewForAtPage page: Int) -> UIView {
        return childViews[page]
    }
}
