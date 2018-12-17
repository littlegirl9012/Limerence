//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EmojiTextAttachment.h"
@interface NSAttributedString (EmojiExtension)
- (NSString *)getPlainString;
@end

@interface UITextView (ad)
-(void)insertAttach:(EmojiTextAttachment * )att;
- (void)resetTextStyle ;
@end
