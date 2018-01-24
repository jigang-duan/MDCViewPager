//
//  RxViewPagerDelegateProxy.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/23.
//

#if os(iOS) || os(tvOS)
    
import RxCocoa
import RxSwift
import UIKit
    
extension Reactive where Base: MDCViewPager {
        
    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<MDCViewPager, MDCViewPagerDelegate> {
        return RxViewPagerDelegateProxy.proxy(for: base)
    }
    
    public var changePage: ControlEvent<Int> {
        let source: Observable<Int> = self.delegate.methodInvoked(#selector(MDCViewPagerDelegate.viewPagerDidChangePage(viewPager:at:)))
            .map { a in
                return try castOrThrow(Int.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
}

#endif

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}
