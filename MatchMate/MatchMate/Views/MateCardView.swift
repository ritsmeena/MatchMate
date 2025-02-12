//
//  MateCardView.swift
//  MatchMate
//
//  Created by Ritika Meena on 11/02/25.
//

import Foundation
import SwiftUI

struct MateCardView: View {
    
    var profile: User
    var onAction: () -> Void
    
    @State private var offset = CGSize.zero
    
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
                    Text("\(profile.name.first), \(profile.dob.age)")
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
                        resetOffset()
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
                        resetOffset()
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
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        print("\(profile.name.first) liked")
                        onAction()
                    } else if offset.width < -100 {
                        print("\(profile.name.first) disliked")
                        onAction()
                    }
                    resetOffset()
                }
        )
    }
    
    private func resetOffset() {
        offset = .zero
    }
}
