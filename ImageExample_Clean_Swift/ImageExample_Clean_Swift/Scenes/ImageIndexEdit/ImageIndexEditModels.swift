//
//  ImageIndexEditModels.swift
//  ImageExample_Clean_Swift
//
//  Created by SHIN YOON AH on 10/1/24.
//  Copyright (c) 2024 SHIN YOON AH. All rights reserved.
//
//

import UIKit

enum ImageIndexEdit {
    
    enum Indexs {
        struct Request {
        }
        struct Response {
            let indexs: [Int]
            let currentIndex: Int
        }
        struct ViewModel {
            let indexs: [String]
            let currentIndex: Int
        }
    }
    
    enum SaveIndex {
        struct Request {
            let index: Int?
        }
        struct Response {
            let index: Int?
        }
        struct ViewModel {
            let index: Int?
        }
    }
}

