//
//  FollowerView.swift
//  GitFollowers
//
//  Created by Ahmed El Gndy on 09/04/2025.
//

import SwiftUI

struct FollowerView: View {
    var follower : Follower
    
    var body: some View {
        
        VStack{
            AsyncImage(url: URL(string: follower.avatar_url)) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                 Image("avatar-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .cornerRadius(10)
            
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "Ahmed", avatar_url: "") )
}
