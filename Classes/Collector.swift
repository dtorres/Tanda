//
//  Collector.swift
//  Tanda
//
//  Created by Diego Torres on 13/07/16.
//  Copyright © 2016 Diego Torres. All rights reserved.
//

import Dispatch

public class Collector<Element> {
    private var elements: [Element]!
    #if swift(>=3.0)
    private let serialQueue = DispatchQueue(label: "", attributes: .serial)
    #else
    private let serialQueue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL)
    #endif
    
    public init() {}
    
    public func add(element: Element?) -> AnySequence<Element>? {
        var returnSequence = false
        
        let syncClosure = {
            if self.elements == nil {
                returnSequence = true
                self.elements = []
            }
            if let element = element {
                self.elements.append(element)
            }
        }
        #if swift(>=3.0)
            serialQueue.sync(execute: syncClosure)
        #else
            dispatch_sync(serialQueue, syncClosure)
        #endif
        if !returnSequence {
            return nil
        }
        
        #if swift(>=3.0)
            typealias ReturnedIterator = IndexingIterator<[Element]>
        #else
            typealias ReturnedIterator = IndexingGenerator<[Element]>
        #endif
        var elements: [Element]! = nil
        let closure: () -> ReturnedIterator = {
            if elements != nil {
                return elements.makeIterator()
            }
            let syncClosure = {
                if elements == nil {
                    elements = self.elements
                    self.elements = nil
                }
            }
            #if swift(>=3.0)
                self.serialQueue.sync(execute: syncClosure)
            #else
                dispatch_sync(self.serialQueue, syncClosure)
            #endif
            return elements.makeIterator()
        }
        return AnySequence(closure)
    }
}

#if !swift(>=3.0)
    private extension Array {
        func makeIterator() -> IndexingGenerator<[Element]> {
            return self.generate()
        }
    }
#endif
