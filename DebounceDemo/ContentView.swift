//
//  ContentView.swift
//  DebounceDemo
//
//  Created by Weerawut Chaiyasomboon on 03/05/2568.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    
    private func performNetworkCall(search: String) async {
        print("Perform Network Call: \(search)")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
    }
    
    var body: some View {
        Form {
            TextField("Search", text: $searchText)
        }
        .debounce(search: searchText) { search in
            await performNetworkCall(search: search)
        }
    }
}

#Preview {
    ContentView()
}

//1.
//if !searchText.isEmpty && searchText.count > 4 {
//    await performNetworkCall(search: searchText)
//}

//2.
//.task(id: searchText) {
//    if !searchText.isEmpty {
//        try? await Task.sleep(for: .seconds(2))
//        guard !Task.isCancelled else { return }
//        await performNetworkCall(search: searchText)
//    }
//}
