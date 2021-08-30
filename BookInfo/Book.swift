//
//  Book.swift
//  BookInfo
//
//  Created by 深澤佑樹 on 2021/08/28.
//

import Foundation

struct Books: Decodable {
    var items: [BookItem]
}

struct BookItem: Decodable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publishedDate: String
    let pageCount: Int
    let language: String
}
