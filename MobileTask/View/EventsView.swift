//
//  ContentView.swift
//  MobileTask
//
//  Created by Anton on 21/02/24.
//

import SwiftUI

struct EventsView: View {
    @StateObject var viewModel: EventsViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.fetchEvents)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(title: error.localizedDescription) {
                viewModel.fetchEvents()
            }
        case .loaded(let events):
            List(events) { event in
                EventItemView(title: viewModel.eventTitle(for: event),
                          location: viewModel.eventLocation(for: event),
                          date: viewModel.eventDate(for: event).date,
                          time: viewModel.eventDate(for: event).time)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemBackground))
                .onTapGesture {
                    viewModel.openEventURL(for: event)
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error"), message: Text("No available info about this event"), dismissButton: .default(Text("Got it!")))
                }
            }
            .refreshable {
                viewModel.fetchEvents()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(viewModel: EventsViewModel(events: [], networkManager: NetworkManager()))
    }
}
