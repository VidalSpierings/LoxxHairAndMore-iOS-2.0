//
//  JSONNode.swift
//  JSONNode
//
//  Created by Keith Moon on 09/11/2016.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public enum JSONNode {
    case null
    case string(String)
    case integer(Int)
    case floatingPoint(Double)
    case boolean(Bool)
    indirect case array([JSONNode])
    indirect case dictionary([String: JSONNode])

    public init(JSON: Any) {
        switch JSON {
        case let jsonString as String:
            self = .string(jsonString)
        case let jsonNumber as NSNumber:
            self = JSONNode.nodeRepresentation(fromNumber: jsonNumber)
        case let jsonArray as Array<Any>:
            self = .array(jsonArray.compactMap { JSONNode(JSON: $0) })
        case let jsonDictionary as Dictionary<String, Any>:
            var dictionary = [String: JSONNode]()
            for (key, value) in jsonDictionary {
                dictionary[key] = JSONNode(JSON: value)
            }
            self = .dictionary(dictionary)
        default:
            self = .null
        }
    }

    public init(data: Data) throws {
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        self = JSONNode(JSON: json)
    }
    
    private static func nodeRepresentation(fromNumber number: NSNumber) -> JSONNode {
        
        switch String(cString: number.objCType) {
            
        case String(cString: NSNumber(booleanLiteral: true).objCType):
            
            //
            // Bool types
            //
            
            return .boolean(number.boolValue)
        
            //
            // Int types
            //
            
            // Basic types
        case String(cString: NSNumber(value: Int(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: UInt(3)).objCType):
            return .integer(number.intValue)
            
            // 8 bit types
        case String(cString: NSNumber(value: Int8(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: UInt8(3)).objCType):
            return .integer(number.intValue)
            
            // 16 bit types
        case String(cString: NSNumber(value: Int16(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: UInt16(3)).objCType):
            return .integer(number.intValue)
            
        // 32 bit types
        case String(cString: NSNumber(value: Int32(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: UInt32(3)).objCType):
            return .integer(number.intValue)
            
        // 64 bit types
        case String(cString: NSNumber(value: Int64(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: UInt64(3)).objCType):
            return .integer(number.intValue)
            
        case String(cString: NSNumber(value: INT64_MAX).objCType):
            return .integer(number.intValue)
            
            //
            // Floating Point types
            //
            
        case String(cString: NSNumber(value: Float(3.14)).objCType):
            return .floatingPoint(number.doubleValue)
        
        case String(cString: NSNumber(value: Double(3.14)).objCType):
            return .floatingPoint(number.doubleValue)
            
            //
            // Fallback to Floating Point type
            //
        default:
            return .floatingPoint(number.doubleValue)
        }
    }
}

extension JSONNode: CustomDebugStringConvertible {

    public var debugDescription: String {
        switch self {
        case .string(let stringNode):
            return stringNode

        case .integer(let intNode):
            return String(intNode)

        case .floatingPoint(let doubleNode):
            return String(doubleNode)

        case .boolean(let boolNode):
            return String(boolNode)

        case .array(let arrayNode):
            var returnString = "["
            for node in arrayNode {
                returnString += "\(node.debugDescription), "
            }
            returnString += "]"
            return returnString

        case .dictionary(let dictionaryNode):
            var returnString = "{"
            for (key, value) in dictionaryNode.enumerated() {
                returnString += "\(key): \(value), "
            }
            returnString += "}"
            return returnString

        case .null:
            return "NULL"
        }
    }
}

extension JSONNode {

    public var string: String? {
        guard case .string(let stringValue) = self else { return nil }
        return stringValue
    }

    public var integer: Int? {
        guard case .integer(let intValue) = self else { return nil }
        return intValue
    }

    public var floatingPoint: Double? {
        guard case .floatingPoint(let doubleValue) = self else { return nil }
        return doubleValue
    }

    public var boolean: Bool? {
        guard case .boolean(let boolValue) = self else { return nil }
        return boolValue
    }

    public var array: [JSONNode]? {
        guard case .array(let nodeArray) = self else { return nil }
        return nodeArray
    }

    public var dictionary: [String: JSONNode]? {
        guard case .dictionary(let nodeDictionary) = self else { return nil }
        return nodeDictionary
    }
}

extension JSONNode {

    public subscript(_ index: Int) -> JSONNode {
        get { return array?[index] ?? .null }
    }

    public subscript(_ key: String) -> JSONNode {
        get { return dictionary?[key] ?? .null }
    }
}

extension JSONNode {

    public func serialise() -> Data {
        let unwrappedNode = unwrapped(for: self)
        // We can try! because we know a JSONNode can't be anything other than JSOM serialisable.
        // One of the great things about JSONNode :)
        return try! JSONSerialization.data(withJSONObject: unwrappedNode, options: .prettyPrinted)
    }

    private func unwrapped(for node: JSONNode) -> Any {

        switch node {
        case .string(let stringNode):
            return stringNode

        case .integer(let intNode):
            return intNode

        case .floatingPoint(let doubleNode):
            return doubleNode

        case .boolean(let boolNode):
            return boolNode

        case .array(let arrayNode):
            return unwrappedArray(for: arrayNode)

        case .dictionary(let dictionaryNode):
            return unwrappedDictionary(for: dictionaryNode)

        case .null:
            return NSNull()
        }
    }

    private func unwrappedArray(for nodeArray: [JSONNode]) -> [Any] {
        return nodeArray.map { unwrapped(for: $0) }
    }

    private func unwrappedDictionary(for nodeDictionary: [String: JSONNode]) -> [String: Any] {
        var dictionary = [String: Any]()
        for (key, value) in nodeDictionary {
            dictionary[key] = unwrapped(for: value)
        }
        return dictionary
    }
}

extension JSONNode: Equatable {
    
    public static func ==(lhs: JSONNode, rhs: JSONNode) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.null, .null):
            return true
            
        case (.string(let lhsValue), .string(let rhsValue)):
            return lhsValue == rhsValue
            
        case (.integer(let lhsValue), .integer(let rhsValue)):
            return lhsValue == rhsValue
            
        case (.floatingPoint(let lhsValue), .floatingPoint(let rhsValue)):
            return lhsValue == rhsValue
            
        case (.boolean(let lhsValue), .boolean(let rhsValue)):
            return lhsValue == rhsValue
            
        case (.array(let lhsValue), .array(let rhsValue)):
            return lhsValue == rhsValue
            
        case (.dictionary(let lhsValue), .dictionary(let rhsValue)):
            return lhsValue == rhsValue
            
        default:
            return false
        }
    }
}
