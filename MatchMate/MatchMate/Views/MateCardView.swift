//
//  MateCardView.swift
//  MatchMate
//
//  Created by Ritika Meena on 11/02/25.
//

import Foundation
import SwiftUI
import CoreData

struct MateCardView: View {
    
    var profile: User
    var onAction: () -> Void
    
    var body: some View {
        
        ZStack {
            if let imageUrl = URL(string: profile.picture.large) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 600)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(radius: 5)
                } placeholder: {
                    Color.gray
                        .frame(width: 350, height: 600)
                        .cornerRadius(20)
                }
            }
            
            VStack(spacing: 0){
                Spacer()
                HStack {
                    Text("\(profile.name.first) \(profile.name.last), \(profile.dob.age)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    Spacer()
                }
                .padding(.leading)
                .background(Color.black.opacity(0.5))
                
                HStack{
                    Text("\(profile.location.street.number) - \(profile.location.street.name), \(profile.location.city ), \(profile.location.state ), \(profile.location.country )")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    Spacer()
                }
                .padding(.leading)
                .background(Color.black.opacity(0.5))
                
                HStack {
                    Button(action: {
                        print("\(profile.name.first) disliked")
                        onAction()
                        storeUserAction(action: false)
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("\(profile.name.first) liked")
                        onAction()
                        storeUserAction(action: true)
                    }) {
                        Image(systemName: "heart.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .padding()
                    }
                }
                .background(Color.black.opacity(0.5))
            }
            .cornerRadius(20)
            .frame(width: 350,height: 600)
        }
    }
    
    private func storeUserAction(action: Bool) {
        let context = PersistenceController.shared.viewContext
        
        let userAction = UserAction(context: context)
        userAction.mateName = "\(profile.name.first) \(profile.name.last)"
        userAction.mateAge = Int16(profile.dob.age)
        userAction.mateAddress = "\(profile.location.street.number) - \(profile.location.street.name), \(profile.location.city ), \(profile.location.state ), \(profile.location.country )"
        userAction.mateID = profile.id
        userAction.actionType = action
        userAction.mateThumbnailImage = profile.picture.thumbnail
        
        do {
            try context.save()
            print("Saved \(action) for \(profile.name.first)")
        } catch {
            print("Error saving action: \(error.localizedDescription)")
        }
    }
}
