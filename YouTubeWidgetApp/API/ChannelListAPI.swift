//
//  ChannelListAPI.swift
//  YouTube Widget
//
//  Created by 坂井勇太朗 on 2024/06/16.
//

import Foundation

class ChannelListAPI: ObservableObject {
    @Published var response: ChannelListResponse?
    var channelHandle: String

    init(channelHandle: String = "@AppleDeveloper") {
        self.channelHandle = channelHandle
    }

    func request() {
        let requestUrl = URL(string: "https://www.googleapis.com/youtube/v3/channels" + "?part=contentDetails" + "&forHandle=\(channelHandle)" + "&key=\(API_KEY)")!

        URLSession.shared.dataTask(with: requestUrl) { data, _, error in
            if let json = data {
                let response: ChannelListResponse

                do {
                    response = try JSONDecoder().decode(ChannelListResponse.self, from: json)
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
