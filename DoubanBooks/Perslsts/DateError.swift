//
//  DateError.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/12.
//  Copyright © 2019 2017YD. All rights reserved.
//

import Foundation
enum DateError: Error {
    case readCollectionError(String)
    case readSingleError(String)
    case entityExistsError(String)
    case deleteEntityError(String)
    case updateEntityError(String)
}
