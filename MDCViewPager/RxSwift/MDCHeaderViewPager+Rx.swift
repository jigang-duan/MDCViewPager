//
//  MDCHeaderViewPager+Rx.swift
//  MDCViewPager
//
//  Created by jigang.duan on 2018/1/24.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: MDCHeaderViewPager {
    
    /// Bindable sink for `dataSouces` property.
    public var dataSouces: Binder<[MDCHeaderViewPager.DataSouce]> {
        return Binder(self.base) { viewPager, data in
            viewPager.dataSouces = data
        }
    }
}
