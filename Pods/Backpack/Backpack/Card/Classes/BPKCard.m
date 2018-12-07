/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "BPKCard.h"

#import <Backpack/Spacing.h>
#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>

NS_ASSUME_NONNULL_BEGIN
const BOOL BPKCardDefaultPaddedValue = YES;

@interface BPKCard()

- (void)setupWithPadded:(BOOL)padded cornerStyle:(BPKCardCornerStyle)cornerStyle;
@property(nonatomic, strong) UIView *innerView;
@end


@implementation BPKCard

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupWithPadded:BPKCardDefaultPaddedValue cornerStyle:BPKCardDefaultCornerStyle];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupWithPadded:BPKCardDefaultPaddedValue cornerStyle:BPKCardDefaultCornerStyle];
    }
    
    return self;
}

- (instancetype)initWithPadded:(BOOL)padded {
    return [self initWithPadded:padded cornerStyle:BPKCardDefaultCornerStyle];
}

- (instancetype)initWithPadded:(BOOL)padded cornerStyle:(BPKCardCornerStyle)cornerStyle {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithPadded:padded cornerStyle:cornerStyle];
    }

    return self;
}

- (void)setPadded:(BOOL)padded {
    if (padded) {
        self.layoutMargins = UIEdgeInsetsMake(BPKSpacingBase, BPKSpacingBase, BPKSpacingBase, BPKSpacingBase);
    } else {
        self.layoutMargins = UIEdgeInsetsZero;
    }

    _padded = padded;
    [self updateCorners];
}

- (void)setCornerStyle:(BPKCardCornerStyle)cornerStyle {
    _cornerStyle = cornerStyle;
    [self updateCorners];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    BPKShadow *shadow = selected ? [BPKShadow shadowLg] : [BPKShadow shadowSm];
    [shadow applyToLayer:self.layer];
}

- (CGSize)intrinsicContentSize {
    if(self.subviews.count < 1) {
        return CGSizeMake(BPKSpacingXxl, BPKSpacingXxl);
    }
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? BPKColor.gray100 : BPKColor.white;
}

- (void)setSubview:(UIView *_Nullable)view {
    if (self.subview != nil) {
        [self.subview removeFromSuperview];
    }
    _subview = view;
    [self.innerView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
                                              [view.leadingAnchor constraintEqualToAnchor:self.innerView.leadingAnchor],
                                              [view.topAnchor constraintEqualToAnchor:self.innerView.topAnchor],
                                              [self.innerView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                              [self.innerView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]
                                              ]];
}

#pragma mark - Private

- (void)setupWithPadded:(BOOL)padded cornerStyle:(BPKCardCornerStyle)cornerStyle {
    self.layer.masksToBounds = NO;
    self.backgroundColor = BPKColor.white;
    [[BPKShadow shadowSm] applyToLayer:self.layer];
    
    self.innerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.innerView.layer.masksToBounds = YES;
    self.innerView.userInteractionEnabled = NO;
    self.padded = padded;
    self.cornerStyle = cornerStyle;
    [super addSubview:self.innerView];
    
    self.innerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.innerView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
                                              [self.innerView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor],
                                              [self.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.innerView.trailingAnchor],
                                              [self.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:self.innerView.bottomAnchor]
                                              ]];
}

- (void)updateCorners {
    CGFloat cornerRadius = 0;

    switch (self.cornerStyle) {
        case BPKCardCornerStyleSmall:
            cornerRadius = BPKBorderRadiusSm;
            break;
        case BPKCardCornerStyleLarge:
            cornerRadius = BPKBorderRadiusLg;
            break;
        default:
            break;
    }

    self.layer.cornerRadius = cornerRadius;

    if (self.isPadded) {
        self.innerView.layer.cornerRadius = 0;
    } else {
        self.innerView.layer.cornerRadius = cornerRadius;
    }
}

@end
NS_ASSUME_NONNULL_END
