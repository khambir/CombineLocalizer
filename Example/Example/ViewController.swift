//
//  ViewController.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) Vlad Khambir
//

import Combine
import CombineLocalizer
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var localizedLabel: UILabel!
    @IBOutlet weak var localizedLabel2: UILabel!
    
    private var cancellableBag = Set<AnyCancellable>()
    
    let localizer = Localizer.shared
    let viewModel = ViewModel(localizer: Localizer.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.localizedText.map { $0 }
           .assign(to: \.text, on: localizedLabel)
           .store(in: &cancellableBag)
        
        viewModel.localizedText2.map { $0 }
            .assign(to: \.text, on: localizedLabel2)
            .store(in: &cancellableBag)
    }
    
    @IBAction func italianButtonTapped(_ sender: Any) {
        viewModel.changeLanguageTrigger.send(Language.italian.rawValue)
    }
    
    @IBAction func ukraineButtonTapped(_ sender: UIButton) {
        viewModel.changeLanguageTrigger.send(Language.ukrainian.rawValue)
    }
    
    @IBAction func englishButtonTapped(_ sender: UIButton) {
        viewModel.changeLanguageTrigger.send(Language.english.rawValue)
    }
}
