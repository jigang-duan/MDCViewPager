//
//  ViewPagerController.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

import UIKit

open class ViewPagerController: UIViewController {
    
    public private(set) var viewPager: MDCViewPager!

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewPager = MDCViewPager(frame: self.view.bounds)
        viewPager.dataSource = self
        self.view.addSubview(viewPager)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewPagerController: MDCViewPagerDataSource {
    
    public func numberOfPages(inViewPager viewPager: MDCViewPager) -> Int {
        return childViewControllers.count
    }
    
    public func viewPager(_ viewPager: MDCViewPager, viewForAtPage page: Int) -> UIView {
        return childViewControllers[page].view
    }
}
