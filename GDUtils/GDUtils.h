//
//  HTUtils.h
//  HT
//
//  Created by Gia on 1/10/13.
//  Copyright (c) 2013 LibiStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef GD_DebugMacro_h
#define GD_DebugMacro_h

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#endif

extern CGRect CGRectSetX(CGRect rect, CGFloat x);
extern CGRect CGRectSetY(CGRect rect, CGFloat y);
extern CGRect CGRectSetWidth(CGRect rect, CGFloat width);
extern CGRect CGRectSetHeight(CGRect rect, CGFloat height);
extern CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
extern CGRect CGRectSetSize(CGRect rect, CGSize size);
extern CGRect CGRectSetZeroOrigin(CGRect rect);
extern CGRect CGRectSetZeroSize(CGRect rect);
extern CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize);
extern CGRect CGRectAddPoint(CGRect rect, CGPoint point);
extern CGPoint CGPointSetX(CGPoint point, CGFloat x);
extern CGPoint CGPointSetY(CGPoint point, CGFloat y);

@interface GDUtils : NSObject

+ (id) loadNIB:(NSString*)file;
+ (NSString *)hexadecimalStringFromData:(NSData *)data;
+ (UIColor *)colorWithHexString:(NSString *)string;
+ (NSString *)writePNGImageToDocumentFolder:(UIImage *)image name:(NSString *)name;

+ (NSString *)pathToFileInDocumentFolder:(NSString *)fileName;
+ (NSString *)writeImageToDocumentFolder:(UIImage *)image;
+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name;

+ (NSString *)writeImageToDocumentFolder:(UIImage *)image name:(NSString *)name type:(NSString *)type;


+ (NSString *)filePathInDocumentFolder:(NSString *)fileName;
+ (NSError *)errorWithDescription:(NSString *)description;

+ (double)milesFromMeters:(double)meters;
+ (double)metersFromMiles:(double)miles;


+ (UITextField *)textField:(UITextField *)textField withPaddingLeft:(CGFloat)paddingLeft;


+ (UIImage *)darkenImage:(UIImage *)image toLevel:(CGFloat)level;
+ (void)showIndicatorImage:(UIImage *)image
                    inView:(UIView *)view
                   timeout:(float)timeout;


+ (void)showErrorAlert:(NSString *)title description:(NSString *)description;

+ (UIImage *)imageForView:(UIView *)view rect:(CGRect)rect;
+ (UIImage *)rotate90DegreeImage:(UIImage *)image multiply:(int)multiply;

+ (CGRect)frameForView:(UIView *)view underView:(UIView *)aboveView;
+ (UIView *)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

+ (CGRect)frameForSuperView:(UIView *)view contentView:(UIView *)contentView insets:(UIEdgeInsets)insets;

+ (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates inView:(UIView *)view;

+ (CGRect)frameForContentView:(UIView *)contentView insets:(UIEdgeInsets)insets;

+ (void)makeView:(UIView *)view leverageWithView:(UIView *)destinationView;

+ (void)setFrameForView:(UIView *)contentView superView:(UIView *)superView insets:(UIEdgeInsets)insets;

+ (UILabel *)setFrameToFit:(UILabel *)label frame:(CGRect)frame;
+ (UILabel *)setFrameToFit:(UILabel *)label width:(float)width;

+ (UITapGestureRecognizer *)addTapForView:(UIView *)view target:(id)target selector:(SEL)selector;
@end
