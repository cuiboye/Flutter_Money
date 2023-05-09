1.Sqflite数据库使用
sqflite是Flutter的SQLite插件，它能在App端能够高效的存储和处理数据库数据，适用于需要查询大量持久化数据的应用。

参考文档：https://liujunmin.com/flutter/database/sqlite.html
1）打开数据库
我们可以通过openDatabase()方式来打开数据库，这里注意一点，当我们打开数据库时如果发现数据库文件不存在，那么就会默认创建，iOS的
目录是doucuments，Android是默认的数据库目录。

openDatabase()的构造函数为：
Future<Database> openDatabase(String path,
    {int? version,
    OnDatabaseConfigureFn? onConfigure,
    OnDatabaseCreateFn? onCreate,
    OnDatabaseVersionChangeFn? onUpgrade,
    OnDatabaseVersionChangeFn? onDowngrade,
    OnDatabaseOpenFn? onOpen,
    bool readOnly = false,
    bool singleInstance = true}) {
  final options = OpenDatabaseOptions(
      version: version,
      onConfigure: onConfigure,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      onDowngrade: onDowngrade,
      onOpen: onOpen,
      readOnly: readOnly,
      singleInstance: singleInstance);
  return databaseFactory.openDatabase(path, options: options);
}
参数说明：
字段	属性	描述
version	int?	数据库的版本号
onConfigure	OnDatabaseConfigureFn?	数据库初始化配置（启用外键、预写日志等）
onCreate	OnDatabaseCreateFn?	数据库不存在时回调，可用于创建所需的表
onUpgrade	OnDatabaseVersionChangeFn?	数据库升级时回调
onDowngrade	OnDatabaseVersionChangeFn?	数据库版本过低，需要更新版本时调用
onOpen	OnDatabaseOpenFn?	打开数据库时回调，在openDatabase返回之前
readOnly	bool	数据库是否只读，默认false
singleInstance	bool	是否返回数据库的路径，默认ture
2）判断数据库是否打开
我们可以通过调用isOpen方法来判断数据库是否被打开。

使用方式
void _isOpenDataBase() async {
    print(database.isOpen);
}
3）关闭数据库
当我们不需要使用数据库的时候，一定要关闭数据库，否则应用程序永远不会关闭，知道应用程序终止时才会关闭。

我们先打开数据库，然后调用_closeDatabase()方法。

使用方式
void _closeDatabase() async {
    print(database.isOpen);
    await database.close();
    print(database.isOpen);
}
4)表操作
方法	         属性	     描述
execute()	Future	执行没有返回值的原始sql语句
insert()	Future	执行sql插入语句，通过Map映射插入
delete()	Future	执行sql删除语句，通过where或者whereArgs
update()	Future	执行sql更新语句，可通过Map映射查询
query()	Future<List<Map<String, Object?»>	执行sql查询语句，以及很方便的对查到的数据进行过滤（分组、排序、限制等）
rawInsert()	Future	执行原始sql插入语句
rawDelete()	Future	执行原始sql删除语句
rawUpdate()	Future	执行原始sql更新语句
rawQuery()	Future<List<Map<String, Object?»>	执行原始sql查询语句
5)创建表
创建表
创建表的方式有两种，一种在打开数据库的时候即创建，还有一种就是通过execute()执行语句来创建，下面我创建了人的表，具体含义如下：

id: 是Dart的int类型，和数据库表中对应的是INTEGER类型，并且我把id设置成了自增以及主键。
name: 是DartString类型，和数据库表中对应的是TEXT类型，存储人的姓名。
age: 是Dart的int类型，和数据库表中对应的是INTEGER类型，存储人的年龄。
使用方法
void _createTable() async {
	database.execute("CREATE TABLE person(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)");
}
6)插入数据
插入数据
插入数据有两种方法，一种通过rawInsert()，还有一种通过insert()，他们实现的原理是一样的，只是insert()使用更方便，下面我们
来看看两种方式：

第一种：rawInsertData()
使用原始sql往person表中增加了一条数据
int result = await database.rawInsert("INSERT INTO person(name, age) values('Jimi', 18)");
第二种：insert()
更优雅的插入方式
int result = await database.insert("person", {
  "name": "是Jimi啊",
  "age": 28
});
7）查询数据
修改数据有两种方法，一种通过rawUpdate()，还有一种通过update()，下面我们来看下这两种方式：
构造函数
Future<List<Map<String, Object?>>> query(String table,
                                         {bool? distinct,
                                          List<String>? columns,
                                          String? where,
                                          List<Object?>? whereArgs,
                                          String? groupBy,
                                          String? having,
                                          String? orderBy,
                                          int? limit,
                                          int? offset});
详细描述
字段	      属性	  描述
table	String	需要查询的表名
distinct	bool?	查询的数据是否重复
columns	List?	需要展示的列
where	String?	查询数据的条件
whereArgs	List<Object?>?	查询条件参数，防止sql注入攻击
groupBy	String?	查询到的数据进行分组
having	String?	给分组设置条件进行过滤
orderBy	String?	数据的排序规则（升序or降序）排列
limit	int?	限定返回的数据数量
offset	int?	跳过几条数据

第一种：rawQuery()
使用原始sql查询person表中的数据。
var list = await database.rawQuery("SELECT * FROM person");

第二种：query()
var list = await database.query("person",);

8）更新数据
修改数据有两种方法，一种通过rawUpdate()，还有一种通过update()，下面我们来看下这两种方式：

第一种：rawUpdate()
使用原始sql更新person表中的数据。

int result = await database.rawUpdate('UPDATE person SET name = "是Jimi哦" where id = 3');
第二种：update()
更优雅的更新方式

int result = await database.update("person", {
  "name": "我是Jimi啊"
}, where: "id = 4");
9）删除表
删除表我们直接使用无返回值的execute()即可。
使用方法
await database.execute("DROP TABLE person");
10)删除数据
删除数据有两种方法，一种通过rawDelete()，还有一种通过delete()，下面我们来看下这两种方式：
第一种：rawDelete()
使用原始sql删除person表中的数据。
int result = await database.rawUpdate('UPDATE person SET name = "是Jimi哦" where id = 3');

第二种：delete()
更优雅的删除方式
int result = await database.delete("person", where: "id = 2");
11)Batch批量处理
批量处理的意思就是多条sql语句进行批量操作，我们可以通过batch来批量操作，等操作完成后使用commit进行提交，代码如下：
var batch = database.batch();
batch.insert("person", {
 "name": "是Jimi啊",
 "age": 28
});
batch.update("person", {
 "name": "我是Jimi啊"
}, where: "id = 2");
var results = await batch.commit();

2.File
https://liujunmin.com/flutter/io/path_provider.html

3.报错解决
1)Execution failed for task ':app:transformClassesAndResourcesWithR8ForRelease'.  
解决方法：#Disables R8 for Android Library modules only.
android.enableR8.libraries = false
#Disables R8 for all modules.
android.enableR8 = false
2)What went wrong:
  Execution failed for task ':app:transformClassesAndResourcesWithProguardForRelease'.
  java.io.IOException: Can't read [/Users/wj/Library/Android/sdk/platforms/android-33/optional/android.car.jar] (Can't process class [android/car/Car$CarServiceLifecycleListener.class] (Unsupported version number [55.0] (maximum 54.0, Java 10)))   
解决方法：报错前app下的build.gradle中的compileSdkVersion为33，改为31就可以了
3)Execution failed for task ':app:transformClassesAndResourcesWithProguardForRelease'.
java.io.IOException: Can't write [/Users/wj/cuiboye/FlutterProject/flutter_money/build/app/intermediates/transforms/proguard/release/0.jar] (Can't read [/Users/wj/cuiboye/FlutterProject/flutter_money/build/app/tmp/kotlin-classes/release(;;;;;;;**.class)] (Can't read [com] (Can't read [example] (Can't read [flutter_money] (Can't read [MainActivity.class] (Duplicate jar entry [com/example/flutter_money/MainActivity.class]))))))
解决办法：在com.example.flutter_money包下存在两个MainActivity，删除那个不是自己创建的就可以
4)如果报kotlin_version相关的报错，解决办法就是将modle和主项目的版本改成一致就可以
4.打包命令
flutter build apk --release --no-sound-null-safety
4.全面屏的适配
1）通过MaterialApp+Scaffold的方式，系统自动为我们适配全面屏的安全区域
2）使用 MediaQuery 来控制距离上下的距离
3）在Android的AndroidManifest中添加设置：
        <meta-data
            android:name="android.max_aspect"
            android:value="2.3" />
5.百度地图
可以参考官方：
https://lbsyun.baidu.com/index.php?title=flutter/loc/create-map/location

6.极光推送
Flutter中的配置：
1）pubspec.yaml中添加：
jpush_flutter: ^2.3.6
2）开启极光推送
JPush jpushTag =  JPush();
jpushTag.setup(
    appKey: '03fe40aece7ccb8a95b48478',
    channel: 'developer-default',
    production: true,
    debug: true);
/// 监听jpush
jpushTag.addEventHandler(
  onReceiveNotification: (Map<String, dynamic> message) async {
    print('jpushTag接收到的数据为： + $message');
    // if (message.length > 0) G.hideMessage = true;
  },
  onOpenNotification: (Map<String, dynamic> message) async {
    /// 点击通知栏消息，跳转至消息列表页面
    // G.hideMessage = true;
    // G.pushNamed('/echo', callback: (val) => false);
  },
);
Android中的配置：
1）AndroidManifest.xml中配置：
<meta-data
    android:name="com.baidu.lbsapi.API_KEY"
    android:value="wZqKbGEtWCYiTGO5YX3CG9PIwXmH3IbR" />
2）app中的build.gradle中的defaultConfig配置：
manifestPlaceholders = [
        JPUSH_PKGNAME: applicationId,
        JPUSH_APPKEY : "03fe40aece7ccb8a95b48478", /*NOTE: JPush 上注册的包名对应的 Appkey.*/
        JPUSH_CHANNEL: "developer-default", /*暂时填写默认值即可.*/
]
3）正式环境记得在配置混淆

7.配置闪屏页
1）pubspec.yaml添加依赖
 flutter_native_splash: ^2.2.8
2)新建flutter_native_splash.yaml
3)运行此包
flutter pub run flutter_native_splash:create
4)还需要对android12进行兼容，这个项目没有做兼容处理
如果闪屏页有问题，可以参考：https://blog.csdn.net/pfourfire/article/details/123115828

Android面试题：
1.启动的4中模式有哪几种
2.如何使用Hanlder
3.使用到的第三方SDK有哪些
4.存储方式有哪几种
5.RecycleView是如何进行缓存的
6.View的加载流程
7.热修复的原理以及双亲委托模式和双亲委托模式的好处
8.App的启动流程是怎样的
9.内存泄漏的场景和解决办法
10.Glide原理以及LRU原理和LinkedHashMap实现


Flutter:
1.Flutter中静态方法如何定义
2.ListView和GridView顶部留有空白的问题是如何解决的
3.Flutter中实现控件权重的方法有哪些
4.GridView是如何自适应布局的
5.XCode怎样实现热重载
6.Flutter安卓端WebView不能正常显示http的图片，如何解决
7.Flutter的屏幕适配是如何实现的
8.Flutter和原生交互的3中方式以及实现原理
9.Dart中的单线程是如何运行的？
10.Flutter中的持久化存储方案有哪些
11.Flutter中的状态管理框架了解哪些，为什么要用状态管理框架，平时工作中使用到了哪个，最好可以聊聊原理
12.Dart中async和await区别
13.Flutter的生命周期有哪几个
14.Future还是isolate场景分析？
    1、如果一段代码不会被中断，那么就直接使用正常的同步执行就行。
    2、如果代码段可以独立运行而不会影响应用程序的流畅性，建议使用 Future  （需要花费几毫秒时间）
    3、如果繁重的处理可能要花一些时间才能完成，而且会影响应用程序的流畅性，建议使用 isolate （需要几百毫秒）
    下面列出一些使用 isolate 的具体场景:
    1、JSON解析: 解码JSON，这是HttpRequest的结果，可能需要一些时间，可以使用封装好的 isolate 的 compute 顶层方法。
    2、加解密: 加解密过程比较耗时
    3、图片处理: 比如裁剪图片比较耗时
    4、从网络中加载大图
15.级联操作符 .. 和  .
Dart 当中的 「..」意思是 「级联操作符」，为了方便配置而使用。「..」和「.」不同的是 调用「..」后返回的
相当于是 this，而「.」返回的则是该方法返回的值 。
16.??=和??    
String? name;
name ??= "lisi";//当且仅当name为null时才赋值
var result = name ?? "zhangsan";//name不为空返回name的值，name为空返回"zhangsan"


