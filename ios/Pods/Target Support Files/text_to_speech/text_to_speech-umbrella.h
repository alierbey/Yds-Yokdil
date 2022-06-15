#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TextToSpeechPlugin.h"

FOUNDATION_EXPORT double text_to_speechVersionNumber;
FOUNDATION_EXPORT const unsigned char text_to_speechVersionString[];

