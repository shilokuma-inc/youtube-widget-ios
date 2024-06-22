//
//  ChannelListResponse.swift
//  YouTube Widget
//
//  Created by 坂井勇太朗 on 2024/06/16.
//

import Foundation

struct ChannelListResponse: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String?
    let prevPageToken: String?
    let pageInfo: PageInfo
    let items: Items
    
    struct PageInfo: Codable {
        let totalResults: Int
        let resultsPerPage: Int

        init(totalResults: Int, resultsPerPage: Int) {
            self.totalResults = totalResults
            self.resultsPerPage = resultsPerPage
        }

        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<ChannelListResponse.PageInfo.CodingKeys> = try decoder.container(keyedBy: ChannelListResponse.PageInfo.CodingKeys.self)
            self.totalResults = try container.decode(Int.self, forKey: ChannelListResponse.PageInfo.CodingKeys.totalResults)
            self.resultsPerPage = try container.decode(Int.self, forKey: ChannelListResponse.PageInfo.CodingKeys.resultsPerPage)
        }
    }
    
    struct Items: Codable {
        let kind: String
        let etag: String
        let id: String
        let contentDetails: ContentDetails
        
        struct ContentDetails: Codable {
            let relatedPlaylists: RelatedPlaylists

            struct RelatedPlaylists: Codable {
                let uploads: String

                init(uploads: String) {
                    self.uploads = uploads
                }

                init(from decoder: any Decoder) throws {
                    let container: KeyedDecodingContainer<ChannelListResponse.Items.ContentDetails.RelatedPlaylists.CodingKeys> = try decoder.container(keyedBy: ChannelListResponse.Items.ContentDetails.RelatedPlaylists.CodingKeys.self)
                    self.uploads = try container.decode(String.self, forKey: ChannelListResponse.Items.ContentDetails.RelatedPlaylists.CodingKeys.uploads)
                }
            }

            init(relatedPlaylists: RelatedPlaylists) {
                self.relatedPlaylists = relatedPlaylists
            }

            init(from decoder: any Decoder) throws {
                let container: KeyedDecodingContainer<ChannelListResponse.Items.ContentDetails.CodingKeys> = try decoder.container(keyedBy: ChannelListResponse.Items.ContentDetails.CodingKeys.self)
                self.relatedPlaylists = try container.decode(ChannelListResponse.Items.ContentDetails.RelatedPlaylists.self, forKey: ChannelListResponse.Items.ContentDetails.CodingKeys.relatedPlaylists)
            }
        }

        init(kind: String, etag: String, id: String, contentDetails: ContentDetails) {
            self.kind = kind
            self.etag = etag
            self.id = id
            self.contentDetails = contentDetails
        }

        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<ChannelListResponse.Items.CodingKeys> = try decoder.container(keyedBy: ChannelListResponse.Items.CodingKeys.self)
            self.kind = try container.decode(String.self, forKey: ChannelListResponse.Items.CodingKeys.kind)
            self.etag = try container.decode(String.self, forKey: ChannelListResponse.Items.CodingKeys.etag)
            self.id = try container.decode(String.self, forKey: ChannelListResponse.Items.CodingKeys.id)
            self.contentDetails = try container.decode(ChannelListResponse.Items.ContentDetails.self, forKey: ChannelListResponse.Items.CodingKeys.contentDetails)
        }
    }

    init(kind: String, etag: String, nextPageToken: String?, prevPageToken: String?, pageInfo: PageInfo, items: Items) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.prevPageToken = prevPageToken
        self.pageInfo = pageInfo
        self.items = items
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.etag = try container.decode(String.self, forKey: .etag)
        self.nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken)
        self.prevPageToken = try container.decodeIfPresent(String.self, forKey: .prevPageToken)
        self.pageInfo = try container.decode(ChannelListResponse.PageInfo.self, forKey: .pageInfo)
        self.items = try container.decode(ChannelListResponse.Items.self, forKey: .items)
    }
}
