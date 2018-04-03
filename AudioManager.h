//
//  AudioManager.h
//  audioLibrary
//
//  Created by MCA 2 on 02/04/18.
//  Copyright © 2018 MCA 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface AudioManager : NSObject{
    // FOR LOCAL FILES
    AVAudioPlayer *musicPlayer;
    
    // FOR URL FILES
    AVPlayer *player;

    // DECLARE TIMER
    NSTimer *timer;
}

// CREATE SINGLETONE CLASS
+(AudioManager*)Instance;

// DECLARE METHODS
-(void)methodPlayLocalAudio:(NSString *)FileName andExtension:(NSString *)ext andRepeat:(BOOL)isRepeat;
-(void)methodStopLocalAudio;

// DECLARE METHODS FOR URL
-(void)methodPlayURLAudio:(NSString *)fileurl;

@end
