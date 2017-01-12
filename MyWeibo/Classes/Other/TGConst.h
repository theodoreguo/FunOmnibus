
#import <UIKit/UIKit.h>

// Post type
typedef enum {
    TGPostTypeAll = 1,
    TGPostTypeVideo = 41,
    TGPostTypeAudio = 31,
    TGPostTypePicture = 10,
    TGPostTypeJoke = 29
}TGPostType;

// Essence - Top title bar's height
UIKIT_EXTERN CGFloat const TGTitlesViewH;
// Essence - Top title bar's y value
UIKIT_EXTERN CGFloat const TGTitlesViewY;

// Essence - Cell - Margin
UIKIT_EXTERN CGFloat const TGPostCellMargin;
// Essence - Cell - Content text's y value
UIKIT_EXTERN CGFloat const TGPostCellTextY;
// Essence - Cell - Bottom tool bar's height
UIKIT_EXTERN CGFloat const TGPostCellBottomBarH;

// Essence - Cell - Picture post's max height
UIKIT_EXTERN CGFloat const TGPostCellPictureMaxH;
// Essence - Cell - Picture post's max displayed height when it exceeds stipulated max height
UIKIT_EXTERN CGFloat const TGPostCellPictureMaxDisplayH;

// TGUser model - Sex value
UIKIT_EXTERN NSString * const TGUserSexMale;
UIKIT_EXTERN NSString * const TGUserSexFemale;

// Essence - Cell - Top comment title height
UIKIT_EXTERN CGFloat const TGPostCellTopCmtTitleH;

// Tab bar - The notification sent when the tab bar is selected
UIKIT_EXTERN NSString * const TGTabBarDidSelectNotification;
// Tab bar - The index key of the selected controller
UIKIT_EXTERN NSString * const TGSelectedControllerIndexKey;
// Tab bar - The key of the selected controller
UIKIT_EXTERN NSString * const TGSelectedControllerKey;