//
//  ShaderProcessor.h
//  GLParticles1
//
//  Created by Jesus Magana on 7/18/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface ShaderProcessor : NSObject

- (GLuint)BuildProgram:(const char*)vertexShaderSource with:(const char*)fragmentShaderSource;

@end