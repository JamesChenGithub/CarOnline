//
//  InputPopupContentView.h
//  HKConnect
//
//  Created by James on 4/25/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "PopupView.h"



typedef void (^InputDoneAction)(PopupContentView *pop, NSString *editText);

@interface InputPopupContentView : PopupContentView<UITextFieldDelegate>
{
@private
    UILabel         *_title;
    UIImageView     *_line;
    
    UITextField     *_edit;
    
    UIImageView     *_bottomLine;
    MenuButton      *_cancelButton;
    UIImageView     *_splitLine;
    MenuButton      *_doneButton;
    BOOL            _hasOffset;
    
    InputDoneAction _doneAction;
}

@property (nonatomic, readonly) UITextField *edit;

- (instancetype)initWith:(NSString *)title editText:(NSString *)edit doneAction:(InputDoneAction)doneAction;

@end
