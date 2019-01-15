//
//  GoogleDocumentRemoteModel.swift
//  tweet-sentiment
//
//  Created by Bernardo Duarte on 14/01/19.
//  Copyright © 2019 Bernardo Duarte. All rights reserved.
//

import Foundation

struct GoogleDocumentRemoteModel: Encodable {
    let document: GoogleDocumentRemoteModel.Document
    let encodingType: String

    init(document: GoogleDocumentRemoteModel.Document) {
        self.document = document
        self.encodingType = "UTF8"
    }

    struct Document: Encodable {
        let type: String
        let content: String

        init(content: String) {
            self.content = content
            self.type = "PLAIN_TEXT"
        }
    }
}
