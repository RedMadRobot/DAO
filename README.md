DAO
=======

An implementation of [DAO pattern](http://www.oracle.com/technetwork/java/dataaccessobject-138824.html) for CoreData and Realm.
Helps you think less about database in your application.

## Features

- Use your persistence layer synchronously for CRUD operations.
- Abstraction of database objects (entries) from application objects (entities).
- Abstraction from concurrency.

## Install

Cocoapods

For using with CoreData:

```ruby
pod 'DAO/CoreData'
```

Or with Realm:

```ruby
pod 'DAO/Realm'
```

## Usage

```swift
// Create DAO instance
let dao = RealmDAO(RLMMessageTranslator())

//...

// Create message entity
let message = Message(entityId: "abc", text: "text")

// Save message to database
try? dao.persist(message)

// Read saved message from database
let savedMessage = dao.read(message.entityId)

// Delete message from database
try? dao.erase(message.entityId)
```

Please look at the example project for more information.

## When not recommended to use

- If you have big and complex database schema. Many entities, many relationships.
- If you want to use many features of database. Realm Mobile Platform, for instance is not comaptible with this implementation.
- If you have thousands of objects (> 10-20K). Performance can be the issue.

## Requirements

- XCode 8
- Swift 3
- iOS 9

## Authors

Ivan Vavilov - iv@redmadrobot.com
