//
//  ImageCollectionModels.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 9/29/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

enum ImageCollection {
    
    enum PhotoCollection {
        struct Request {
        }
        struct Response {
            let photoURLs: [String]
        }
        struct ViewModel {
            let photoURLs: [String]
        }
    }
    
    enum PhotoCollectionCount {
        struct Request {
            let direction: Direction
            
            enum Direction {
                case left, right
            }
        }
        struct Response {
            let count: Int
        }
        struct ViewModel {
            let count: String
        }
    }
    
    enum PhotoCollectionPage {
        struct Request {
            let width: Double
            let offset: Double
        }
        struct Response {
            let page: Int
        }
        struct ViewModel {
            let page: Int
        }
    }
    
    enum PhotoSection {
        struct Request {
            let row: Int
        }
        struct Response { }
        struct ViewModel { }
    }
}
