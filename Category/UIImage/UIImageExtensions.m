//
//  UIImageExtensions.m
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UIImageExtensions.h"

//CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
//CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (CS_Extensions)


//在程序中如何把两张图片合成为一张图片
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
	UIGraphicsBeginImageContext(image1.size);
	
	// Draw image1
	[image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
	
	// Draw image2
	[image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
	
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return resultingImage;
}

-(UIImage *)imageAtRect:(CGRect)rect
{
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage* subImage = [UIImage imageWithCGImage: imageRef];
	CGImageRelease(imageRef);
	
	return subImage;
	
}

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor < heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	//   CGSize imageSize = sourceImage.size;
	//   CGFloat width = imageSize.width;
	//   CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	//   CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	return newImage ;
}

/*
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
	return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	[rotatedViewBox release];
	
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
	
}
*/

- (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize) aSize
{
	CGFloat scale;
	CGSize newsize;
	if(thisSize.width < aSize.width && thisSize.height < aSize.height)
	{
		newsize = thisSize;
	}
	else
	{
		if(thisSize.width >= thisSize.height)
		{
			scale = aSize.width/thisSize.width;
			newsize.width = aSize.width;
			newsize.height = thisSize.height*scale;
		}
		else
		{
			scale = aSize.height/thisSize.height;
			newsize.height = aSize.height;
			newsize.width = thisSize.width*scale;
		}
	}
	return newsize;
}

// Proportionately resize, completely fit in view, no cropping
- (UIImage *)imageFitInSize:(CGSize)viewsize
{
	// calculate the fitted size
	CGSize size = [self fitSize:self.size inSize:viewsize];
	
	UIGraphicsBeginImageContext(size);
	
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newimg;
}



+ (UIImage *)fixOrientation:(UIImage* )aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) { case UIImageOrientationDown: case UIImageOrientationDownMirrored: transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height); transform = CGAffineTransformRotate(transform, M_PI); break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
            
    }
    
    switch (aImage.imageOrientation) { case UIImageOrientationUpMirrored: case UIImageOrientationDownMirrored: transform = CGAffineTransformTranslate(transform, aImage.size.width, 0); transform = CGAffineTransformScale(transform, -1, 1); break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
            
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage)); CGContextConcatCTM(ctx, transform); switch (aImage.imageOrientation) { case UIImageOrientationLeft: case UIImageOrientationLeftMirrored: case UIImageOrientationRight: case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
            
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx); UIImage *img = [UIImage imageWithCGImage:cgimg]; CGContextRelease(ctx); CGImageRelease(cgimg);
    return img;
    
}



@end;



@implementation UIImage(sizeFit)

//thisSize 等比缩放到 aSize的 size
+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize
{
	CGFloat scale;
	CGSize newsize = thisSize;
	
	if (newsize.height && (newsize.height > aSize.height)) {
		scale = aSize.height / newsize.height;
		newsize.width *= scale;
		newsize.height *=scale;
	}
	if (newsize.width && (newsize.width >= aSize.width)) {
		scale = aSize.width / newsize.width;
		newsize.width *= scale;
		newsize.height *= scale;
	}
	return newsize;
}
//
+ (UIImage *)image:(UIImage *)image fitInSize:(CGSize)viewsize
{
	CGSize size = [UIImage fitSize:image.size inSize:viewsize];
	UIGraphicsBeginImageContext(viewsize);
	
	float dwidth = (viewsize.width - size.width) / 2.0f;
	float dheight = (viewsize.height - size.height) / 2.0f;
	
	CGRect rect = CGRectMake(dwidth,dheight,size.width,size.height);
	[image drawInRect:rect];
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
}

//从中心向外延伸截取图片.
+ (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize
{
	CGSize size = image.size;
	UIGraphicsBeginImageContext(viewsize);
	
	float dwidth = (viewsize.width - size.width)/2.0f;
	float dheight = (viewsize.height - size.height)/2.0f;
	CGRect rect = CGRectMake(dwidth,dheight,size.width,size.height);
	[image drawInRect:rect];
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
}
+ (UIImage *)image:(UIImage *)image fillSize:(CGSize)viewsize
{
	CGSize size = image.size;
	
	CGFloat scalex = viewsize.width/size.width;
	CGFloat scaley = viewsize.height / size.height;
	CGFloat scale = MAX(scalex,scaley);
	
	UIGraphicsBeginImageContext(viewsize);
	float width = size.width * scale;
	float height = size.height * scale;
	
	float dwidth = (viewsize.width - width)/2.0f;
	float dheight = (viewsize.height - height)/2.0f;
	CGRect rect = CGRectMake(dwidth,dheight,width,height);
	[image drawInRect:rect];
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
	
}
+ (UIImage *)autoFitImage:(UIImage *)image
{
	CGSize size = image.size;
	CGFloat edge = MIN(size.width,size.height);
	
	UIGraphicsBeginImageContext(CGSizeMake(edge, edge));
	
	float dwidth = edge - size.width;
	float dheight = edge - size.height;
	// UIImageOrientationUp,
	//	UIImageOrientationDown,   // 180 deg rotation
	//	UIImageOrientationLeft,   // 90 deg CCW
	//	UIImageOrientationRight,
	switch (image.imageOrientation) {
		case UIImageOrientationUp:  //正常 left
			dwidth = edge - size.width;
			dheight = edge - size.height;
			break;
		case UIImageOrientationDown: //正常 right
			dwidth = 0;//-(edge - size.width);
			dheight = edge - size.height;
			break;
		case UIImageOrientationLeft: //正常 updown
			dwidth = edge - size.width;
			dheight = 0;//-(edge - size.height);
			break;
		case UIImageOrientationRight: //正常  up
			dwidth = edge - size.width;
			dheight = edge - size.height;
			break;
		default:
			break;
	}
	//NSLog(@"%f %f",dwidth,dheight);
	
	CGRect rect = CGRectMake(dwidth,dheight,size.width,size.height);
	[image drawInRect:rect];
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
}
+ (UIImage *)autoFitFormatImage:(UIImage *)image
{
	CGSize size = image.size;
	CGFloat edge = MIN(size.width,size.height);
	CGFloat scale = 612.0f/edge;
	UIGraphicsBeginImageContext(CGSizeMake(612, 612));
	
	float dwidth = edge - size.width;
	float dheight = edge - size.height;
	switch (image.imageOrientation) {
		case UIImageOrientationUp:  //正常 left
			dwidth = (edge - size.width)*scale;
			dheight = (edge - size.height)*scale;
			break;
		case UIImageOrientationDown: //正常 right
			dwidth = 0;//-(edge - size.width);
			dheight = (edge - size.height)*scale;
			break;
		case UIImageOrientationLeft: //正常 updown
			dwidth = (edge - size.width)*scale;
			dheight = 0;//-(edge - size.height);
			break;
		case UIImageOrientationRight: //正常  up
			dwidth = (edge - size.width)*scale;
			dheight = (edge - size.height)*scale;
			break;
		default:
			break;
	}
	
	CGRect rect = CGRectMake(dwidth,dheight,size.width*scale,size.height*scale);
	[image drawInRect:rect];
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newimg;
}
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
		
		//pop the context to get back to the default
		UIGraphicsEndImageContext();
    return newImage;
}
@end

@implementation UIImage (imageWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //    @autoreleasepool {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    //    }
}
- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 500; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    
    CGFloat destW = bounds.size.width;
    CGFloat destH = bounds.size.height;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imgRef),
                                                4*destW,
                                                CGImageGetColorSpace(imgRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(bitmap, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(bitmap, -height, 0);
        
    }
    else {
        CGContextScaleCTM(bitmap, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(bitmap, 0, -height);
    }
    
    
    CGContextConcatCTM(bitmap, transform);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imgRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 500; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    
    CGFloat destW = bounds.size.width;
    CGFloat destH = bounds.size.height;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imgRef),
                                                4*destW,
                                                CGImageGetColorSpace(imgRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(bitmap, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(bitmap, -height, 0);
        
    }
    else {
        CGContextScaleCTM(bitmap, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(bitmap, 0, -height);
    }
    
    
    CGContextConcatCTM(bitmap, transform);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imgRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}



@end
