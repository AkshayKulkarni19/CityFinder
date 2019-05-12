//
//  ParseUtil.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 08/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation

public class ParseUtil {
    
    public static func deserialization<T>(_ type: T.Type,
                                          from data: Data) -> (response: T?, error: Error?) where T: Decodable {
        
        var response: T?
        var err: Error?
        do {
            response = try JSONDecoder().decode(T.self, from: data)
        } catch {
            
            err = error
        }
        
        return (response, err)
    }
}
