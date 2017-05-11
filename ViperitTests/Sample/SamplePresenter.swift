//
//  SamplePresenter.swift
//  Viperit
//
//  Created by Ferran Abelló on 17/03/2017.
//  Copyright © 2017 Ferran Abelló. All rights reserved.
//

import Foundation
import Viperit

//Public API for Presenter (these methods will be visible from the View)
protocol SamplePresenterInterface {
}

final class SamplePresenter: Presenter {
}

extension SamplePresenter: SamplePresenterInterface {

}

// MARK: - VIPER COMPONENTS API (Auto-generated code)
private extension SamplePresenter {
    var view: SampleViewInterface? {
        return proxyView as? SampleViewInterface
    }
    var interactor: SampleInteractor? {
        return proxyInteractor as? SampleInteractor
    }
    var router: SampleRouter? {
        return proxyRouter as? SampleRouter
    }
}
