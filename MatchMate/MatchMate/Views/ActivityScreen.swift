//
//  ActivityScreen.swift
//  MatchMate
//
//  Created by Ritika Meena on 13/02/25.
//

import Foundation
import SwiftUI
import CoreData

struct ActivityScreen: View {
    @FetchRequest(
        entity: UserAction.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \UserAction.mateID, ascending: true)],
        animation: .default
    ) private var userActions: FetchedResults<UserAction>
    
    var body: some View {
        NavigationView {
            VStack {
                List(userActions, id: \.mateID) { userAction in
                    HStack {
                        if let imageUrl = URL(string: userAction.mateThumbnailImage ?? "") {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(userAction.mateName ?? "Unknown Name")
                                .font(.headline)
                            Text("Age: \(userAction.mateAge)")
                                .font(.subheadline)
                            Text("Address: \(userAction.mateAddress ?? "No Address")")
                                .font(.subheadline)
                            Text(userAction.actionType ? "Liked" : "Disliked")
                                .font(.headline)
                            
                        }
                        .padding(.leading, 10)
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Your Activity")
        }
    }
}
