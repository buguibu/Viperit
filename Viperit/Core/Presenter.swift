//
//  Presenter.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

public protocol PresenterProtocol {
    var proxyInteractor: Interactor? { get set }
    weak var proxyView: UserInterface? { get set }
    var proxyRouter: Router? { get set }
        
    func setupView(data: Any)
    func viewHasLoaded()
    func viewIsAboutToAppear()
    func viewHasAppeared()
    func viewIsAboutToDisappear()
    func viewHasDisappeared()
}

open class Presenter: PresenterProtocol {
    public var proxyInteractor: Interactor?
    public weak var proxyView: UserInterface?
    public var proxyRouter: Router?
    
    required public init() { }
    
    open func setupView(data: Any) {
        print(ViperitError.methodNotImplemented.description)
    }
    
    open func viewHasLoaded() {}
    open func viewIsAboutToAppear() {}
    open func viewHasAppeared() {}
    open func viewIsAboutToDisappear() {}
    open func viewHasDisappeared() {}
}
