//
// Created by zorro on 15/3/7.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+EmojiExtension.h"
#import "MiBook-Swift.h"
#import "EmojiTextAttachment.h"
@implementation NSAttributedString (EmojiExtension)

- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      
                      if (value && [value isKindOfClass:[EmojiTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmojiTextAttachment *) value).emojTag];

                          base += ((EmojiTextAttachment *) value).emojTag.length - 1;
                      }
                  }];
    
    return plainString;
}

@end



@implementation UITextView (ad)

-(void)insertAttach:(EmojiTextAttachment * )att
{
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:att];
    att.emojiSize = CGSizeMake(20, 20);
    NSRange selectedRange = self.selectedRange;
    if (selectedRange.length > 0) {
        [self.textStorage deleteCharactersInRange:selectedRange];
    }
    [self.textStorage insertAttributedString:str atIndex:self.selectedRange.location];
    self.selectedRange = NSMakeRange(self.selectedRange.location+1, 0); // self.textView.selectedRange.length

    [self resetTextStyle];
    
}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, self.textStorage.length);
    
    [self.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    
    [self.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:wholeRange];
}


@end

