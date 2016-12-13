
import UIKit


                        ////// CLASS 31 \\\\\\
                        ////// 11/28/16 \\\\\\



/*
 #NOTES:
 
 
 *** Programmatic Layout ***
 
 - can be more convenient to do in code rather than use a storyboard/nib
 - can although produce more code
 
 ** Setup **
    - delete main.storyboard(and the reference in project settings)
    - override loadView in main viewController
    - instantiate UIWindow
    - set rootViewController on Window
    - ??
 
 * loadView *
    - When you are creating your views programmatically, the proper place to do it is by overriding your view controller’s loadView
    - Create additional subviews and add them to the root view
    - Add any auto layout constraints you need to your view hierarchy
 
 * Auto Layout *
    - can achieve all the same things with auto layout with code as you can w/ storyboard
    - constraints are represented by instances of the NSLayoutConstraint class
    - constraints can be created using VFL
    
    -- Workflow
        - create views that are going to makeup our interface, add them to root view
        - set "translatesAutoSizingMaskIntoConstraints" to false
        - Create a dictionary that will contain key...
        - 
        - Every view in your visual format string is represented in square brackets
        - names of the views come from the dictionary we setup. Dict is passed in as a parameter
        - connections b/w views is represented by a hyphen(or 2 hyphens in b/w)
        - the super view is represented by | pipes
        - can use parens () to set values for fixed width and height
 
 
 *** Relational Databases ***
 
 - make finding specific info faster/easier
 - store info in tables
 - column represents a field(attribute)
 - row represents a record(instance of data)
 
 
 
 *** Core Data ***
 
 --> framework designed to generalize and automate common tasks associated with object life-cycle and persistence
 
 - not a database, is an object graph management and persistence framework that allows you to easily work with a database
 - not just about loading data from a database, also about working with data in memory
 - can manage all of the model layer of your MVC layout
 
 - Apple claims the amount of code you write in your model layer is reduce by 50-70% w/ Core Data...
 - this is simply b/c the features CD provides are features you don't have to implement yourself
 - CD stack contains everything you need to fetch, create, and manipulate managed objects
 
 * NSPersistentStoreCoordinator *
 "NSPSC"
 
 - persists objects to disk, reads objects from disk
 - associates persistent store objects and a managed object model, and presents them to managed object contexts
 - lumps all store objects together, so to the developer it appears as a single store(most apps only need one, but can have more than one)
 - sits b/w managedObjectContext and persistent store (file on disk)
 - Has a reference to the managedObjectModel(MOM)
 - can automatically migrate your existing DB to a new schema
 - used for core data migrations...
 
 ** Managed Object Model (MOM) **
 
 - set of objects that together form a blueprint describing the managed objects you use in your app
 - allows CD to map records from a persistent store to managed objects that you use in your app
 - CD DB schema --> Entitiies(objects), attributes(object properties), relationships, validation(regex for email address), storage rules(separate file for binary data
 - collection of entity objects
 - xcode has a great GUI to do this without any code!
 
    * Entities *
        --> relationship modeling is a way of representing objects typically used to describe data source's data structure in a way that allows data structures to be mapped to objects in and object-oriented system
        - objects that hold data are called entities
        - can use inheritance like classes
        - components of entities are called attributes
    * Attributes *
        --> represent the containment of data
        - can be a simple value
        - CD is specific about what data it accepts, but there are workarounds for storing other values
        -Ints
            -- can be int16, int32, int64
        - double and float numbers
        - decimal for currency
        - binary data for saving instance of NSData
        - transformable for saving instances of classes that can be converted to and from NSData
    * Relationships *
    - Not all properties of an entity are attributes, some are relationships to other entities
    - These relationships are inherently bidirectional, but you can set them to be navigable in only one direction, with no inverse
    - If the destination object is a single entity, its considered a to-one relationship
    - If there may be more than one object, then its a called a to-many relationship
    - Relationships can be optional or required
    - The values of a to one relationship is just the related object, the value of a  to-many in CoreData is an NSSet collection of all related objects
    * Managed Object *
        - an instance of an entity that represents a record from a persistent store
        - takes place of your regular model objects
        - instance of NSManagerObject or a subclass of it
        - every managed object is registered with context
        - in any given context, there is at most one instance of a managed object that corresponds to a given record
        - a managed object has a reference to an entity description object that tells it what entity it represents from the MOM
        ** Custom Managed Object Classes **
            - subclasses tailored to each of your entities
            - NSManagedObject provides a rich set of default behaviors
            - preferred way to create and interact w/ instances of your entities
            - main advantage you get w/ your subclasses are you don't have to call setValue:forKey: anymore
            - instead access attributes from the MOM file as property objects
        ** Lifecycle **
            - CD "owns" the life-cycle of managed objects
        ** NSManaged Object Context **
            - link b/w code and DB
            - represents single object space, or "scratch pad" in a CD app
            - manages a collection of managed objects
            - these objects represent an "internally consistent" view of the persistent store(s)
            - Context is the central object in the core data stack
            - it is connected to the persistent store coordinator
            - every managed object knows the context which it belongs to, evert context knows which object it is managing
    
 * Saving Objects Workflow *
    - get ref to context
    - insert new entity into context
    - set attributes
    - call save on the context, passing in an error pointer
    - check if error pointer isn't nil, and if not, inspect the error description

 * Fetching Objects Workflow
    - Perform fetches with the class NSFetchRequest
    - Specify which entity you are fetching on (can only set one, and this is required)
    - Specify an optional fetch count (default set to fetch all objects)
    - Specify an optional sort descriptor to tell core data how to order the results
    - Specify an optional NSPredicate to specify exactly which objects you want from the entity
 
 * Faulting *
    - Faulting is a mechanism CoreData employs to reduce your applications memory usage
    - A fault is a placeholder object that represents a managed object that has not yet been fully realized, or a collection object that represents a relationship
    - A managed object fault is an instance of the appropriate class, but its persistent variables are not yet initialized
    - A relationship fault is a subclass of the collection class that represents the relationship
    - Fault handling is transparent, the fault is realized only when that variable or relationship is accessed
    - You can turn realized objects back into faults by calling refreshObjects:mergeChanges: method on the context
 
 
 
 
 
 
 
 */










