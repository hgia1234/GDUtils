//
//  HTUtils.m
//  HT
//
//  Created by Gia on 1/10/13.
//  Copyright (c) 2013 LibiStudio. All rights reserved.
//

#import "GDUtils.h"
#import <QuartzCore/QuartzCore.h>

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



+ (UITextField *)textField:(UITextField *)textField withPaddingLeft:(CGFloat)paddingLeft{
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  paddingLeft,
                                                                  textField.frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UIImage *)darkenImage:(UIImage *)image toLevel:(CGFloat)level
{
    // Create a temporary view to act as a darkening layer
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    UIView *tempView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor blackColor];
    tempView.alpha = level;
    
    // Draw the image into a new graphics context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:frame];
    
    // Flip the context vertically so we can draw the dark layer via a mask that
    // aligns with the image's alpha pixels (Quartz uses flipped coordinates)
    CGContextTranslateCTM(context, 0, frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, frame, image.CGImage);
    [tempView.layer renderInContext:context];
    
    // Produce a new image from this context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return toReturn;
}

+ (void)showIndicatorImage:(UIImage *)image
                    inView:(UIView *)view
                   timeout:(float)timeout{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageView.center = view.center;
    [view addSubview:imageView];
    
    [UIView animateWithDuration:0.5 delay:timeout options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


+ (void)showFlashingEffectForImage:(UIImage *)image inView:(UIView *)view center:(CGPoint)center{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = center;
    [view addSubview:imageView];
    
}

+ (void)showHeartBeatEffectForView:(UIView *)view
                        completion:(void(^)(void))block{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformScale(view.transform, 2, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            if (block) {
                block();
            }
        }];
        
    }];
}

#pragma mark - drawing

+ (UIImage *)imageForView:(UIView *)view rect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Read the UIImage object
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)rotate90DegreeImage:(UIImage *)image multiply:(int)multiply{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(M_PI_2*multiply);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, M_PI_2*multiply);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2,
                                          -image.size.height / 2,
                                          image.size.width,
                                          image.size.height),
                       [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    //    UIImageOrientation orientation;
    //    if (multiply%4 == 0) {
    //        return image;
    //    }else if (multiply%4 == 1){
    //        orientation = UIImageOrientationLeft;
    //    }else if(multiply%4 == 2){
    //        orientation = UIImageOrientationDown;
    //    }else {
    //        orientation = UIImageOrientationRight;
    //    }
    //    return [[UIImage alloc] initWithCGImage: image.CGImage
    //                               scale: 1.0
    //                         orientation: orientation];
}

+ (void)showErrorAlert:(NSString *)title description:(NSString *)description{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:title
                                    message:description
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles: nil] show];
        
    });
}



#pragma mark - Frame and UIVIew position

+ (UIView *)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
    
    return view;
}

+ (CGRect)frameForView:(UIView *)view underView:(UIView *)aboveView{
    CGRect rect = CGRectMake(view.frame.origin.x,
                             CGRectGetMaxY(aboveView.frame),
                             view.frame.size.width,
                             view.frame.size.height);
    return rect;
}

+ (CGRect)frameForSuperView:(UIView *)view contentView:(UIView *)contentView insets:(UIEdgeInsets)insets{
    CGPoint origin = view.frame.origin;
    float height = contentView.frame.size.height + insets.bottom + insets.top;
    float width = contentView.frame.size.width + insets.left + insets.right;
    CGRect frame = CGRectMake(origin.x, origin.x, width, height);
    return frame;
}

+ (CGRect)frameForContentView:(UIView *)contentView insets:(UIEdgeInsets)insets{
    CGRect frame = CGRectMake(insets.left,
                              insets.top,
                              contentView.frame.size.width,
                              contentView.frame.size.height);
    return frame;
}

+ (void)makeView:(UIView *)view leverageWithView:(UIView *)destinationView{
    CGPoint center = destinationView.center;
    view.center = CGPointMake(view.center.x, center.y);
}

+ (void)setFrameForView:(UIView *)contentView superView:(UIView *)superView insets:(UIEdgeInsets)insets{
    CGRect frameForSuperView = [self frameForSuperView:superView contentView:contentView insets:insets];
    CGRect frameForContentView = [self frameForContentView:contentView insets:insets];
    superView.frame = frameForSuperView;
    contentView.frame = frameForContentView;
}

+ (UILabel *)setFrameToFit:(UILabel *)label frame:(CGRect)frame{
    label.frame = frame;
    [label sizeToFit];
    return label;
}


+ (UILabel *)setFrameToFit:(UILabel *)label width:(float)width{
    label.frame = CGRectSetWidth(label.frame, width);
    [label sizeToFit];
    return label;
}

// Convert from view coordinates to camera coordinates, where {0,0} represents the top left of the picture area, and {1,1} represents
// the bottom right in landscape mode with the home button on the right.
+ (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates inView:(UIView *)view{
    float x = view.frame.size.width - viewCoordinates.x;
    float y =  viewCoordinates.y;
    
    CGPoint interestPoint = CGPointMake(x/view.frame.size.width, y/view.frame.size.height);
    return interestPoint;
}

#pragma mark - action


+ (UITapGestureRecognizer *)addTapForView:(UIView *)view target:(id)target selector:(SEL)selector{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [view addGestureRecognizer:tapGes];
    view.userInteractionEnabled = YES;
    return tapGes;
}

#pragma mark - CGRect

CGRect CGRectSetX(CGRect rect, CGFloat x) {
	return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}


CGRect CGRectSetY(CGRect rect, CGFloat y) {
	return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}


CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
	return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}


CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}


CGRect CGRectSetOrigin(CGRect rect, CGPoint origin) {
	return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}


CGRect CGRectSetSize(CGRect rect, CGSize size) {
	return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}


CGRect CGRectSetZeroOrigin(CGRect rect) {
	return CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height);
}


CGRect CGRectSetZeroSize(CGRect rect) {
	return CGRectMake(rect.origin.x, rect.origin.y, 0.0f, 0.0f);
}



CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize) {
	// Probably a more efficient way to do this...
	CGFloat aspect = 1.0f;
	
	if (size.width > toSize.width) {
		aspect = toSize.width / size.width;
	}
	
	if (size.height > toSize.height) {
		aspect = fminf(toSize.height / size.height, aspect);
	}
	
	return CGSizeMake(size.width * aspect, size.height * aspect);
}


CGRect CGRectAddPoint(CGRect rect, CGPoint point) {
	return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

CGPoint CGPointSetX(CGPoint point, CGFloat x){
    return CGPointMake(x, point.y);
}
CGPoint CGPointSetY(CGPoint point, CGFloat y){
    return CGPointMake(point.x, y);
}




@end
