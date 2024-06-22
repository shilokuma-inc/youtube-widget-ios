//
//  ContentView.swift
//  YouTube Widget
//
//  Created by YutaroSakai on 2024/06/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var channelListApi = ChannelListAPI()
    @ObservedObject var playlistItemsApi = PlaylistItemsAPI()

    var body: some View {
        VStack {
            if let response = playlistItemsApi.response {
                List {
                    ForEach(response.items, id: \.self) { item in
                        Text(item.contentDetails.videoPublishedAt)
                            .padding()
                    }
                }
                .frame(height: 450)
                .padding()
            }

            Button(action: {
                self.channelListApi.request()
            }, label: {
                Text("チャンネル情報をリクエスト")
                    .scaledToFit()
            })
            .frame(width: 250, height: 100)
            .padding()

            if let response = channelListApi.response {
                Button(action: {
                    let api = self.playlistItemsApi
                    api.playlistId = response.items.contentDetails.relatedPlaylists.uploads
                    api.request()
                }, label: {
                    Text("再生リストをリクエスト")
                        .scaledToFit()
                })
                .frame(width: 250, height: 100)
                .padding()
            }
        }
    }
}

#Preview {
//    let mockData = ChannelListResponse(kind: "",
//                                       etag: "",
//                                       nextPageToken: nil,
//                                       prevPageToken: nil,
//                                       pageInfo: .init(totalResults: 1, resultsPerPage: 1),
//                                       items: .init(kind: "", etag: "", id: "UCwrVwiJllwhJUKXKmjLcckQ", contentDetails: .init(relatedPlaylists: .init(uploads: "UUwrVwiJllwhJUKXKmjLcckQ"))))
    ContentView()
}
