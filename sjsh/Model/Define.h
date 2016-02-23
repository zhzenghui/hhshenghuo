//
//  Define.h
//

//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] applicationFrame]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenNavHeight 64


//iPhone5 定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是ios7系统
#define kSystemIsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

#pragma mark---
#pragma mark---font

//定义字体
#define kFontArial24 [UIFont fontWithName:@"Arial" size:24]
#define kFontArial17 [UIFont fontWithName:@"Arial" size:17]
#define kFontArial16 [UIFont fontWithName:@"Arial" size:16]
#define kFontArial15 [UIFont fontWithName:@"Arial" size:15]
#define kFontArial14 [UIFont fontWithName:@"Arial" size:14]
#define kFontArial13 [UIFont fontWithName:@"Arial" size:13]
#define kFontArial12 [UIFont fontWithName:@"Arial" size:12]
#define kFontArial11 [UIFont fontWithName:@"Arial" size:11]
#define kFontArial10 [UIFont fontWithName:@"Arial" size:10]

//定义项目红，绿 两种主基调颜色
//#define kRedColor [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f]
#define kRedColor [UIColor colorWithRed:51/255. green:204/255. blue:204/255. alpha:1]
#define hhRedColor [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:86.0f/255.0f green:193.0f/255.0f blue:61.0f/255.0f alpha:1.0f]
#define kDarkGreenColor [UIColor colorWithRed:113.0f/255.0f green:138.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define kGrayColor  [UIColor colorWithRed:186.0f/255.0f green:189.0f/255.0f blue:196.0f/255.0f alpha:1]
//背景色淡灰色
#define dilutedGrayColor [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]
//字体颜色
#define fontGrayColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]

//字体颜色,淡灰
#define fontDilutedGrayColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
//分割线颜色
#define lineGrayColor [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]


//淮海生活*************************
//字体颜色,蓝色
#define fontBlueWithHH   [UIColor colorWithRed:51/255. green:204/255. blue:204/255. alpha:1]
#define backageBlueWithHH   [UIColor colorWithRed:51/255. green:204/255. blue:204/255. alpha:1]
//分割线颜色
#define lineGrayColorWithHH [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]

#define backageYellowColorWithHH [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:51.0f/255.0f alpha:1.0f]

/* *** DEBUG DEFINE *** */
// 测试用色（正常状态下置0，为透明色）
#if DEBUG
#define TEST_COLOR                                 \
([UIColor colorWithRed:arc4random() % 10 / 10.0f \
green:arc4random() % 10 / 10.0f \
blue:arc4random() % 10 / 10.0f \
alpha:0.8])
#else
#define TEST_COLOR ([UIColor clearColor])
#endif

#define prefix_url     @"http://www.sjsh8.cn/"    //世纪生活
//#define prefix_url     @"http://sjsh.weplays.cn/"   //淮海生活



#define KcheckOutPage       [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/checkout"]

#define kCheckLogin          [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/checkout/islogin"]
//登录
#define kLogin              [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/login"]
//退出
#define kLogout             [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/logout"]

#define kRegister           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/checkphone"]

#define kchekey             [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/chekey"]

#define kCompleteRegister   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/register"]


#define Kupdatepassword     [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/updatepassword"]

#define Kchangepasswd       [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/changepasswd"]

#define Kchangepasswd_get       [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/changepasswd&opasswd=%@&npasswd=%@&cpasswd=%@"]

#define kpassgetyz          [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/passgetyz"]

#define kgetpassword        [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/getpassword"]


#define kaboutmy            [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/aboutmy"]

#define Kcomplaints         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/complaints"]


//&com=%@&nums=%@&username=%@"

#define kCheckQQ            [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/qq_login_callback"]

#define kCheckWX            [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/wx_login_callback"]

#define kthrid_registrt     [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/thrid_registrt"]

#define kthrid_bd           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/thrid_bd"]


//找回密码 发送验证码
#define kgetpassword        [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/getpassword"]

//检测验证码
#define kpassgetyz          [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/passgetyz"]

//修改密码
#define kupdatepassword     [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/updatepassword"]

#define KUserInfo           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/userinfo"]

#define Kupdateinfo         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/updateinfo"]

#define Kupavater           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/upavater"]

#define Kaddress            [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/address"]

#define Kaddaddress         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/addaddress"]

#define Kupdateaddress      [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/updateaddress"]

#define Kdeladdress         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/deladdress"]


#define KMsg                [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/notice"]

#define KdelNotice          [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/delnotice"]

#define KComment            [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/comment"]

#define KGetallvcode        [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/getallvcode"]

#define KSavepo             [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/savepo"]

#define kGetAllcoupon       [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/getallcoupon"]

#define kmypoints           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/mypoints"]


#define kShopcategory       [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/shop/shopcategory&category_id=%@"]

#define kShoplist           [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/shop/shoplist"]

#define kProductList        [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/product/productlist"]

#define kRemarkList         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/shop/commentlist"]

#define kAddComment         [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/shop/addcomment"]

#define kProductview  [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/product/productview&product_id=%@"]

#define kShopDetail   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/shop/shopview"]

#define  kWebDescription [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/product/productdetail&product_id=%@"]

#define kCommentlist  [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/product/commentlist"]

#define kCategory_icon  [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home/category_icon"]

#define kHideColor [NSString stringWithFormat:@"%@%@",prefix_url,@"kHideColor"]





#define showcar    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/showcar"]

#define addtocart    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/addtocart"]

#define cartlist    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/cartlist"]

#define url_order_cartlist    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cartcan/cartlist"]

#define delFromcart [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/del"]

#define url_delnew [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/delnew"]

#define KcartNum    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/getcount"]

#define url_addtocart    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cartcan/addtocart"]

#define KgetOption    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/product/getOption"]

#define Kupdatecart    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/updatecart"]

#define update_nums_byid    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cart/update_nums_byid"]

#define url_update_cart    [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/cartcan/update_nums_byid"]

#define order   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/order"]

#define favorite   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/favorite"]

#define deletefavorite   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/delfavorite"]

#define kaddfavorite [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/addfavorite"]

#define orderinfo   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/orderinfo"]

#define addproductcomment   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/addproductcomment"]

#define Kcoupon   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/coupon"]

#define Kgetjifen  [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/jifen"]


#define Khome   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home"]

#define Kfuwu   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home/fuwu"]

#define index_banner   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home_new/index_banner"]

#define z_banner   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home_new/z_banner"]

#define apppro   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home_new/apppro"]

#define home_icon   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home_new/home_icon"]

#define get_forcoupon   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new/getforcoupon"]

#define use_coupon   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new/usercoupon&counum=%@"]


#define submit_order   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new"]

#define url_submit_order   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new/order_new_quest"]


#define purchase   [NSString stringWithFormat:@"%@%@",prefix_url,@"upmpunionpay/purchase.php?orderNumber=%@&total=%@&desc=%@"]

#define server   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/home_new/fuwu"]

#define getparid   [NSString stringWithFormat:@"%@%@",prefix_url,@"weixinsdk/getparid.php"]

#define unionpay   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order/unionpay&order_id=%@&order_desc=%@"]

#define unionpayByPost   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order/unionpay"]


#define get_garden   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/user/ajax_all_xiaoqu"]

#define get_building   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/user/ajax_all_louhao&xiaoqu=%@"]

#define get_unit   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/user/ajax_all_danyuan&xiaoqu=%@&louhao=%@"]

#define get_room   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/user/ajax_all_fangjian&xiaoqu=%@&louhao=%@&danyuan=%@"]

#define delete_address   [NSString stringWithFormat:@"%@%@",prefix_url,@"http://sjsh8.cn/index.php?route=mobile/user/deladdress_arr&address_ids=%@"]

#define member_index   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/home_new/vip_index"]

#define url_coupon   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/ajax_coupon"]

#define url_delete_order   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new/order_dele"]

#define url_cancel_order   [NSString stringWithFormat:@"%@%@",prefix_url,@"http://sjsh8.cn/index.php?route=mobile/order_new/order_close&order_id=%@"]

#define url_member_detail   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/member_sjsh8"]

#define url_recharge_member   [NSString stringWithFormat:@"%@%@",prefix_url,@"mobile/order_new/user_member_pay?real_name=%@&rephone=%@&payment_cod=%@"]

#define order_pay_second   [NSString stringWithFormat:@"%@%@",prefix_url,@"mobile/order_new/order_pay_second?order_id=%@"]

#define url_productdetail   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/order_new/member_order&order_id=%@"]


#define url_image_submit   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/uploadpic"]

#define url_appraise_submit   [NSString stringWithFormat:@"%@%@",prefix_url,@"index.php?route=mobile/user/send_review"]

#define url_commodity_search   [NSString stringWithFormat:@"%@%@",prefix_url,@"?route=mobile/product/serch_product"]

