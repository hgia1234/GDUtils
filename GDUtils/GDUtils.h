//
//  HTUtils.h
//  HT
//
//  Created by Gia on 1/10/13.
//  Copyright (c) 2013 LibiStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDUtils : NSObject

+ (id) loadNIB:(NSString*)file;
+ (NSString *)hexadecimalStringFromData:(NSData *)data;

+ (NSString *)writePNGImageToDocumentFolder:(UIImage *)image name:(NSString *)name;

+ (NSString *)pathToFileInDocumentFolder:(NSString *)fileName;
+ (NSString *)writeImageToDocumentFolder:(UIImage *)image;
+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name;

+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name type:(NSString *)type;


+ (NSString *)filePathInDocumentFolder:(NSString *)fileName;
+ (NSError *)errorWithDescription:(NSString *)description;

+ (double)milesFromMeters:(double)meters;
+ (double)metersFromMiles:(double)miles;


@end
