//
//  PlaylistItemsAPI.swift
//  YouTube Widget
//
//  Created by 坂井勇太朗 on 2024/06/16.
//

import Foundation

class PlaylistItemsAPI: ObservableObject {
    @Published var response: PlaylistItemsResponse?
    var playlistId: String?

    init(playlistId: String? = nil) {
        self.playlistId = playlistId
    }

    func request() {
        guard let playlistId else {
            print("No playlistId passed")
            return
        }

        let requestUrl = URL(string: "https://www.googleapis.com/youtube/v3/channels" + "?part=contentDetails" + "&playlistId=\(playlistId)" + "&key=\(API_KEY)")!

        URLSession.shared.dataTask(with: requestUrl) { data, _, error in
            if let json = data {
                let response: PlaylistItemsResponse

                do {
                    response = try JSONDecoder().decode(PlaylistItemsResponse.self, from: json)
                } catch {
                    print("Json Decode Error")
                    return
                }

                DispatchQueue.main.async {
                    self.response = response
                }
            } else {
                print(error.debugDescription)
            }
        }
        .resume()
    }
}
