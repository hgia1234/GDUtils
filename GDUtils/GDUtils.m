//
//  HTUtils.m
//  HT
//
//  Created by Gia on 1/10/13.
//  Copyright (c) 2013 LibiStudio. All rights reserved.
//

#import "GDUtils.h"

@implementation GDUtils

+ (id) loadNIB:(NSString*)file {
    NSArray *arr  = [[NSBundle mainBundle] loadNibNamed:file owner:nil options:nil];
    id      ret   = [arr objectAtIndex:0];
    return ret;
}

+ (NSString *)hexadecimalStringFromData:(NSData *)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx",(unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}


+ (NSString *) randomString: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}
+ (NSString *)filePathInDocumentFolder:(NSString *)fileName{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:fileName];
    return imagePath;
}

+ (NSString *)pathToFileInDocumentFolder:(NSString *)fileName{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:fileName];
    return imagePath;
}

+ (NSString *)writePNGImageToDocumentFolder:(UIImage *)image name:(NSString *)name{
    NSData *imageData = UIImagePNGRepresentation(image);
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:name];
    
    [imageData writeToFile:imagePath atomically:YES];
    imageData = nil;
    return imagePath;
}

+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:name];
    
    [imageData writeToFile:imagePath atomically:YES];
    imageData = nil;
    return imagePath;
}


+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name type:(NSString *)type{
    NSData *imageData = nil;
    if ([type isEqualToString:@"png"]) {
        imageData = UIImagePNGRepresentation(image);
    }else{
        imageData = UIImageJPEGRepresentation(image,1);
    }
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:name];
    
    [imageData writeToFile:imagePath atomically:YES];
    imageData = nil;
    return imagePath;
}

+ (NSString *)writeImageToDocumentFolder:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documentPaths[0];
    NSString *imagePath = [documentPath stringByAppendingPathComponent:[self randomString:10]];
    
    [imageData writeToFile:imagePath atomically:YES];
    imageData = nil;
    return imagePath;
}

+ (NSError *)errorWithDescription:(NSString *)description{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description
                                                         forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"app" code:0 userInfo:userInfo];
    return error;
}


+ (double)milesFromMeters:(double)meters{
    return meters * 0.000621371;
}
+ (double)metersFromMiles:(double)miles{
    return miles/0.000621371;
}


@end
