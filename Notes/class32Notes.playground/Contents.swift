
import UIKit


                        ////// CLASS 32 \\\\\\
                        ////// 11/29/16 \\\\\\




/*
 #NOTES:
 
 
 *** UIDatePicker ***
 
** Intro **
    - can be used as a countdown timer
    - date property returns current selected date
    - supports IBActions that fire off when date selected
    - intrinsic width of 320(can squeeze down to 240)
    - has other options in storyboard attribute inspector
 
 
 
 *** NSDate/NSDateFormatter ***
 
 ** NSDate **
 --> repesntation of a single point in time
    - immutable on creation
    - the standard unit of time for date objects is floating point value typed as NSTimeInterval expressed in seconds
    
    * creating date objects *
        - inut a NSDate instance
        - use class method date() on NSDate
        - use of NSDate's initWithTimeInterval init methods for specific dates creation
        - use an NSCalendar and date components(preferred)
    ** look up date comparisons *****
 
 
 ** NSCalendar **
 --> representation of a particular calendar type
    - use calendar objects to convert b/w times and date components
    - NSCalendar provides an implementation for many difft types of calndars
    - calendar types are specified by constants in NSLocale
    - class method currentCalendar returns the user's preferred locale
    -
 
 ** NSDateCompnents **
 --> representation of particular parts of a date(like h/m/s, day, year, etc.)
    - methods setDay:, setMonth:, setYear: to set those individual components
    - dateByAddingComponents:toDate:options
    - convenience methods
        -- shift based on time zone
        -- 
 
 ** NSDateFormatter **
--> use to get representation of both dates and times
    - set the NSDateFormatterStyle to set your desired style of date (NoStyle, ShortStyle, MediumStyle, LongStyle, FullStyle)
    - Supports custom date formatting/style wi/ setDateFormat: method
    * formats *
        -- yyyy: 2013
        -- yy: 13
        -- MM: 05
        -- MMM: Nov
        -- MMMM: November
        -- dd: 01
        -- EEEE: Friday
        -- EEE: Fri
    EX: EEEE, dd MMMM yyyy ----> Thursday March 7, 2016
 
 ** NSPredicate **
 --> Query language describing how data should be fetched and filtered
    - Describes ligic conditions to use when searching collections
    - Used in CD, but can also be used to filter regular foundation classes like arrays and sets
    * String Syntax *
        - use a predicate string to communicate to the the DB what exactly tou are looking for
        - string parser is whitespace insensitive, case insensitive, and supports nested parenthetical expression
        - the parser does not do any semantic type checking, so typos will cause run time errors
        - use predicateWithFormat for building simple predicates
        - you can use %@ to substitute for an object value(usually a string)
        - you can use %K to substitute for an attribute or attributes(via key path)
        *** self can be used in NSPredicates, it refers to each entity you are querying
 
 
 
 */