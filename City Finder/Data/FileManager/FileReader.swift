//
//  FileReader.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 08/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

class FileReader {
    
    public static func getDataFromFile(fileName: String, type: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: type) {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
}
