
#import <UIKit/UIKit.h>

typedef enum {
    XMGTopicTypeAll =1,
    XMGTopicTypePicture = 10,
    XMGTopicTypeWord = 29,
    XMGTopicTypeVoice = 31,
    XMGTopicTypeVideo = 41
    
}XMGTopicType;

/**精华 －顶部标题*高*/
UIKIT_EXTERN CGFloat const XMGTitilesViewH ;
/**精华 －顶部标题*Y*/
UIKIT_EXTERN  CGFloat const XMGTitilesViewY ;


/**精华 －cell－的间距 **/
UIKIT_EXTERN CGFloat const XMGTopicCellMargin ;
/**精华 －cell－文字内容的y值 **/
UIKIT_EXTERN CGFloat const XMGTopicCellTextY ;
/**精华 －cell－底部工具条的高度 **/
UIKIT_EXTERN CGFloat const XMGTopicBottomBarH ;


/**精华 －cell－图片帖子最大高度 **/
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH ;
/**精华 －cell－图片帖子一旦超过最大高度，就用break **/
UIKIT_EXTERN CGFloat const XMGTopicCellPictureBreakH;


/**XMGUser模型 － 性别属性值**/
UIKIT_EXTERN NSString *const XMGUserSexMale;
UIKIT_EXTERN NSString *const XMGUserSexFemale;


/**精华 －cell－最热评论标题的高度 **/
UIKIT_EXTERN CGFloat const XMGTopicCellTopCmtTitleH;




