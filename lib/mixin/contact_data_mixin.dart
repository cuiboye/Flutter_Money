import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/wj_global.dart';
import 'package:permission_handler/permission_handler.dart';

mixin ContactDataMixin{
  Future<bool> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      debugPrint('已经获取权限');
      return true;
    } else {
      _handleInvalidPermissions(permissionStatus);
      return false;
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

  ///联系人列表
  Future<List<Contact?>> getContact() async {
    return await ContactsService.getContacts();
  }

  Future<void> callLog() async {
    // bool hasPermissions = await askPermissions();
    // if (!hasPermissions) {
    //   return;
    // }
    // List<Contact?> contactsList = await getContact();
    // for (var contactPerson in contactsList) {
    //   String phone = '';
    //   if (contactPerson?.phones == null ||
    //       contactPerson?.phones?.isEmpty == true) {
    //     continue;
    //   }
    //   phone = contactPerson?.phones?[0].value ?? '';
    //   if (phone.isEmpty) {
    //     continue;
    //   }
    //
    // //   incoming,
    // // outgoing,
    // // missed,
    // // voiceMail,
    // // rejected,
    // // blocked,
    // // answeredExternally,
    // // unknown,
    // // wifiIncoming,
    // // wifiOutgoing,
    //   // Iterable<CallLogEntry> entries = await CallLog.get();
    //   var now = DateTime.now();
    //   int from = now.subtract(const Duration(days: 720)).millisecondsSinceEpoch;
    //   Iterable<CallLogEntry> entries = await CallLog.query(
    //     dateFrom: from,
    //     dateTo: now.microsecondsSinceEpoch,
    //     durationFrom: -1,
    //     durationTo: 10000,
    //     number: '15000000077',
    //     type: CallType.outgoing,
    //   );
    //   for (var element in entries) {
    //     if(element.number=='15000000077'){
    //       debugPrint('duration=${element.duration},number=${element.number},number=${element.timestamp}');
    //     }
    //   }

    // }
    //通话记录需要手机号
    var now = DateTime.now();
    int from = now.subtract(const Duration(days: 1800)).millisecondsSinceEpoch;
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from,
      dateTo: now.microsecondsSinceEpoch,
      durationFrom: -1,
      durationTo: 10000,
      number: '15000000077',
      type: CallType.outgoing,
    );
    for (var element in entries) {
      if(element.number=='15000000077'){
        debugPrint('duration=${element.duration},number=${element.number},number=${element.timestamp}');
      }
    }
  }
}


