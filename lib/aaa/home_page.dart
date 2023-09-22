import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_money/aaa/data.dart';
import 'package:flutter_money/aaa/download_list_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:call_log/call_log.dart';

class DownloadFile2 extends StatefulWidget with WidgetsBindingObserver {
  DownloadFile2({super.key, required this.title, required this.platform});

  final TargetPlatform? platform;

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DownloadFile2> {
  List<TaskInfo>? _tasks;
  late List<ItemHolder> _items;
  late bool _showContent;
  late bool _permissionReady;
  late bool _saveInPublicStorage;
  late String _localPath;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();
    _showContent = false;
    _permissionReady = false;
    _saveInPublicStorage = false;

    _prepare();
    getCallLog();
  }

  Future<void> getCallLog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    for (var callLogItem in entries) {
      debugPrint('name=${callLogItem.name},number=${callLogItem.number},duration=${callLogItem.duration}');
    }
    // var now = DateTime.now();
    // int from = now.subtract(const Duration(days: 60)).millisecondsSinceEpoch;
    // int to = now.subtract(const Duration(days: 30)).millisecondsSinceEpoch;
    // Iterable<CallLogEntry> entries = await CallLog.query(
    //   dateFrom: from,
    //   dateTo: to,
    //   durationFrom: 0,
    //   durationTo: 60,
    //   name: 'John Doe',
    //   number: '901700000',
    //   type: CallType.incoming,
    // );
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = DownloadTaskStatus.fromInt(data[1] as int);
      final progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (_tasks != null && _tasks!.isNotEmpty) {
        final task = _tasks!.firstWhere((task) => task.taskId == taskId);
        setState(() {
          task
            ..status = status
            ..progress = progress;
        });
      }

      if (status == DownloadTaskStatus.complete && progress == 100) {
        //下载完成
        FlutterDownloader.open(taskId: taskId);//打开文件
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Widget _buildDownloadList() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        Row(
          children: [
            Checkbox(
              value: _saveInPublicStorage,
              onChanged: (newValue) {
                setState(() => _saveInPublicStorage = newValue ?? false);
              },
            ),
            const Text('Save in public storage'),
          ],
        ),
        ..._items.map(
          (item) {
            final task = item.task;
            if (task == null) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  item.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              );
            }

            return DownloadListItem(
              data: item,
              onTap: (task) async {
                final success = await _openDownloadedFile(task); //打开文件
                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cannot open this file'),
                    ),
                  );
                }
              },
              onActionTap: (task) {
                if (task.status == DownloadTaskStatus.undefined) {
                  debugPrint('aaaaaa');
                  _requestDownload(task); //开始下载
                } else if (task.status == DownloadTaskStatus.running) {
                  _pauseDownload(task);
                  debugPrint('_pauseDownload'); //暂停下载
                } else if (task.status == DownloadTaskStatus.paused) {
                  _resumeDownload(task);
                  debugPrint('_resumeDownload'); //继续下载
                } else if (task.status == DownloadTaskStatus.complete ||
                    task.status == DownloadTaskStatus.canceled) {
                  _delete(task); //下载完成后删除下载了

                  debugPrint('_delete(task)');
                } else if (task.status == DownloadTaskStatus.failed) {
                  debugPrint('_retryDownload');
                  _retryDownload(task);
                }
              },
              onCancel: _delete, //没有完成下载然后取消下载了
            );
          },
        ),
      ],
    );
  }

  Widget _buildNoPermissionWarning() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Grant storage permission to continue',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: _retryRequestPermission,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  Future<void> _requestDownload(TaskInfo task) async {
    debugPrint(' _localPath$_localPath');
    debugPrint('_saveInPublicStorage $_saveInPublicStorage');
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      //下载url
      headers: {'auth': 'test_for_sql_encoding'},
      //headers
      savedDir: _localPath,
      //存储目录，如 /storage/emulated/0/Download
      // savedDir: '/storage/emulated/0/Download',
      showNotification: true,
      //fileName的名称需要后缀，比如apk,jpg等等，否则会出现apk无法解析或者文件打开失败
      fileName: 'wajiucrm${DateTime.now().microsecondsSinceEpoch}.pdf',
      // openFileFromNotification: false,
      //是否在通知栏显示下载进度
      //是否存储在外部目录，在Android上的目录为：/storage/emulated/0/Download
      saveInPublicStorage: true,
    );
  }

  Future<void> _pauseDownload(TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  Future<void> _resumeDownload(TaskInfo task) async {
    debugPrint('_resumeDownload');
    final newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<void> _retryDownload(TaskInfo task) async {
    await [
      Permission.storage,
    ].request();
    final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }

  Future<void> _delete(TaskInfo task) async {
    debugPrint('取消下载');
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    );
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true; //true的话说明已经申请权限
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();
    debugPrint('tasks $tasks');
    if (tasks == null) {
      debugPrint('No tasks were retrieved from the database.');
      return;
    }
    var count = 0;
    _tasks = [];
    _items = [];

    _tasks!.addAll(
      DownloadItems.documents.map(
        (document) => TaskInfo(name: document.name, link: document.url),
      ),
    );

    _items.add(ItemHolder(name: 'Documents'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.images
          .map((image) => TaskInfo(name: image.name, link: image.url)),
    );

    _items.add(ItemHolder(name: 'Images'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.videos
          .map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    _items.add(ItemHolder(name: 'Videos'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    _tasks!.addAll(
      DownloadItems.apks
          .map((video) => TaskInfo(name: video.name, link: video.url)),
    );

    _items.add(ItemHolder(name: 'APKs'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    for (final task in tasks) {
      for (final info in _tasks!) {
        if (info.link == task.url) {
          info
            ..taskId = task.taskId
            ..status = task.status
            ..progress = task.progress;
        }
      }
    }

    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
    }

    setState(() {
      _showContent = true;
    });
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    debugPrint('_localPath $_localPath');
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      // var dir = (await _dirsOnIOS)[0]; // temporary
      // var dir = (await _dirsOnIOS)[1]; // applicationSupport
      // var dir = (await _dirsOnIOS)[2]; // library
      var dir = (await _dirsOnIOS)[3]; // applicationDocuments
      // var dir = (await _dirsOnIOS)[4]; // downloads
      print('failed to get downloads path: $dir');
      dir ??= await getApplicationDocumentsDirectory();
      externalStorageDirPath = dir.absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<List<Directory?>> get _dirsOnIOS async {
    final temporary = await getTemporaryDirectory();
    final applicationSupport = await getApplicationSupportDirectory();
    final library = await getLibraryDirectory();
    final applicationDocuments = await getApplicationDocumentsDirectory();
    final downloads = await getDownloadsDirectory();
    // /var/mobile/Containers/Data/Application/B783CAE6-FBF5-4F84-8ABF-C716FE663D4C/Library/Caches
    debugPrint('temporary: $temporary');
    // /var/mobile/Containers/Data/Application/B783CAE6-FBF5-4F84-8ABF-C716FE663D4C/Library/Application Support
    debugPrint('applicationSupport: $applicationSupport');
    // /var/mobile/Containers/Data/Application/B783CAE6-FBF5-4F84-8ABF-C716FE663D4C/Library
    debugPrint('library: $library');
    // /var/mobile/Containers/Data/Application/B783CAE6-FBF5-4F84-8ABF-C716FE663D4C/Documents
    debugPrint('applicationDocuments: $applicationDocuments');
    // /var/mobile/Containers/Data/Application/B783CAE6-FBF5-4F84-8ABF-C716FE663D4C/Downloads
    debugPrint('downloads: $downloads');

    final dirs = [
      temporary,
      applicationSupport,
      library,
      applicationDocuments,
      downloads
    ];
    debugPrint('9999 $dirs');
    return dirs;
  }

  @override
  Widget build(BuildContext context) {
    int number = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (Platform.isIOS)
            PopupMenuButton<Function>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => exit(0),
                  child: const ListTile(
                    title: Text(
                      'Simulate App Backgrounded',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
      body: Builder(
        builder: (context) {
          if (!_showContent) {
            return const Center(child: CircularProgressIndicator());
          }

          return _permissionReady
              ? _buildDownloadList()
              : _buildNoPermissionWarning();
        },
      ),
    );
  }
}

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;
}

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}
