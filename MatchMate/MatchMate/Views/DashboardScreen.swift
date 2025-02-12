//
//  ContentView.swift
//  MatchMate
//
//  Created by Ritika Meena on 11/02/25.
//

import SwiftUI

struct DashboardScreen: View {
    @StateObject var viewModel = DashboardVM()
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                } else if !viewModel.users.isEmpty {
                    MateCardView(profile: viewModel.users[currentIndex], onAction: handleAction)
                        .transition(.slide)
                } else {
                    Text("No more users.")
                        .font(.title)
                        .onAppear {
                            viewModel.fetchUserData()
                        }
                }
            }
            .navigationTitle("Find Your Match")
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.fetchUserData()
                }
            }
        }
    }
    
    private func handleAction() {
        if currentIndex < viewModel.users.count - 1 {
            withAnimation {
                currentIndex += 1
            }
        } else {
            currentIndex = 0
            viewModel.fetchUserData()
        }
    }
}

