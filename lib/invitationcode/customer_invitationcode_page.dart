import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/extension/ext_num.dart';
import 'package:flutter_money/res/res_images.dart';
import 'package:flutter_money/utils/custom_image.dart';
import 'package:flutter_money/utils/repaint_boundary_utils.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/cache_image_view_with_size.dart';
import 'package:flutter_money/widget/custom_divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'customer_invitationcode_controller.dart';

///功能：
///1）对Widget进行截图
///2）保存图片到相册
///3）分享图片到微信，QQ
class CustomerInvitationCodePage extends StatelessWidget {
  static const String path = '/CustomerInvitationCodePage';
  final CustomerInvitationCodeController controller =
      Get.put(CustomerInvitationCodeController());

  CustomerInvitationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.color_ffffff,
      appBar: CustomAppbar(
        context:context,
        title: '客户邀请码',
      ),
      body: GetBuilder<CustomerInvitationCodeController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.w.gapColumn,
              RepaintBoundary(
                  key: boundaryKey,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 50.w, right: 50.w),
                        child: CustomImage(
                          uri: ImageRes.iconInviteCodeBgPNG.full,
                        ),
                      ),
                      Positioned(
                          bottom: 60.w,
                          left: 0,
                          right: 0,
                          child: Column(children: [
                            Text(controller.inviteCode,
                                style: TextStyle(
                                    fontSize: 25.sp, color: ColorConstant.color_ffffff)),
                            10.w.gapColumn,
                            GestureDetector(
                              onTap: ()=>controller.clipboardData(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.w, horizontal: 15.w),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                                child: Text(
                                  '复制',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: ColorConstant.systemColor),
                                ),
                              ),
                            ),
                            CustomImage(
                              uri: ImageRes.iconInviteCodeBgPNG.full,
                              width: 45.w,
                            ),
                          ])),
                    ],
                  )),
              40.w.gapColumn,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () =>controller.savePhoto(),
                    child: Column(
                      children: [
                        CustomImage (
                          uri: ImageRes.iconPicturePNG.full,
                          height: 45.w,
                        ),
                        8.w.gapColumn,
                        Text(
                          '下载图片',
                          style:
                              TextStyle(color: ColorConstant.color_black, fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>controller.shareWechatImage(),
                    child: Column(
                      children: [
                        CustomImage(
                          uri: ImageRes.iconWeChatPNG.full,
                          height: 45.w,
                        ),
                        8.w.gapColumn,
                        Text(
                          '微信',
                          style:
                              TextStyle(color: ColorConstant.color_black, fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: ()=>controller.shareQQImage(),
                    child: Column(
                      children: [
                        CustomImage(
                          uri: ImageRes.iconQqPNG.full,
                          height: 45.w,
                        ),
                        8.w.gapColumn,
                        Text(
                          'QQ',
                          style:
                              TextStyle(color: ColorConstant.color_black, fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              60.w.gapColumn,
              Row(
                children: [
                  15.w.horizontalSpace,
                  const Expanded(
                      child: DividerHorizontal(color: ColorConstant.color_black)),
                  10.w.horizontalSpace,
                  Text(
                    '邀请码规则',
                    style: TextStyle(color: ColorConstant.color_black, fontSize: 13.sp),
                  ),
                  10.w.horizontalSpace,
                  const Expanded(
                      child: DividerHorizontal(color: ColorConstant.color_black)),
                  15.w.horizontalSpace,
                ],
              ),
              15.w.gapColumn,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                // child: const Text('1. 客户使用你的邀请码/二维码，注册成功后可获得80金币'),
                child:  RichText(text: const TextSpan(
                  children: [
                    TextSpan(text: '1. 客户使用你的邀请码/二维码，注册成功后可获得',style: TextStyle(color: ColorConstant.color_black)),
                    TextSpan(text: '80金币',style: TextStyle(color: ColorConstant.color_black)),
                  ]
                ),),
              ),
              8.w.gapColumn,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: const Text('2. 客户注册成功后，可直接进入私海，成为你的客户。',style: TextStyle(color: ColorConstant.color_black)),
              ),
              20.w.gapColumn,
              MediaQuery.paddingOf(context).bottom.gapColumn,
            ],
          ),
        );
      }),
    );
  }
}
