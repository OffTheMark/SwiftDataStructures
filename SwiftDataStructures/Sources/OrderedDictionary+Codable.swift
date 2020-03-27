//
//  OrderedDictionary+Codable.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: - OrderedDictionary

// MARK: Encodable

extension OrderedDictionary: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        if Key.self == String.self {
            var container = encoder.container(keyedBy: OrderedDictionaryCodingKey.self)
            
            for (key, value) in self {
                let codingKey = OrderedDictionaryCodingKey(stringValue: key as! String)!
                try container.encode(value, forKey: codingKey)
            }
            return
        }
        
        if Key.self == Int.self {
            var container = encoder.container(keyedBy: OrderedDictionaryCodingKey.self)
            
            for (key, value) in self {
                let codingKey = OrderedDictionaryCodingKey(intValue: key as! Int)!
                try container.encode(value, forKey: codingKey)
            }
            return
        }
        
        var container = encoder.unkeyedContainer()
        
        for (key, value) in self {
            try container.encode(key)
            try container.encode(value)
        }
    }
}

// MARK: Decodable

extension OrderedDictionary: Decodable where Key: Decodable, Value: Decodable {
    public init(from decoder: Decoder) throws {
        self.init()
        
        if Key.self == String.self {
            let container = try decoder.container(keyedBy: OrderedDictionaryCodingKey.self)
            
            for key in container.allKeys {
                let value = try container.decode(Value.self, forKey: key)
                let correctKey = key.stringValue as! Key
                self[correctKey] = value
            }
            return
        }
        
        if Key.self == Int.self {
            let container = try decoder.container(keyedBy: OrderedDictionaryCodingKey.self)
            
            for key in container.allKeys {
                guard key.intValue != nil else {
                    var codingPath = decoder.codingPath
                    codingPath.append(key)
                    
                    throw DecodingError.typeMismatch(
                        Int.self,
                        DecodingError.Context(
                            codingPath: codingPath,
                            debugDescription: "Expected Int key but found String key instead."
                        )
                    )
                }
                
                let value = try container.decode(Value.self, forKey: key)
                let correctKey = key.intValue! as! Key
                self[correctKey] = value
            }
            return
        }
        
        var container = try decoder.unkeyedContainer()
        
        if let count = container.count {
            if count.isMultiple(of: 2) == false {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Expected collection of key-value pairs; encountered odd-length array instead.")
                )
            }
        }
        
        while !container.isAtEnd {
            let key = try container.decode(Key.self)
            
            if container.isAtEnd {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Unkeyed container reached end before value in key-value pair."
                    )
                )
            }
            
            let value = try container.decode(Value.self)
            self[key] = value
        }
    }
}

// MARK: - OrderedDictionaryCodingKey

internal struct OrderedDictionaryCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
