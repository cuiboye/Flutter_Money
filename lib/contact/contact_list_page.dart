import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/contact/contact_list_controller.dart';
import 'package:flutter_money/contact/models.dart';
import 'package:flutter_money/extension/ext_num.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/custom_divider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///手机联系人列表
class ContactListPage extends StatelessWidget {
  static const String path = "/ContactListPage";

  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        context:context,
        title: '联系人列表',
      ),
      body: GetBuilder<ContactListController>(
          init: ContactListController(),
          builder: (controller) {
            return AzListView(
              data: controller.contacts,
              itemCount: controller.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                ContactInfo model = controller.contacts[index];
                return _buildListItem(model);
              },
              indexBarData: SuspensionUtil.getTagIndexList(controller.contacts),
              indexBarItemHeight: 25.w,
              indexBarOptions: IndexBarOptions(
                  textStyle:
                  TextStyle(color: ColorConstant.cab, fontSize: 13.sp)),
              indexHintBuilder: (context, hint) {
                return Container(
                  alignment: Alignment.center,
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[700]!.withAlpha(200),
                    shape: BoxShape.circle,
                  ),
                  child: Text(hint,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 30.0)),
                );
              },
              indexBarMargin: EdgeInsets.all(5.w),
            );
          }),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: model.isShowSuspension == true,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 13.w),
            color: ColorConstant.cee,
            child: Text(
              susTag,
              style: TextStyle(color: ColorConstant.c66, fontSize: 15.sp),
            ),
          ),
        ),
        11.w.gapColumn,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Text(
            model.name,
            style: TextStyle(fontSize: 15.sp, color: ColorConstant.c545759),
          ),
        ),
        5.w.gapColumn,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Text(model.phone?.replaceAll(" ", "") ?? '',
              style: TextStyle(fontSize: 13.sp, color: ColorConstant.cab)),
        ),
        11.w.gapColumn,
        DividerHorizontal(
          height: 1.w,
        )
      ],
    );
  }
}
