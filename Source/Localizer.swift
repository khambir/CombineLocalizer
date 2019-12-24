//
//  Localizer.swift
//  Localizer
//
//  Created by Vladislav Khambir on 9/8/18.
//  Copyright (c) Vlad Khambir
//

import Combine
import Foundation

public protocol LocalizerType {
    /// The code of the current language (e.g. en, fr, es)
    var currentLanguageCode: AnyPublisher<String?, Never> { get }

    /// The code of the current language (e.g. en, fr, es). Use this value for getting the language in a synchronous code.
    var currentLanguageCodeValue: String? { get }

    /// Trigger which is used for changing current language. Element is a language code (e.g. en, fr, es).
    var changeLanguage: PassthroughSubject<String, Never> { get }

    /// Trigger which is used for changing localizer configuration.
    var changeConfiguration: PassthroughSubject<LocalizerConfig, Never> { get }

    /// Localizes the string, using Combine
    ///
    /// - Parameter string: String which will be localized
    /// - Returns: Localized string
    func localized(_ string: String) -> AnyPublisher<String, Never>

    /// Localizes the string string interpolation, using Combine
    ///
    /// - Parameter string: String which will be localized
    /// - Parameter arguments: String argments which will be interpolated inside localized string
    /// - Returns: Localized string
    func localized(_ string: String, arguments: CVarArg...) -> AnyPublisher<String, Never>

    /// Localizes the string synchronously
    ///
    /// - Parameter string: String which will be localized
    /// - Returns: Localized string
    func localized(_ string: String) -> String

    /// Localizes the string with string interpolation synchronously
    ///
    /// - Parameter string: String which will be localized
    /// - Parameter arguments: String argments which will be interpolated inside localized string
    /// - Returns: Localized string
    func localized(_ string: String, arguments: CVarArg...) -> String

}

public class Localizer: LocalizerType {
    public static let shared: LocalizerType = Localizer()
    
    public let changeLanguage = PassthroughSubject<String, Never>()
    public let changeConfiguration = PassthroughSubject<LocalizerConfig, Never>()
    public let currentLanguageCode: AnyPublisher<String?, Never>
    public private(set) var currentLanguageCodeValue: String?

    private var disposables = Set<AnyCancellable>()
    
    private let localizationBundle = CurrentValueSubject<Bundle, Never>(.main)
    private let configuration = CurrentValueSubject<LocalizerConfig, Never>(LocalizerConfig())

    public func localized(_ string: String) -> AnyPublisher<String, Never> {
        localizationBundle.combineLatest(configuration) {
            $0.localizedString(forKey: string, value: "Unlocalized String", table: $1.tableName)
        }.eraseToAnyPublisher()
    }

    public func localized(_ string: String, arguments: CVarArg...) -> AnyPublisher<String, Never> {
        localizationBundle.combineLatest(configuration) {
            String(format: $0.localizedString(forKey: string, value: "Unlocalized String", table: $1.tableName), arguments: arguments)
        }.eraseToAnyPublisher()
    }

    public func localized(_ string: String) -> String {
        localizationBundle.value.localizedString(forKey: string, value: "Unlocalized String", table: configuration.value.tableName)
    }

    public func localized(_ string: String, arguments: CVarArg...) -> String {
        String(format: localizationBundle.value.localizedString(forKey: string, value: "Unlocalized String", table: configuration.value.tableName), arguments: arguments)
    }

    private init() {
        currentLanguageCode = changeLanguage.removeDuplicates().combineLatest(configuration, { [localizationBundle] languageCode, configuration in
            configuration.defaults.currentLanguage = languageCode
            localizationBundle.send(configuration.bundle.path(forResource: languageCode, ofType: "lproj").flatMap(Bundle.init) ?? localizationBundle.value)
            return languageCode
        }).eraseToAnyPublisher()
        
        currentLanguageCode.sink { [weak self] in self?.currentLanguageCodeValue = $0 }.store(in: &disposables)
        
        if let currentLanguage = configuration.value.defaults.currentLanguage {
            changeLanguage.send(currentLanguage)
        } else {
            let preferredLocalization = configuration.value.bundle.preferredLocalizations.first { $0.count < 3 }
            changeLanguage.send(preferredLocalization ?? Locale.current.languageCode ?? "en")
        }
        changeConfiguration.subscribe(configuration).store(in: &disposables)
    }
}
