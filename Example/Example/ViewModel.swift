//
//  ViewModel.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) Vlad Khambir
//

import Combine
import CombineLocalizer

class ViewModel {
    let localizedText: AnyPublisher<String, Never>
    let localizedText2: AnyPublisher<String, Never>
    let changeLanguageTrigger = PassthroughSubject<String, Never>()
    
    private var disposables = Set<AnyCancellable>()
    
    public init(localizer: LocalizerType) {
        localizedText = localizer.localized("testString")
        localizedText2 = localizer.localized("testString2", arguments: "1", "0")
        changeLanguageTrigger.subscribe(localizer.changeLanguage).store(in: &disposables)
    }
}
