//
//  MainViewController.m
//  GLParticles1
//
//  Created by Jesus Magana on 7/18/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import "MainViewController.h"
#import "EmitterTemplate.h"
#import "EmitterShader.h"

@interface MainViewController ()

// Properties
@property (strong) EmitterShader* emitterShader;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up context
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    
    // Set up view
    GLKView* view = (GLKView*)self.view;
    view.context = context;
    
    // Load Shader
    [self loadShader];
    
    // Load Particle System
    [self loadParticles];
    [self loadEmitter];
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // Set the background color (green)
    glClearColor(0.30f, 0.74f, 0.20f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // 1
    // Create Projection Matrix
    float aspectRatio = view.frame.size.width / view.frame.size.height;
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeScale(1.0f, aspectRatio, 1.0f);
    
    // 2
    // Uniforms
    glUniformMatrix4fv(self.emitterShader.uProjectionMatrix, 1, 0, projectionMatrix.m);
    glUniform1f(self.emitterShader.uK, emitter.k);
    
    // 3
    // Attributes
    glEnableVertexAttribArray(self.emitterShader.aTheta);
    glVertexAttribPointer(self.emitterShader.aTheta,                // Set pointer
                          1,                                        // One component per particle
                          GL_FLOAT,                                 // Data is floating point type
                          GL_FALSE,                                 // No fixed point scaling
                          sizeof(Particle),                         // No gaps in data
                          (void*)(offsetof(Particle, theta)));      // Start from "theta" offset within bound buffer
    
    // 4
    // Draw particles
    glDrawArrays(GL_POINTS, 0, NUM_PARTICLES);
    glDisableVertexAttribArray(self.emitterShader.aTheta);
}

- (void)loadParticles
{
    for(int i=0; i<NUM_PARTICLES; i++)
    {
        // Assign each particle its theta value (in radians)
        emitter.particles[i].theta = GLKMathDegreesToRadians(i);
    }
    // Create Vertex Buffer Object (VBO)
    GLuint particleBuffer = 0;
    glGenBuffers(1, &particleBuffer);                   // Generate particle buffer
    glBindBuffer(GL_ARRAY_BUFFER, particleBuffer);      // Bind particle buffer
    glBufferData(                                       // Fill bound buffer with particles
                 GL_ARRAY_BUFFER,                       // Buffer target
                 sizeof(emitter.particles),             // Buffer data size
                 emitter.particles,                     // Buffer data pointer
                 GL_STATIC_DRAW);                       // Usage - Data never changes; used for drawing
}

- (void)loadEmitter
{
    emitter.k = 4.0f;   // Constant k
}

#pragma mark - Load Shader

- (void)loadShader
{
    self.emitterShader = [[EmitterShader alloc] init];
    [self.emitterShader loadShader];
    glUseProgram(self.emitterShader.program);
}

@end