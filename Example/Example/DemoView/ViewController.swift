//
//  ViewController.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) Vlad Khambir
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addDemoView()
    }
    
    func addDemoView() {
        let childView = DemoViewContoller(rootView: DemoView())
        addChild(childView)
        childView.view.frame = view.frame
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
}

class DemoViewContoller: UIHostingController<DemoView> {}
