//
//  EmitterShader.h
//  GLParticles1
//
//  Created by Jesus Magana on 7/18/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface EmitterShader : NSObject

// Program Handle
@property (readwrite) GLint program;

// Attribute Handles
@property (readwrite) GLint aTheta;

// Uniform Handles
@property (readwrite) GLint uProjectionMatrix;
@property (readwrite) GLint uK;

// Methods
- (void)loadShader;

@end