//
//  ImageDetailModels.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

enum ImageDetail {
    
    enum Image {
        struct Request {
        }
        struct Response {
            let imageURL: String?
        }
        struct ViewModel {
            let imageURL: String?
        }
    }
    
    enum EditTap {
        struct Request {
        }
        struct Response {
            let row: Int
            let allImageCount: Int
        }
        struct ViewModel {
            let row: Int
            let allImageCount: Int
        }
    }
    
    enum SendIndex {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}

