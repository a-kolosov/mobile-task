//
//  ErrorView.swift
//  MobileTask
//
//  Created by Anton on 26/02/24.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Text(title)
        Button("Retry") {
            action()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error", action: {})
    }
}
