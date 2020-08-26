//
//  UIView+Animation.h
//  lama
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 babytree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIViewAnimationFlipDirection)
{
    UIViewAnimationFlipDirectionFromTop,
    UIViewAnimationFlipDirectionFromLeft,
    UIViewAnimationFlipDirectionFromRight,
    UIViewAnimationFlipDirectionFromBottom,
};


/**
 @brief Direction of rotation animation.
 */
typedef NS_ENUM(NSUInteger, UIViewAnimationRotationDirection)
{
    UIViewAnimationRotationDirectionRight,
    UIViewAnimationRotationDirectionLeft
};

@interface UIView (Animation)

#pragma mark -  Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

#pragma mark -  Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

#pragma mark -  Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

#pragma mark -  Effects Alpha
- (void)changeAlpha:(float)newAlpha secs:(float)secs;

// 心跳动画
- (void)heartbeatDuration:(CGFloat)fDuration;
- (void)heartbeatDuration:(CGFloat)fDuration maxSize:(CGFloat)fMaxSize durationPerBeat:(CGFloat)fDurationPerBeat;

#pragma mark - Shake
- (void)shakeDuration:(CGFloat)fDuration;


/**
 @brief Shakes the view horizontally for a short period of time.
 */
- (void)shakeHorizontally;


/**
 @brief Shakes the view vertically for a short period of time.
 */
- (void)shakeVertically;


/**
 @brief Adds a motion effect to the view. Similar effect can be seen in the
 background of the Home Screen on iOS 7.
 @note Motion effects are available starting from iOS 7. Calling this method on
 older iOS will be ignored.
 */
- (void)applyMotionEffects;


/**
 @brief Performs a pulsing scale animation on a view.
 @param duration - duration of the animation
 @param repeat - pass YES for the animation to repeat.
 */
- (void)pulseToSize:(CGFloat)scale
           duration:(NSTimeInterval)duration
             repeat:(BOOL)repeat;


/**
 @brief Performs a 3D-like flip animation of the view around center X or Y axis.
 @param duration - total time of the animation.
 @param direction - direction of the flip movement.
 @param repeatCount - number of repetitions of the animation. Pass HUGE_VALF to repeat forever.
 @param shouldAutoreverse - pass YES to make the animation reverse when it reaches the end.
 */
- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(UIViewAnimationFlipDirection)direction
             repeatCount:(NSUInteger)repeatCount
             autoreverse:(BOOL)shouldAutoreverse;


/**
 @brief Performs a rotation animation of the view around its anchor point.
 @param angle - end angle of the rotation. Pass M_PI * 2.0 for full circle rotation.
 @param duration - total time of the animation.
 @param direction - left or right direction of the rotation.
 @param repeatCount - number of repetitions of the animation. Pass HUGE_VALF to repeat forever.
 @param shouldAutoreverse - pass YES to make the animation reverse when it reaches the end.
 */
- (void)rotateToAngle:(CGFloat)angle
             duration:(NSTimeInterval)duration
            direction:(UIViewAnimationRotationDirection)direction
          repeatCount:(NSUInteger)repeatCount
          autoreverse:(BOOL)shouldAutoreverse;


/**
 @brief Stops current animations.
 */
- (void)stopAnimation;


/**
 @brief Checks if the view is being animated.
 */
- (BOOL)isBeingAnimated;
@end
