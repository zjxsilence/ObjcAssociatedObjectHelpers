//
//  UnitTests.m
//  UnitTests
//
//  Created by jc on 01/10/2012.
//  Copyright (c) 2012 jbsoft. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "TestClass.h"
#import "NSObject+AssociatedDictionary.h"

@interface UnitTests : SenTestCase
@property (strong) TestClass *testClass;
@property (strong) NSObject *dictionaryObject;
@end

@implementation UnitTests

#pragma mark Basic set/get

- (void) testObject
{
    NSBundle *testObject = [[NSBundle alloc] init];
    self.testClass.object = testObject;
    STAssertEquals(self.testClass.object, testObject, @"Didn't return same object");
}

- (void) testPrimitive
{
    NSUInteger value = 99;
    self.testClass.primitive = value;
    STAssertEquals(self.testClass.primitive, value, @"Not the correct value");
}

- (void) testStructure
{
    NSRect rect = NSMakeRect(11, 22, 33, 44);
    self.testClass.structure = rect;
    STAssertTrue(NSEqualRects(self.testClass.structure, rect), @"Returned wrong value");
}

#pragma mark Edge cases

- (void) testMutableObject
{
    NSMutableString *mutable = [NSMutableString stringWithString:@"mutableString"];
    self.testClass.object = mutable;
    STAssertFalse(self.testClass.object == mutable, @"Should have made a copy");
}

- (void) testReadWriteObjectWithCategory
{
    STAssertNotNil(self.testClass.readWriteObject, @"Readwrite object should be created in -init");
}

#pragma mark Associated dictionary

- (void) testInitialize
{
    id dictionary = self.dictionaryObject.associatedDictionary;
    STAssertNotNil(dictionary, @"Dictionary is nil");
    STAssertTrue([dictionary isKindOfClass:[NSMutableDictionary class]], @"Not mutable dictionary");
}

- (void) testSetGet
{
    NSString *key = @"bar";
    NSString *value = @"foo";
    [self.dictionaryObject.associatedDictionary setValue:value forKey:key];
    STAssertEqualObjects([self.dictionaryObject.associatedDictionary valueForKey:key],
                         value,
                         @"Not correct value");
}

#pragma mark -

- (void)setUp
{
    [super setUp];
    self.testClass = [[TestClass alloc] init];
    self.dictionaryObject = [[NSObject alloc] init];
}

- (void)tearDown
{
    self.testClass = nil;
    self.dictionaryObject = nil;
    [super tearDown];
}

@end
