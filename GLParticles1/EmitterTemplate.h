//
//  EmitterTemplate.h
//  GLParticles1
//
//  Created by Jesus Magana on 7/18/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#define NUM_PARTICLES 360

typedef struct Particle
{
    float       theta;
    float shade[3];
}
Particle;

typedef struct Emitter
{
    Particle    particles[NUM_PARTICLES];
    int         k;
    float color[3];
}
Emitter;

Emitter emitter = {0.0f};