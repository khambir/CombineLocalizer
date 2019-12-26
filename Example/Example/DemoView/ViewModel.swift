//
//  ViewModel.swift
//  Example
//
//  Created by Vladislav Khambir on 9/30/18.
//  Copyright (c) Vlad Khambir
//

import Combine
import CombineLocalizer
import SwiftUI

class ViewModel: ObservableObject {
    @Published var localizedText = ""
    @Published var localizedText2 = ""
    
    let changeLanguageTrigger = PassthroughSubject<String, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    public init(localizer: LocalizerType) {
        localizer.localized("testString")
            .assign(to: \.localizedText, on: self)
            .store(in: &cancellable)
        localizer.localized("testString2", arguments: "1", "0")
            .assign(to: \.localizedText2, on: self)
            .store(in: &cancellable)
        changeLanguageTrigger
            .subscribe(localizer.changeLanguage)
            .store(in: &cancellable)
    }
}
