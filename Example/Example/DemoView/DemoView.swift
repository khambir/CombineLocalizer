//
//  DemoView.swift
//  Example
//
//  Created by Vladislav on 26.12.2019.
//  Copyright © 2019 MLSDev. All rights reserved.
//

import CombineLocalizer
import SwiftUI

struct DemoView: View {
    @ObservedObject private var viewModel = ViewModel(localizer: Localizer.shared)
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Button(action: {
                    self.viewModel.changeLanguageTrigger.send(Language.ukrainian.rawValue)
                }, label: {
                    Text("Ukraine")
                }).fixedSize(horizontal: true, vertical: false)
                Button(action: {
                    self.viewModel.changeLanguageTrigger.send(Language.italian.rawValue)
                }, label: {
                    Text("Italian")
                }).fixedSize(horizontal: true, vertical: false)
                Button(action: {
                    self.viewModel.changeLanguageTrigger.send(Language.english.rawValue)
                }, label: {
                    Text("English")
                }).fixedSize(horizontal: true, vertical: false)
            }
            
            VStack(spacing: 10) {
                Text(viewModel.localizedText)
                Text(viewModel.localizedText2)
            }
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
