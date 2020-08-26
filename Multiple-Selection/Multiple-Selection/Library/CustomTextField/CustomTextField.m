//
//  HeaderLabel.m
//  Samples
//
//  Created on 03/02/16.
//
//

#import <Multiple_Selection-Swift.h>
#import "CustomTextField.h"

static CGFloat spacing = 5;

@implementation CustomTextField

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedOnce];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initializedOnce];
    }
    return self;
}

- (void) initializedOnce {
    [self setClipsToBounds:FALSE];
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.placeHolderColor = [UIColor colorWithHexString:@"A0A0A0"];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setBorderStyle:UITextBorderStyleNone];
    UIColor *defaultLineColor = [UIColor colorWithHexString:@"ECECEC"];
    UIColor *defaultSubLineColor = [UIColor colorWithHexString:@"ECECEC"];
    CGFloat subLineHeight = 2;
    
    CGSize imageSize = CGSizeMake(20, 20);
    if (self.leftIcon) {
        if(!imgViewLeftIcon) {
            CGFloat xPosission = 0;
            //if ([self isArabic]) {
            //    xPosission = self.width - imageSize.width - spacing;
            //}
            imgViewLeftIcon = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(xPosission, 0), imageSize}];
            [imgViewLeftIcon setCenterY:(self.frame.size.height/2)+(self.iconMargin)];
            [imgViewLeftIcon setContentMode:UIViewContentModeScaleAspectFit];
            [imgViewLeftIcon setClipsToBounds:TRUE];
        }
        [imgViewLeftIcon setImage:self.leftIcon];
        [self addSubview:imgViewLeftIcon];
    }
    else {
        [imgViewLeftIcon removeFromSuperview];
    }
    
    if (self.rightIcon) {
        if(!imgViewRightIcon) {
            CGFloat xPosission = self.frame.size.width - imageSize.width - spacing;
            //  if ([self isArabic]) {
            //      xPosission = 0;
            //  }
            imgViewRightIcon = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(xPosission, 0), imageSize}];
            [imgViewRightIcon setCenterY:(self.frame.size.height/2)+(self.iconMargin)];
            [imgViewRightIcon setContentMode:UIViewContentModeScaleAspectFit];
            [imgViewRightIcon setClipsToBounds:TRUE];
        }
        [imgViewRightIcon setImage:self.rightIcon];
        [self addSubview:imgViewRightIcon];
    }
    else {
        [imgViewRightIcon removeFromSuperview];
    }
    
    if (self.showBottomLine) {
        if(!viewBottomLine) {
            viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - subLineHeight, self.frame.size.width, 1)];
        }
        [viewBottomLine setBackgroundColor:self.lineColor ? : defaultLineColor];
        [self addSubview:viewBottomLine];
    }
    else {
        [viewBottomLine removeFromSuperview];
    }
    
    if (self.showBottomSubLine) {
        if(!viewBottomSubLine) {
            viewBottomSubLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - subLineHeight, self.subLineWidth == 0 ? 30 : self.subLineWidth, subLineHeight)];
        }
        [viewBottomSubLine setBackgroundColor:self.subLineColor ? : defaultSubLineColor];
        [self addSubview:viewBottomSubLine];
    }
    else {
        [viewBottomSubLine removeFromSuperview];
    }
    
    if (self.enableMaterialPlaceHolder) {
        if(!placeHolderLabel) {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }
        if (self.attributedPlaceholder != nil) {
            placeHolderLabel.attributedText = [[NSAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
        }
        placeHolderLabel.font = [UIFont fontWithName:@"MavenPro-Regular" size:14.0];
        placeHolderLabel.alpha = 0;
        [placeHolderLabel sizeToFit];
        if(self.text.length > 0) {
            [self textFieldDidChange:self];
        }
        [self addSubview:placeHolderLabel];
    }
    else {
        [placeHolderLabel removeFromSuperview];
    }
    //[self updateForSelectedLangauge];
}

- (CGRect)rectForBounds:(CGRect)bounds {
    CGRect newBounds = bounds;
    CGFloat totalSpacing = spacing * 2;
    if (_leftIcon && _rightIcon) {
        newBounds.size.width -= (imgViewLeftIcon.frame.size.width + imgViewRightIcon.frame.size.width + totalSpacing + totalSpacing);
        newBounds.origin.x = imgViewLeftIcon.frame.size.width + totalSpacing;
        if(isPersianSelected) {
            placeHolderLabel.x = self.frame.size.width - placeHolderLabel.frame.size.width - (imgViewLeftIcon.frame.size.width + totalSpacing);
        }
        else {
            placeHolderLabel.x = newBounds.origin.x;
        }
    }
    else if(_leftIcon && !_rightIcon) {
        newBounds.size.width -= (imgViewLeftIcon.frame.size.width + totalSpacing);
        
        if(isPersianSelected) {
            newBounds.origin.x = 0;
            placeHolderLabel.x = self.frame.size.width - placeHolderLabel.frame.size.width - (imgViewLeftIcon.frame.size.width + totalSpacing);
        }
        else {
            newBounds.origin.x = imgViewLeftIcon.frame.size.width + totalSpacing;
            placeHolderLabel.x = newBounds.origin.x;
        }
        
    }
    else if(!_leftIcon && _rightIcon) {
        newBounds.size.width -= (imgViewRightIcon.frame.size.width + totalSpacing);
        if(isPersianSelected) {
            newBounds.origin.x = imgViewLeftIcon.frame.size.width + totalSpacing;
            placeHolderLabel.x = self.frame.size.width - placeHolderLabel.frame.size.width - (imgViewLeftIcon.width + totalSpacing);
        }
        else {
            newBounds.origin.x = 0;
            placeHolderLabel.x = newBounds.origin.x;
        }
    }
    return newBounds;
}

#pragma mark -

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    [self setNeedsDisplay];
}

- (void)setShowBottomSubLine:(BOOL)showBottomSubLine {
    _showBottomSubLine = showBottomSubLine;
    [self setNeedsDisplay];
}

- (void)setLeftIcon:(UIImage *)leftIcon {
    _leftIcon = leftIcon;
    [self setNeedsDisplay];
}

- (void)setRightIcon:(UIImage *)rightIcon {
    _rightIcon = rightIcon;
    [self setNeedsDisplay];
}

- (void)setSubLineWidth:(CGFloat)subLineWidth {
    _subLineWidth = subLineWidth;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setSubLineColor:(UIColor *)subLineColor {
    _subLineColor = subLineColor;
    [self setNeedsDisplay];
}

- (void)setEnableMaterialPlaceHolder:(BOOL)enableMaterialPlaceHolder {
    _enableMaterialPlaceHolder = enableMaterialPlaceHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    if([self.placeholder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{ NSForegroundColorAttributeName:placeHolderColor}];
        [self setTintColor:self.textColor];
        [self setAttributedPlaceholder:str];
    }
}

-(void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    NSDictionary *atts = @{NSForegroundColorAttributeName: self.placeHolderColor,
                           NSFontAttributeName : [self.font fontWithSize: self.font.pointSize]};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder ?: @"" attributes: atts];
    [self setEnableMaterialPlaceHolder:self.enableMaterialPlaceHolder];
}

- (IBAction)textFieldDidChange:(id)sender {
    if (self.enableMaterialPlaceHolder) {
        if (!self.text || self.text.length > 0) {
            placeHolderLabel.alpha = 1;
            self.attributedPlaceholder = nil;
        }
        //        else {
        //            self.attributedPlaceholder = nil;
        //        }
        
        CGFloat duration = 0.5;
        CGFloat delay = 0;
        CGFloat damping = 0.6;
        CGFloat velocity = 1;
        
        [UIView animateWithDuration:duration
                              delay:delay
             usingSpringWithDamping:damping
              initialSpringVelocity:velocity
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                
                                if (!self.text || self.text.length <= 0) {
                                    self->placeHolderLabel.centerY = self.height/2;
                                }
                                else {
                                    CGFloat yDisplacement = self->placeHolderLabel.height;
                                    if (yDisplacement < self.height) {
                                        CGFloat margin = self.height - yDisplacement;
                                        yDisplacement -= margin/5;
                                    }
                                    self->placeHolderLabel.y = -yDisplacement;
                                }
                                
                            }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
}

#pragma mark - TextField Overriden Methods

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textFieldDidChange:self];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    [super textRectForBounds:[self rectForBounds:bounds]];
    return [self rectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    [super placeholderRectForBounds:[self rectForBounds:bounds]];
    return [self rectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    [super editingRectForBounds:[self rectForBounds:bounds]];
    return [self rectForBounds:bounds];
}


@end
