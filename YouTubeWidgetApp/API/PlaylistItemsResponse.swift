//
//  PlaylistItemsResponse.swift
//  YouTube Widget
//
//  Created by 坂井勇太朗 on 2024/06/16.
//

struct PlaylistItemsResponse: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let prevPageToken: String?
    let items: [Item]

    struct Item: Codable, Hashable {
        let kind: String
        let etag: String
        let id: String
        let contentDetails: ContentDetails

        struct ContentDetails: Codable, Hashable {
            let videoId: String
            let videoPublishedAt: String

            init(videoId: String, videoPublishedAt: String) {
                self.videoId = videoId
                self.videoPublishedAt = videoPublishedAt
            }

            init(from decoder: any Decoder) throws {
                let container: KeyedDecodingContainer<PlaylistItemsResponse.Item.ContentDetails.CodingKeys> = try decoder.container(keyedBy: PlaylistItemsResponse.Item.ContentDetails.CodingKeys.self)
                self.videoId = try container.decode(String.self, forKey: PlaylistItemsResponse.Item.ContentDetails.CodingKeys.videoId)
                self.videoPublishedAt = try container.decode(String.self, forKey: PlaylistItemsResponse.Item.ContentDetails.CodingKeys.videoPublishedAt)
            }
        }

        init(kind: String, etag: String, id: String, contentDetails: ContentDetails) {
            self.kind = kind
            self.etag = etag
            self.id = id
            self.contentDetails = contentDetails
        }

        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<PlaylistItemsResponse.Item.CodingKeys> = try decoder.container(keyedBy: PlaylistItemsResponse.Item.CodingKeys.self)
            self.kind = try container.decode(String.self, forKey: PlaylistItemsResponse.Item.CodingKeys.kind)
            self.etag = try container.decode(String.self, forKey: PlaylistItemsResponse.Item.CodingKeys.etag)
            self.id = try container.decode(String.self, forKey: PlaylistItemsResponse.Item.CodingKeys.id)
            self.contentDetails = try container.decode(PlaylistItemsResponse.Item.ContentDetails.self, forKey: PlaylistItemsResponse.Item.CodingKeys.contentDetails)
        }
    }

    init(kind: String, etag: String, nextPageToken: String?, prevPageToken: String?, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.prevPageToken = prevPageToken
        self.items = items
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.etag = try container.decode(String.self, forKey: .etag)
        self.nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken)
        self.prevPageToken = try container.decodeIfPresent(String.self, forKey: .prevPageToken)
        self.items = try container.decode([PlaylistItemsResponse.Item].self, forKey: .items)
    }
}
