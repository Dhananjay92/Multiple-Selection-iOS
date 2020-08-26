//
//  HeaderLabel.h
//  Samples
//
//  Created on 03/02/16.
//
//

#import <UIKit/UIKit.h>
#import "UIColor+Category.h"

IB_DESIGNABLE

@interface CustomTextField : UITextField
{
    UIImageView *imgViewLeftIcon;
    UIImageView *imgViewRightIcon;
    UIView *viewBottomLine;
    UIView *viewBottomSubLine;
    UILabel *placeHolderLabel;
    BOOL isPersianSelected;
}

@property (nonatomic, assign) IBInspectable BOOL showBottomLine;
@property (nonatomic, assign) IBInspectable BOOL showBottomSubLine;

@property (nonatomic, assign) IBInspectable CGFloat iconMargin;

@property (nonatomic, retain) IBInspectable UIImage *leftIcon;
@property (nonatomic, retain) IBInspectable UIImage *rightIcon;
@property (nonatomic, assign) IBInspectable CGFloat subLineWidth;
@property (nonatomic, retain) IBInspectable UIColor *lineColor;
@property (nonatomic, retain) IBInspectable UIColor *subLineColor;
@property (nonatomic, assign) IBInspectable BOOL enableMaterialPlaceHolder;

@property (nonatomic, retain) IBInspectable UIColor *placeHolderColor;



@end
