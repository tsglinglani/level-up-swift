import Foundation
import UIKit

// What is POP

// Intro

/*
 - new way of looking at tradional OO programming
 - instead of reling on traditional inhertiance for reuse
 - Swift relies more heavily on protocols and extensions
  - this avoids many of the pitfalls that come with traditional OO
  - is safer because avoids mutability
  - more performant because value semantics are used over reference
  - lets dive deeper and see how it works
 */

// The problem with classes
// - implicit sharing (whole mutability problem)
// - deep complex object graphs (show UIKit WWDC bob blog)

class AA {}
class BB: AA {}

// which causes us get very defensive with our codeto:

/*
 Defensive copying
 Inefficiency
 Expense
 Race conditions
 Locks
 More inefficiency tracking locks
 Deadlock
 Complexity
 Bugs!
 */

// Even Apple libraries are affected by this (show WWDC 2015 collections mutability comment)

// So when Chris Lattner and others created Swift, they wanted to get away from all this.
// Wanted a way of sharing code and reused that was
// - safe (value types)
// - fast (highly optimized compiler)
// - easy to use (flat hierarchies over deep)

// What is POP

// POP is how Swift does classical OO inheritance in a performance safe way
// - uses protocols (blue prints) for defining what
// - lets structs and enums implement (the how)
// - enables very fine grained APIs shallow simpler to reason about

// How it works

// Start with a Protocol

protocol Entity {
    var name: String {get set}
    static func uid() -> String
}

// What if we want to define a default implementation? Can't / don't want inheritance.
// Provide default implementation (that all conforming implementations will inherit) via extension

// Provide default implementation via extensions

extension Entity {
    static func uid() -> String {
        return UUID().uuidString
    }
}

// that everyone gets

struct Order: Entity {
    var name: String
    let uid: String = Order.uid()
}
let order = Order(name: "My Order")
print(order.uid)

// Add further requirements by extending existing protocols (Swift version of inheritance).

protocol Persistable: Entity {
    func write(instance: Entity, to filePath: String)
    init?(by uid: String)
}

// Note: You can do this with any type (Int, Double, other library). You don't need the source code.

// Then you only implement what you need - fine grained shallow interfaces

// The whole thing

struct PersistableEntity: Persistable {
    var name: String
    func write(instance: Entity, to filePath: String) {
    }
    init?(by uid: String) {
        // try to load from the filesystem based on id
        name = "Customer"
    }
}

// Just a part

struct InMemoryEntity: Entity {
    var name: String
}

// An example in an App

// Summary

// Swift supports both traditioal OO and Protocol Oriented Programming.
// You are free to choose. Just beaware and start getting comfortable with POP.
// Looks of advantages. Cleaner design. The Swift Way.

// Note: You don't literally need to make everythiung a protocol. Start with structs and enuma and
// implement protocols when you need them.

// But as soon as you feel you need to share implementation across multiple types, think POP.

// Links
// https://developer.apple.com/videos/play/wwdc2015/408/
// https://developer.apple.com/videos/play/wwdc2015/414/
// https://developer.apple.com/videos/play/wwdc2016/419/

// Examples
// https://www.pluralsight.com/guides/protocol-oriented-programming-in-swift


// Arcade

// Work through this...
// https://www.bobthedeveloper.io/blog/protocol-oriented-programming-view-in-swift
// Image OOP
// https://blog.bobthedeveloper.io/introduction-to-protocol-oriented-programming-in-swift-b358fe4974f#.koyj2ap8d