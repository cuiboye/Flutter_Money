import 'package:azlistview/azlistview.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_money/contact/models.dart';
import 'package:flutter_money/mixin/contact_data_mixin.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

///联系人列表
class ContactListController extends GetxController with ContactDataMixin {
  List<ContactInfo> contacts = [];
  double susItemHeight = 40;

  @override
  void onInit() {
    super.onInit();
    requestContactPermission();
  }

  void requestContactPermission() async {
    bool hasPermissions = await askPermissions();
    if (!hasPermissions) {
      return;
    }
    List<Contact?> contactsList = await getContact();
    for (var contactPerson in contactsList) {
      String phone = '';
      if (contactPerson?.phones != null &&
          contactPerson?.phones?.isNotEmpty == true) {
        phone = contactPerson?.phones?[0].value ?? '';
      } else {
        phone = '未知';
      }
      Map<String, dynamic> json = {
        'name': contactPerson?.displayName,
        'phone': phone
      };
      contacts.add(ContactInfo.fromJson(json));
    }
    _handleList(contacts);
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contacts);
    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contacts);
    update();
  }
}
