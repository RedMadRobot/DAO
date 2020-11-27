[![Issues count](https://img.shields.io/github/issues/RedMadRobot/DAO.svg)](https://img.shields.io/github/issues/RedMadRobot/DAO.svg)
[![Cocoapod](https://img.shields.io/badge/pod-1.6.0-blue.svg)](https://img.shields.io/badge/pod-1.6.0-blue.svg)
[![Swift](https://img.shields.io/badge/swift-5.3-red.svg)](https://img.shields.io/badge/swift-5.3-red.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)


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

Carthage

Make the following entry in your Cartfile:

```
github "RedMadRobot/DAO"
```

Then run `carthage update`.

At last, you need to set up your Xcode project manually to add the framework:

1. On “General” settings tab of your target, in the “Linked Frameworks and Libraries” section add each framework you want to use from Carthage/Build folder.

2. On “Build Phases” settings tab of your target, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

```
/usr/local/bin/carthage copy-frameworks
```

3. Add the paths to the frameworks you want to use under “Input Files”:

3.1. For using with CoreData:

```
$(SRCROOT)/Carthage/Build/iOS/CoreDataDAO.framework
```

3.2. Or with Realm:

```
$(SRCROOT)/Carthage/Build/iOS/RealmDAO.framework
```

4. Add the paths to the copied frameworks to the “Output Files”:

4.1. For using with CoreData:

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/CoreDataDAO.framework
```

4.2. Or with Realm

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/RealmDAO.framework
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
- If you want to use specific features of database. Realm Mobile Platform, for instance is not compatible with DAO implementation.
- If you have thousands of objects (> 10-20K). Performance can be the issue.

## Requirements

- Xcode 11
- Swift 5
- iOS 9

## Authors

Ivan Vavilov - iv@redmadrobot.com
