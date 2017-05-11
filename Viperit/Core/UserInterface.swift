//
//  UserInterface.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

protocol UserInterfaceProtocol {
    var proxyPresenter: Presenter? { get set }
    var proxyDisplayData: DisplayData? { get set }
}


open class UserInterface: UIViewController, UserInterfaceProtocol {
    public var proxyPresenter: Presenter?
    public var proxyDisplayData: DisplayData?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        proxyPresenter?.viewHasLoaded()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        proxyPresenter?.viewIsAboutToAppear()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        proxyPresenter?.viewHasAppeared()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        proxyPresenter?.viewIsAboutToDisappear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        proxyPresenter?.viewHasDisappeared()
    }
}
