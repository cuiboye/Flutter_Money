
import 'package:azlistview/azlistview.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_money/contact/models.dart';
import 'package:flutter_money/wj_global.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';

///联系人列表
class ContactListController extends GetxController {
  List<ContactInfo> contacts = [];
  double susItemHeight = 40;

  @override
  void onInit() {
    super.onInit();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getContact();
      debugPrint('已经获取权限');
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      //拒绝访问
      showToast('权限已拒绝');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      //永久拒绝访问
      showToast('权限已永久拒绝');

    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<void> getContact() async {
    List<Contact?> contactsList = await ContactsService.getContacts();
    for (var contactPerson in contactsList) {
      String phone = '';
      if(contactPerson?.phones!=null && contactPerson?.phones?.isNotEmpty==true){
        phone = contactPerson?.phones?[0].value??'';
      }else{
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
