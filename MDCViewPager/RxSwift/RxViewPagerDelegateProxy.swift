//
//  RxViewPagerDelegateProxy.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxCocoa

extension MDCViewPager: HasDelegate {
    public typealias Delegate = MDCViewPagerDelegate
}

class RxViewPagerDelegateProxy
    : DelegateProxy<MDCViewPager, MDCViewPagerDelegate>
    , DelegateProxyType
    , MDCViewPagerDelegate {
    
    /// Typed parent object.
    public weak private(set) var viewPager: MDCViewPager?
    
    /// - parameter searchBar: Parent object for delegate proxy.
    public init(viewPager: ParentObject) {
        self.viewPager = viewPager
        super.init(parentObject: viewPager, delegateProxy: RxViewPagerDelegateProxy.self)
    }
    
    // Register known implementations
    static func registerKnownImplementations() {
        self.register { RxViewPagerDelegateProxy(viewPager: $0) }
    }
    
}

#endif
