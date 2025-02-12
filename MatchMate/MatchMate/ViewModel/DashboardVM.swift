//
//  DashboardVM.swift
//  MatchMate
//
//  Created by Ritika Meena on 12/02/25.
//

import Foundation
import Combine

class DashboardVM: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserData() {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                self?.users.append(contentsOf: decodedResponse.results)
            })
            .store(in: &cancellables)
    }
}

