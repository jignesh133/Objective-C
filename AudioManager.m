//
//  AudioManager.m
//  audioLibrary
//
//  Created by MCA 2 on 02/04/18.
//  Copyright © 2018 MCA 2. All rights reserved.
//

#import "AudioManager.h"

@implementation AudioManager

+(AudioManager*)Instance {
    static AudioManager* singleton = nil;
    if (singleton == nil)
        singleton = [[AudioManager alloc] init];
    return singleton;
}
/***********************************************************************************************************************************/
// PLAY LOCAL AUDIO FILES
/***********************************************************************************************************************************/
// PLAY LOCAL
-(void)methodPlayLocalAudio:(NSString *)FileName andExtension:(NSString *)ext andRepeat:(BOOL)isRepeat{
        NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:FileName  ofType:ext];
        NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
        musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
        musicPlayer.numberOfLoops = 0;
        [musicPlayer prepareToPlay];
        [musicPlayer play];
}
-(void)methodStopLocalAudio{
    // STOP PLAYER
    if (musicPlayer) {
        [musicPlayer stop];
    }
}
/***********************************************************************************************************************************/
// PLAY URL AUDIO FILES
/***********************************************************************************************************************************/
// PLAY URL
-(void)methodPlayURLAudio:(NSString *)fileurl{

    // CREATE URL
    NSURL *URL = [NSURL URLWithString:fileurl];
    
    if (player != nil)
        [player removeObserver:self forKeyPath:@"status"];
  
    // INIT PLAYER
    player = [[AVPlayer alloc]initWithURL:URL];
    
    // ADD OBSERVER
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
    [player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
}
//***************************************************** AVPLAYER METHODS **************************************************************//
#pragma mark -
#pragma mark - AVPLAYER METHODS
//************************************************************************************************************************************//

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"object %@",object);
    
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (player.status == AVPlayerStatusReadyToPlay) {
            
            [player play];
            
            timer = [[NSTimer alloc] init];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkAudioStarted) userInfo:nil repeats:YES];
            NSLog(@"AVPlayerStatusReadyToPlay");
            
        } else if (player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}
- (void)checkAudioStarted {
    AVPlayerItem *currentItem = player.currentItem;
    NSTimeInterval currentTime = CMTimeGetSeconds(currentItem.currentTime);
    if (currentTime  > 2) {
        [timer invalidate];
    }
}
-(void)methodCloseURLAudio{
    if (player != nil){
        [player pause];
        [player removeObserver:self forKeyPath:@"status"];
    }
}

@end
