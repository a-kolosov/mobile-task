//
//  EventView.swift
//  MobileTask
//
//  Created by Anton on 26/02/24.
//

import SwiftUI

struct EventItemView: View {
    let title: String
    let location: String
    let date: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            Text(location)
            Text(date)
                .font(Font.subheadline)
            Text(time)
                .font(Font.subheadline)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(title: "", location: "", date: "", time: "")
    }
}
