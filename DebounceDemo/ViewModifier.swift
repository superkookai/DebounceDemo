//
//  ViewModifier.swift
//  DebounceDemo
//
//  Created by Weerawut Chaiyasomboon on 03/05/2568.
//

import Foundation
import SwiftUI

struct Debounce: ViewModifier {
    let search: String
    let action: (String) async -> Void
    
    func body(content: Content) -> some View {
        content
            .task(id: search) {
                guard !search.isEmpty else { return }
                try? await Task.sleep(for: .seconds(2))
                guard !Task.isCancelled else { return }
                await action(search)
            }
    }
}

extension View {
    func debounce(search: String, action: @escaping (String) async -> Void) -> some View {
        self.modifier(Debounce(search: search, action: action))
    }
}
