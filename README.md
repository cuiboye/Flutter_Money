[1.Sqflite数据库使用
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


GetX相关：

Getx的优势：
依赖注入：GetX 是通过依赖注入的方式，存储相应的 XxxGetxController；已经脱离了 InheritedWidget 那一套玩法，自己手动去管理这些实例
获取实例无需 BuildContext、GetBuilder 自动化的处理及其减少了入参等等
跨页面交互
GetX可以优雅的实现跨页面交互。
路由管理
Getx 内部实现了路由管理，使用非常简单
GetX 实现了动态路由传参，也就是说直接在命名路由上拼参数，然后能拿到这些拼在路由上的参数
实现了全局 BuildContext
国际化，主题实现

GetX为我们提供了GetxController,GetxController主要的作用是用于UI代码与业务逻辑分离开来。
GetX的使用：
1）依赖注入
依赖注入的目的?
依赖注入是为了将依赖组件的配置和使用分离开，以降低使用者与依赖之间的耦合度。


依赖注入的好处？
重用代码
更容易换掉依赖项的实现。由于控制反转，代码重用得以改进，并且类不再控制其依赖项的创建方式，而是支持任何配置。
易于重构
依赖项的创建分离，可以在创建对象时或编译时进行检查、修改，一处修改，使用处不需修改。
易于测试
类不管理其依赖项，因此在测试时，您可以传入不同的实现以测试所有不同用例。


Get有两个不同的状态管理器：简单的状态管理器（GetBuilder）和响应式状态管理器（GetX）。
GetBuilder是手动控制的状态管理器，不使用ChangeNotifier，状态管理器使用较少的内存（接近0mb）。

Get有一个简单而强大的依赖管理器，它允许你只用1行代码就能检索到 Controller 或者需要依赖的类，不需要提供上下文，不需要
在 inheritedWidget 的子节点。
注入依赖：Get.put<PutController>(PutController());
获取依赖：Get.find<PutController>();

Get.put()这是个立即注入内存的注入方法。调用后已经注入到内存中。
通常Get.put()的实例的生命周期和 put 所在的 Widget 生命周期绑定，如果在全局 （main 方法里）put，那么这个实例就一直
存在。如果在一个 Widget 里 put ，那么这个 Widget 从内存中删除，这个实例也会被销毁。注意，这里是删除，并不
是dispose。

Get.lazyPut
懒加载一个依赖，只有在使用时才会被实例化。适用于不确定是否会被使用的依赖或者计算高昂的依赖。
Get.lazyPut<LazyController>(() => LazyController());
LazyController 在这时候并不会被创建，而是等到你使用的时候才会被 initialized，也就是执行下面这句话的
时候才 initialized：
Get.find<LazyController>();
在使用后，使用时的 Wdiget 的生命周期结束，也就是这个 Widget dispose，这个实例就会被销毁。
如果在一个 Widget 里 find，然后退出这个 widget，此时这个实例也被销毁，再进入另一个路由的 Widget，再次 find，GetX会
打印错误信息，提醒没有 put 。及时全局注入，也一样。可以理解为， Get.lazyPut 注入的实例的生命周期是和在Get.find时的上
下文所绑定。

Get.putAsync
注入一个异步创建的实例。比如SharedPreferences。
Get.putAsync<SharedPreferences>(() async {
final sp = await SharedPreferences.getInstance();
return sp;
});

===================Bindings类  start=======================
上面实现了依赖注入和使用，但是和前面讲的手动注入一样，为了生命周期和使用的 Widget 绑定，需要在 Widget 里注入和使用，并
没有完全解耦。要实现自动注入，我们就需要这个类。
创建一个类并实现Binding
class InjectSimpleBinding implements Bindings {}
因为Bindings是抽象方法，所以要ide会提示要实现dependencies。在里面注入我们需要的实例：
class InjectSimpleBinding implements Bindings {
@override
void dependencies() {
Get.lazyPut<Api>(() => Api());
Get.lazyPut<InjectSimpleController>(() => InjectSimpleController());
}
}
通知路由，我们要使用该 Binding 来建立路由管理器、依赖关系和状态之间的连接。
这里有两种方式，如果使用的是命名路由表：
GetPage(
name: Routes.INJECT,
page: () => InjectSimplePage(),
binding:InjectSimpleBinding(),
),
如果是直接跳转：
Get.to(InjectSimplePage(), binding: InjectSimpleBinding());

现在，我们不必再担心应用程序的内存管理，Get将为我们做这件事。
上面我们注入依赖解耦了，但是获取还是略显不方便，GetX 也为我们考虑到了。GetView完美的搭配 Bindings。
class InjectSimplePage extends GetView<InjectSimpleController> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('MyPage')),
body: Center(
child: Obx(() => Text(controller.obj.toString())),
),
floatingActionButton: FloatingActionButton(
onPressed: () {
controller.getAge();
},
child: Icon(Icons.add),
),
);
}
}
这里完全没有Get.find，但是可以直接使用controller，因为GetView里封装好了：
abstract class GetView<T> extends StatelessWidget {
const GetView({Key key}) : super(key: key);

final String tag = null;

T get controller => GetInstance().find<T>(tag: tag);

@override
Widget build(BuildContext context);
}
当然，也许有时候觉得每次声明一个 Bingings 类也很麻烦，那么可以使用 BindingsBuilder ，这样就可以简单地使用一
个函数来实例化任何想要注入的东西。
GetPage(
name: '/details',
page: () => DetailsView(),
binding: BindingsBuilder(() => {
Get.lazyPut<DetailsController>(() => DetailsController());
}),
Bindings的工作原理?
Bindings 会创建过渡性工厂，在点击进入另一个页面的那一刻，这些工厂就会被创建，一旦路由过渡动画发生，就会被销毁。 工厂占
用的内存很少，它们并不持有实例，而是一个具有我们想要的那个类的 "形状"的函数。 这在内存上的成本很低，但由于这个库的目的
是用最少的资源获得最大的性能，所以Get连工厂都默认删除。

而 GetX 因为不需要上下文，突破了InheritedWidget的限制，我们可以在全局和模块间共享状态，这正是 BLoc 、Provider 等
框架的短板。
可以把GetxController当做ChangeNotifier

把一个变量变得可观察，变量每次改变的时候，使用它的小部件就会被更新：
1）通过 .obs
var name = '新垣结衣'.obs;
通过 Obx 或者 GetX 包裹并使用响应式变量的控件，在变量改变的时候就会被更新：
Obx (() => Text (controller.name));

//使一个List成为可观察的
final list = List<User>().obs;

ListView.builder (
itemCount: controller.list.length //List使用的时候不需要.value
)

2）使用 Rx{Type}
final name = RxString('');
3）使用 Rx，规定泛型 Rx
final name = Rx<String>('');
//自定义类 - 可以是任何类
final user = Rx<User>();

将一个对象转变成可观察的，也有2种方法：
可以将我们的类值转换为 obs
ini复制代码class RxUser {
final name = "Camila".obs;
final age = 18.obs;
}

或者可以将整个类转换为一个可观察的类。
php复制代码class User {
User({String name, int age});
var name;
var age;
}
//实例化时。
final user = User(name: "Camila", age: 18).obs;
注意，转化为可观察的变量后，它的类型不再是原生类型，所以取值不能用变量本身，而是.value


当你在使自己的类可观察时，有另外一种方式来更新它们：
// model
// 我们将使整个类成为可观察的，而不是每个属性。
class User{
User({this.name = '', this.age = 0});
String name;
int age;
}
// controller
final user = User().obs;
//当你需要更新user变量时。
user.update( (user) { // 这个参数是你要更新的类本身。
user.name = 'Jonny';
user.age = 18;
});
// 更新user变量的另一种方式。
user(User(name: 'João', age: 35));
// view
Obx(()=> Text("Name ${user.value.name}: Age: ${user.value.age}"));
// 你也可以不使用.value来访问模型值。
user().name; // 注意是user变量，而不是类变量（首字母是小写的）。

使用了GetBuilder这个 Widget 包裹了页面，在 init初始化SimpleController,然后每次点击，都会更新builder对应
的 Widget ，GetxController通过update()更新GetBuilder。

GetxController的生命周期？
class GetBuilderCountController extends GetxController {
@override
void onInit() {
super.onInit();
}
@override
void onReady() {
super.onReady();
}
@override
void onClose() {
super.onClose();
}
}

GetX是一个超轻和强大的解决方案。它结合了高性能状态管理、智能依赖注入和路由管理，快捷实用。
1）GetX 专注于性能和最少的资源消耗。GetX 不使用 Streams 或 ChangeNotifier。
2）它将节省开发时间，并提供您的应用程序可以提供的最大性能。使用GetX可以不用关心从内存中删除控制器。
3）GetX 可以将视图和逻辑、依赖注入和导航的完全解耦。路由之间导航中不需要上下文，所以不依赖于
小部件树。不需要通过MultiProviders注入到小部件树中。

如果仅使用 Get 进行状态管理或依赖管理，则无需使用 GetMaterialApp。GetMaterialApp 对于路由、snackbars、国际
化、bottomSheets、对话框以及与路由和缺少上下文相关的高级 api 是必需的。

创建视图，使用 StatelessWidget 并节省一些 RAM(节省内存)，有了 Get，您可能不再需要使用 StatefulWidget。

使用Get.put()实例化你的类，使它对所有的“子”路由（跳转到的后面的路由）都可用：
Get.put<PutController>(PutController());
你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。

Get有两个不同的状态管理器:简单状态管理器(我们称之为GetBuilder)和响应状态管理器(GetX/Obx)。

GetConnect：封装了Dio

ValueBuilder:StatefulWidget的简化版，通过updateFn替代setState来更新数据

StateMixin:处理UI状态的另一种方法是使用StateMixin<T>. 要实现它，请使用with添加StateMixin<T> 到允许 T 模型的控制器。
class Controller extends GetController with StateMixin<User>{}
当状态需要改变时，可以通过调用change来更新UI
change(data, status: RxStatus.success());
RxStatus的status有下面几个:
RxStatus.loading();
RxStatus.success();
RxStatus.empty();
RxStatus.error('message');
在View中这样使用：
class OtherClass extends GetView<Controller> {
@override
Widget build(BuildContext context) {
return Scaffold(

      body: controller.obx(
        (state)=>Text(state.name),
        
        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: CustomLoadingIndicator(),
        onEmpty: Text('No data found'),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error)=>Text(error),
      ),
    );
}

GetView：它是一个const Stateless，可以得到一个已经注册的Controller


get2.0之后，RxController 和 GetBuilder 现在已经合并，不需要记住要使用哪个控制器，只需使用 GetxController，它将用
于简单的状态管理和响应式。

如果代码中纯跳转一个页面的话可以使用GetView+GetxController+Bindings+GetConnect的方式请
求数据，可以使用如下方式跳转：
Get.to(StateMixinView(),binding: StateMixinBinding())
但是如果是TabBar+TabBarView的方式，在TabBarView的item页面中请求数据的话，那么就不能使用上面的方式了，这个时候就
需要把binding中的设置controller懒加载的语句放在view页面中：
Get.lazyPut<StateMixinProvider>(() => StateMixinProvider());
Get.lazyPut<StateMinxinController>(() => StateMinxinController(provider: Get.find()));
可以参考 order_list_page.dart 这个文件


除非你需要使用混合器，比如TickerProviderStateMixin，否则完全没有必要使用StatefulWidget与Get。

不要在GetxController里面调用dispose方法，它不会有任何作用，记住控制器不是Widget，你不应该 "dispose "它，它会被Get自动智能地从内存中删除。如果你在上面使用了任何流，想
关闭它，只要把它插入到close方法中就可以了。
class Controller extends GetxController {
StreamController<User> user = StreamController<User>();
StreamController<String> name = StreamController<String>();

    ///关闭流用onClose方法，而不是dispose
    @override
    void onClose() {
        user.close();
        name.close();
        super.onClose();
    }
}

GetBuilder仍然是一个手动的状态管理器，你需要调用update()，就像你需要调用Provider的notifyListeners()一样。

如果你想用GetBuilder完善一个widget的更新控件，你可以给它们分配唯一的ID。
GetBuilder<Controller>(
id: 'text', //这里
init: Controller(), // 每个控制器只用一次
builder: (_) => Text(
'${Get.find<Controller>().counter}', //here
),
),
并更新它：
update(['text']);
您还可以为更新设置条件。
update(['text'], counter < 10);


GetBuilder:
GetBuilder的作用： GetBuilder 是一个 Widget 组件， 在 GetX 的状态管理中，GetBuilder 的主要作用是结合 GetxController 实现界面数据的更新。当调用 GetxController 的 update 方法
时，GetBuilder 包裹的 Widget 就会刷新从而实现界面数据的更新。









https://www.6hu.cc/archives/170816.html Flutter3.0新特性
https://www.6hu.cc/archives/169226.html Flutter3.10新特性
https://www.6hu.cc/archives/146181.html 多版本管理fvm
https://www.6hu.cc/archives/141643.html Dio封装
https://www.6hu.cc/archives/121911.html pigeon的使用
https://www.6hu.cc/archives/120270.html NativeBridge
https://www.6hu.cc/archives/114392.html 下载文件并用原生打开
https://www.6hu.cc/archives/99566.html 通信机制
https://www.6hu.cc/archives/98549.html CustomPainter自定义绘画
https://www.6hu.cc/archives/88245.html 3.3版本的新特性
https://www.6hu.cc/archives/81389.html Dart语法
https://www.6hu.cc/archives/78098.html 静态资源多渠道定制
https://www.6hu.cc/archives/76854.html 多版本共存


4.插件
shimmer: ^3.0.0 骨架屏
5.pubspec.yaml文件介绍
https://www.6hu.cc/archives/64956.html
https://www.6hu.cc/archives/67748.html


8.Dio封装
https://www.6hu.cc/archives/67776.html


15.了解一下ChangeNotifier
16.

//关于Layer的介绍可参考 初识Flutter中的Layer，下面我们是看看isRepaintBoundary回来true时是怎样创立Layer的。

17.RepaintBoundary，这个好好看看，自定义组件可能会用到这个属性
https://www.6hu.cc/archives/81673.html

//了解下UIKitView 和 AndroidView
//如果在一个界面上一起实例化多个原生控件，就会对性能造成非常大的影响，所以咱们要防止在运用 flutter 控件也能完成的情况下去运用内嵌渠道视图。由于这样做，一方面需求分别在 Android 和 iOS 端写很多的适配桥接代码，违反了跨渠道技术的本意，也增加了后续的保护成本；另一方面究竟除去地图、WebView、相机等触及底层计划的特殊情况外，大部分原生代码能够完成的 UI 效果，彻底能够用 flutter 完成。
//final修饰变量后，变量不能重新被赋值；如果final修饰的变量没有被赋值，那么这个变量只能赋值一次，后面就不能改变了；final声明的变量不赋值是不能使用的
//late final int bbb;
//  void play(){
//    bbb = 6;
//    debugPrint('$bbb');
//  }
//const
//const修饰常量，声明的时候就需要赋值，这也是和final最大的区别；const修饰的常量不能再次赋值


//同一个类文件中的顶层办法，能够拜访类的私有变量和办法
void test(){
EnvironmentConfig config = EnvironmentConfig();
config._play();
debugPrint('${config._count}');
}

class EnvironmentConfig {
static const CHANNEL = String.fromEnvironment('CHANNEL');
//DEBUG = Y 是调试模式，其他为生产模式
static const DEBUG = String.fromEnvironment('DEBUG');
var _count = 10;
void _play(){

}
}


          Provider原理？
            https://www.6hu.cc/archives/165634.html

plugin和第三方插件，可以了解下：
https://www.6hu.cc/archives/185591.html

ConstraintLayout约束布局：
https://www.6hu.cc/archives/163928.html

3.7 新增 – ContextMenu 菜单：
https://www.6hu.cc/archives/158531.html

下面含有Dart的垃圾回收：
https://www.6hu.cc/archives/158308.html




在flutter里streams是什么？有几种streams？有什么场景用到它？
Stream 用来处理接连的异步操作，Stream 是一个笼统类，用于表明一序列异步数据的源。它是一种产生接连事情的方式，能够生成数据事情或许过错事情，以及流完毕时的完结事情 Stream 分单订阅流和广播流。 网络状况的监控



main()和runApp()函数在flutter的作用别离是什么？有什么关系吗？
main函数是相似于java语言的程序运转进口函数。
runApp函数是烘托根widget树的函数。
一般状况下runApp函数会在main函数里履行。





Flutter ListView怎样翻滚到指定position，列表翻滚原生是怎样的，怎样监听listview翻滚到了哪个Item？假设Item是不固定高度的呢？

Flutter布局束缚规矩是什么姿态的？子类想要多少就要多少吗？
首要，上层 widget 向基层 widget 传递束缚条件；
然后，基层 widget 向上层 widget 传递大小信息。  
最后，上层 widget 决定基层 widget 的方位。


约束布局，这个要研究明白：
https://flutter.cn/docs/ui/layout/constraints
https://www.6hu.cc/archives/137503.html

约束布局：YushuPage这个文件

Flutter3.7的新特性：
https://www.6hu.cc/archives/104578.html



setState之前需要判断下当前页面是否存在：
if (mounted){
setState(() {
});

2.
addPostFrameCallback回调方法在Widget渲染完结时触发，所以一般我们在获取页面中的 Widget 巨细、方位时运用到。

处理方法就是运用addPostFrameCallback回调方法，等候页面 build 完结后在恳求数据：

@override
void initState() {
WidgetsBinding.instance.addPostFrameCallback((_){
/// 接口请求
});
}
Getx中如果继承GetxController，如果需要在接口请求完成后获取Widget相关信息时，接口请求最好放到GetxController的重写方法onReady()中；如果不不需要获取Widget的相关信息，则可以放到onInit()方法中。
void onInit() {
super.onInit();
//getx的onInit重写方法中使用了addPostFrameCallback来保证Widget渲染完成		
Get.engine.addPostFrameCallback((_) => onReady());
}




获取顶部和底部的安全区域：
顶部
final double statusBarHeight = MediaQuery.of(context).padding.top;
底部
final double bottomHeight = MediaQuery.of(context).padding.bottom;]()















挖酒crm中的api：
1）列间距
5.w.gapColumn,
2）分割线
DividerHorizontal(),


AndroidStudio点击右侧边栏的Flutter Performance可以查看性能问题，有卡顿或者耗时的会在Frame rendering times中呈现红色的竖条。



看下ListView使用shrinkWrap属性是否有性能问题


如果Column嵌套ListView，需要使用Expanded包裹ListView


1.如果一行有几个Widget需要平分的话并且每个Item需要点击的话：
不用设置Row的mainAxisAlignment为MainAxisAlignment.spaceAround，设置Row中的每个Item使用Expanded包裹，并且每个Item内部使用Container包裹并且需要给Container设置一个颜色
Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Expanded(child: topItemView(0)),
Expanded(child: topItemView(1)),
Expanded(child: topItemView(2)),
],
)

topItemView：
return GestureDetector(
onTap: () {
debugPrint("代客下单");
},
child: Container(
color: (index==0||index==2)?ResColors.primary:ResColors.black,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
CustomImage(
uri: uri,
width: 45.w,
),
Padding(
padding: EdgeInsets.only(top: 8.w),
child: Text(
bottomName,
style: TextStyle(color: ResColors.c58, fontSize: 16.sp),
),
)
],
),
),
);

2.Flutter英文文档
https://api.flutter.dev/flutter/widgets/SliverFillRemaining-class.html

3.TextField中的内容默认是在顶部的，如果像要垂直居中，可以如下设置：
Container(
height: 30,
alignment: Alignment.center,
margin: EdgeInsets.only(left: 13.w,right: 13.w,top: 10.w,bottom: 10.w,),
decoration: const BoxDecoration(
color: ResColors.ceeeeee,
),
child: TextField(
// enabled: controller.isEdit,
// controller: controller.taskDetailController,
style: TextStyle(fontSize: 16.sp, color: ResColors.c33),
onChanged: (String value) {},
decoration: InputDecoration(
//主要是设置contentPadding这个属性
contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
border: InputBorder.none,
hintText: "请输入内容",
hintStyle: TextStyle(
fontSize: 16.sp, color: ResColors.gray350),
),
)
)



4.圆角不用w适配

5.flutter官方文档
https://api.flutter.dev/flutter/widgets/SliverFillRemaining-class.html
有需要查询的组件可以在google搜索，都有例子


6.数据模型解析需要对对象和数组判空
7.如果只想设置一个背景色，可以使用ColoredBox,ColoredBox是const类型的

8.组合数据
Map<String, dynamic> json = {'name':'清空选择'};//组合数据
model?.filterItem?[1].child?.add(ChildModel.fromJson(json));


9.TextField设置文本垂直居中
textAlignVertical: TextAlignVertical.center,


10.TabBar和TabBarView联动滑动，只需要设置相同的controller即可：
TabController? tabController;
@override
void onInit() {
super.onInit();
tabController = TabController(length: 2, vsync: this);
}

获取选中状态：
tabController?.addListener(() {
currentSelectedIndex = tabController?.index??0;
});

TabBar标签颜色的改变应该通过TabBar的：
unselectedLabelColor: ResColors.black,
labelColor: ResColors.primary,
这两个属性来设置选中和非选中的颜色，不要通过监听设置tabs数组中的文本颜色，否则会有bug


11.如果GestureDetector的点击事件在某个区域不生效的话，可以给他设置：
behavior: HitTestBehavior.opaque或者给Container设置一个颜色.

12.Get传递参数，需要注意格式，
arguments: { 'screenList':controller.screenList }Map 正确
arguments: { 'screenList',controller.screenList }Set 错误
这里注意千万不要搞错了

13.使用GetBuilder的时候一定要加范型，否则会报错

14.水平方向想平分布局并且可以实现点击的话可以使用Expanded，不要使用Row/Column的MainAxisAlignment.spaceAround属性。


15.将对象或者List转为json,打印输出
1）导入import 'dart:convert';
String jsonStr = jsonEncode(_screenList?[0]);
2）对象中需要重写toJson方法
class SecondChildModel{
int? elementId;
String? name;
String? key;
String? value;
int? type;
int? state;
bool? selected;
SecondChildModel.fromJson(Map<String, dynamic> json) {
elementId = json['elementId'];
name = json['name'];
type = json['type'];
state = json['state'];
selected = json['selected'];
key = json['key'];
value = json['value'];
}
Map<String, dynamic> toJson() => {
'elementId': elementId,
'name': name,
'type': type,
'state': state,
'selected': selected,
'key': key,
'value': value,
};
}

16.Map获取value，更新value，添加数据
if(paramsMap.containsKey(secondElement.key)){//判断是否包含某个key
//update为更新Map中的某个值   paramsMap[key]为通过key获取value
paramsMap.update(secondElement.key??'', (value) => '${paramsMap[secondElement.key]},${secondElement.value}');
}else{
//添加数据 paramsMap[key]=value
paramsMap[secondElement.key??''] = secondElement.value??'';
}
使用级联操作符将一个map添加进另一个map中：
Map<String, dynamic> paramsMap = {
'page': pageNumber,
'pageSize': size,
...?_screenParams //_screenParams非空可以不用?
};


17.键盘弹出和消失导致重新build的解决办法？
1）可以在Scaffold中设置属性 resizeToAvoidBottomInset: false,
2）检查下页面中是否使用了Theme和MediaQuery，这两个组件中都是用了InheritedWidget，InheritedWidget会导致它自身和它的子类重新build。

18.Get.toNamed跳转的时候不能设置跳转动画，只能在GetPage中配置跳转动画：
GetPage(
name: CustomSignInFilterPage.path,
page: () => const CustomSignInFilterPage(),
transition: Transition.rightToLeft,//进入时从右到左，销毁时从左到右
binding: BindingsBuilder(() => Get.lazyPut(() => CustomSignInFilterController())),
)

19.不要用方法void的方式获取组件，可以使用class来获取，比如使用StatelessWidget或者StatefulWidget来获取组件，因为使用方法获取组件系统不知道方法中有什么样的组件，性能不如使用class来获取。

20.将输入框的回车键修改为搜索按钮
TextField和TextFormField都可以设置如下属性将回车键修改为搜索按钮：
textInputAction: TextInputAction.search,
不过TextField没有单纯的监听点击键盘上的搜索按钮的方法，TextField只能通过onChanged或者通过它的controller来设置监听获取改变后的值。
TextFormField有onFieldSubmitted的属性可以单纯的监听点击搜索按钮的功能：
onFieldSubmitted: (String value) => debugPrint('hello $value'),

21.TextField设置
decoration: InputDecoration(
hintText: "最大",//设置hint
hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),//设置hint样式
border: InputBorder.none,//设置边框
contentPadding: EdgeInsets.only(bottom: 11.w, left: 10.w),//设置内容的padding
)
textAlignVertical: TextAlignVertical.center,设置内容垂直居中
textAlign: TextAlign.center,//设置居中，水平和垂直方向都居中

22.Getx中如果继承了GetxController但是没有在view页面中使用，那么这时候GetXController的onInit方法不会执行

23.比较两个map是否相等
void cancelSelect(){
if(!mapEquals(setSelectedAreaParams(), initAreaParams)){
Get.back(result: initAreaParams);
}
}



23.返回数据给上一个页面，如果是返回多个参数，可以返回map或者javaBean
Map<String,dynamic> customParams = {
'currentCustomId':currentCustomId,
'refresh':true,
};
Get.back(result: customParams);


24.当表达式可以求值为true、false或null，并且需要将结果传递给需要一个不可空布尔值的对象时，建议使用??而不是=或者!=。

25.如何开启空安全？
在 Dart 2.12 到 2.19 中，你需要手动启用空安全。 Dart 2.12 之前的 SDK 版本不提供空安全。
想要启用健全空安全，需要将 SDK 的最低版本约束设定为 2.12 或者更高的语言版本。例如，你的 pubspec.yaml 可以设置为如下的限制：
environment:
sdk: '>=2.12.0 <3.0.0'
26.注释
1）单行注释
void main() {
// TODO: refactor into an AbstractLlamaGreetingFactory?
print('Welcome to my Llama farm!');
}
2）多行注释
void main() {
/*
* This is a lot of work. Consider raising chickens.

Llama larry = Llama();
larry.feed();
larry.exercise();
larry.clean();
*/
}
3）文档注释
文档注释是以///或/**开头的多行或单行注释。在连续的行中使用///与多行文档注释的效果相同。
/// Exercises your llama with an [activity] for
/// [timeLimit] minutes.
void exercise(Activity activity, int timeLimit) {
// ...
}

27.字符串
1）字符串可以使用单引号和双引号
2）可以使用${expression}将表达式的值放入字符串中。如果表达式是标识符，则可以跳过{}。为了获得与对象对应的字符串，Dart调用对象的toString()方法
3）==用于比较两个对象是否相等，也可以用==比较两个字符串是否相等（字符串内容是否相等）
4）'''字符串内容''' 实现多行字符串，其中的字符串内容可以使用''或者‘’ ‘’来包含
String resutl = '''你是一个'小可爱',hello world ''';
5)使用前缀r来保持字符串的原始性
var s = r'In a raw string, not even \n gets special treatment.';
6）除了使用==比较字符串，还可以使用String.compareTo(otherStr)来比较字符串是否相等
String result = 'hello';
String result2 = 'hello2';
//compareTo 两个字符串如果相等则会返回0
debugPrint('${result.compareTo(result2)}');
28.List
1）对List数组进行排序
List<int> list = [5,3,1,7,6];
list.sort();
debugPrint('$list');//输出：[1, 3, 5, 6, 7]
2）创建List
var grains = <String>[];
assert(grains.isEmpty);

var fruits = ['apples', 'oranges'];

3）添加元素
fruits.add('kiwis');

4）添加全部元素
fruits.addAll(['grapes', 'bananas']);

5）获取List的长度
fruits.length

6）删除元素
//删除某个元素
var appleIndex = fruits.indexOf('apples');
fruits.removeAt(appleIndex);

//删除最后一个元素
fruits.removeLast();

//删除全部的元素
fruits.clear();

7）获取元素
fruits[0]

8）获取某个元素的index
int index = fruits.indexOf('oranges');

9）获取某个元素最后一个的index
fruits.indexOf('B');

10）在某个位置插入一个元素
fruits.insert(1, 'New');

11)替换和删除某一区域内的元素
替换某一区域内的元素
final numbers = <int>[1, 2, 3, 4, 5];
final replacements = [6, 7];
//replaceRange 将某个区域内的元素全部替换掉
//替换范围从下标1开始到下标4结束，不包含下标4，也就是将2，3，4替换为6, 7
numbers.replaceRange(1, 4, replacements);
debugPrint('$numbers'); // [1, 6, 7, 5]

//删除某一区域内的元素
List<int> numbers = [1, 2, 3, 4, 5];
//removeRange 删除某一区域内的元素，从下标2开始删除，不包含下标4
numbers.removeRange(2, 4);
debugPrint('$numbers');//[1, 2, 5]

//在某一区域内插入元素，在下标为1的位置插入6，7
numbers.insertAll(1, [6,7]);
debugPrint('$numbers');//[1, 6, 7, 2, 5]

//List.filled 创建5个值为‘old’的元素
List<String> words = List.filled(5, 'old');
debugPrint('$words'); // [old, old, old, old, old]
//fillRange 替换某一区域内的元素，从下标1开始，到下标3结束，不包含下标3
words.fillRange(1, 3, 'new');
debugPrint('$words'); // [old, new, new, old, old]

12）对List中的元素随机排序
List<int> numbers = [1, 2, 3, 4, 5];
numbers.shuffle();
debugPrint('$numbers');//输出的数组元素顺序是随机的

13）查找满足条件的元素

---查找符合条件的第一个元素
final numbers = <int>[1, 2, 3, 5, 6, 7];
var result = numbers.firstWhere((element) => element < 5); // 1
var result = numbers.firstWhere((element) => element > 5); // 6
var result =
numbers.firstWhere((element) => element > 10, orElse: () => -1);//-1
如果没有元素满足条件，则返回调用orElse函数的结果。如果省略orElse，则默认抛出StateError。

---查找符合条件的最后一个元素lastWhere
lastWhere用法和firstWhere一样

---查找满足条件的单个元素
final numbers = <int>[2, 2, 10,11];
var result = numbers.singleWhere((element) => element > 5);
debugPrint('$result');
检查元素是否有满足条件的元素。如果恰好有一个元素满足，则返回该元素。如果找到多个匹配元素，则抛出StateError。如果没有找到匹配的元素，则返回orElse的结果。如果省略orElse，则默认抛出StateError。

---查找满足条件的所有元素
final numbers = <int>[1, 2, 3, 5, 6, 7];
var result = numbers.where((x) => x < 5); // (1, 2, 3)

result = numbers.where((x) => x > 5); // (6, 7)

result = numbers.where((x) => x.isEven);//(2, 6)


14）使用map对List进行循环遍历
List<Map<String,dynamic>> products =[
{"name": "Screwdriver", "price": 42.00},
{"name": "Wingnut", "price": 0.50}
];
var values = products.map((product) => product['price'] as double);
var totalPrice = values.fold(0.0, (a, b) => a + b);
debugPrint('$totalPrice');//42.5

除了使用map外，还可以使用for循环对List遍历
List<String> list = [];
for (var element in list) {

    }



Map相关：
1）添加元素，使用 []=
var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds';
2）通过key获取value
String value = gifts['fourth'];
如果获取了一个不存在的key，那么会返回null
var gifts = {'first': 'partridge'};
debugPrint('${gifts['fifth']}');//null

获取map的长度
debugPrint('${gifts.length}');
使用isEmpty和isNotEmpty判断map是否为空和不为空
gifts.isEmpty

通过gifts.keys获取所有的key，可以通过for循环遍历key
for (var element in gifts.keys) {
debugPrint(element);
}
通过gifts.values获取所有的value，可以通过for循环遍历value
for (var element in gifts.values) {
debugPrint(element);
}

修改value
Map<String, int> map9 = {'a9': 1, 'b9': 2};
map9['a9'] = 9;
debugPrint('$map9'); //{a9: 9, b9: 2}

update:通过key对对应的value做修改操作
Map<String, int> map10 = {'a10': 1, 'b10': 2, 'c10': 3};
var resultMap10 = map10.update('b10', (value) => value * 2);
print(resultMap10); //4
print(map10); //{a10: 1, b10: 4, c10: 3}
//如果key不存在，但是有ifAbsent参数，返回idAbsent函数的值，并添加到map中
var resultMap101 = map10.update('c', (value) => (value * 2),
ifAbsent: () => (10));
print('$resultMap101,${resultMap101.runtimeType}'); //10,int
print(map10); //{a10: 1, b10: 4, c10: 3, c: 10}

updateAll：对map中所有的数据做修改
Map<String, int> map11 = {'a11': 2, 'b11': 3, 'c11': 4};
var resultMap11 = map11.updateAll((key, value) {
return value * 2;
});
print(map11); //{a11: 4, b11: 6, c11: 8}
map11.updateAll((key, value) {
if (key == 'a11') {
return value * 2;
}
if (key == 'c11') {
return value + 1;
}
return 7; //如果没有这行，b11对应的value为null 这里可以看出updateall会影响所有的键值对
});
print(map11); //{a11: 8, b11: 7, c11: 9}


remove删除一个键值对
Map<String, int> map12 = {'a12': 2, "b12": 1};
map12.remove('a12');
print(map12); //{b12: 1}
map12.remove('c12'); //删除一个不存在的key，毫无影响，无报错无警告
print(map12); //{b12: 1}

removeWhere根据条件批量删除键值对
removeWhere(bool predicate(K key, V value)) 根据函数条件批量删除key
Map<String, int> map13 = {'a13': 3, 'b13': 4, 'c13': 1};
map13.removeWhere((key, value) => value > 3);
print(map13); //{a13: 3, c13: 1}


containsKey() 是否包含某个key contrainsValue()是否包含某个value
Map<String ,int> map14 = {'a14':1};
bool resultMap14 = map14.containsKey('a11'); //false
bool resultMap141 = map14.containsValue(1); //true

map() 遍历每个键值对 根据参数函数，对keyvalue做出修改，转换成其他泛型Map  map方法可以转为一个新的对象
Map<String,int> map16 = {'a16':7,"b16":5,'c16':4};
Map<int,String> map17 = map16.map((key, value) {
return MapEntry(value, key);
});
print(map17);//{7: a16, 5: b16, 4: c16}

addAll() 两个Map合并，类型需要一致 ，且如果key相同，则会覆盖value
Map<String,int> map18 = {'a18':1,'b18':7,'a19':2};
Map<String,int> map19 = {'a19':9};
map18.addAll(map19);
print(map18); //{a18: 1, b18: 7, a19: 9}

Map<String,int> map20 = {'a20':2,'b20':3};
Map<String,int> map21 = {'a21':5,'b21':9};
map20.addEntries(map21.entries);
print(map20); //{a20: 2, b20: 3, a21: 5, b21: 9}


putIfAbsent() 存在key则返回value，查不到则返回值 不修改Map
Map<String,int> map22 = {'a22':3,'b22':4};
var resultMap22 = map22.putIfAbsent('a22', () => 2); //存在key则返回value，查不到则返回 2 不修改Map
print('$resultMap22,$map22');//3,{a22: 3, b22: 4}

var resultMap221 = map2.putIfAbsent('a2', () => 1);
print('$resultMap221,$map22'); //1,{a22: 3, b22: 4} //存在key则返回value，查不到则返回 1 不修改Map


清除所有键值对
Map<String,int> map25 = {'a25':2,'b25':3};
map25.clear();
print('$map25');//{}


扩展操作符
...
...?

//where可以排出所有为null的数据
var more = [1, ...things.where((thing) => thing != null), 4];


函数相关补漏：
1）可以将一个函数传递给另一个函数
var list = [1, 2, 3];
list.forEach(printElement);//printElement这个函数必须是action(E element)类型的，因为forEach需要一个这个类型的方法
void printElement(int element) {
debugPrint('$element');
}
2）要在函数中返回多个值，需要使用解构获取数据
(String, int) foo() {
return ('something', 42);
}

    var (name,age) = foo();
    debugPrint(name);//something
    debugPrint('$age');//42
3)Function
Function类型本身允许将任何函数分配给它,因为它是任何函数类型的超类型，它可以像函数一样被调用。
Function function =(int number)=>'$number';
debugPrint('${function(10)}');//10
4）call方法
调用该call方法的行为就像调用该函数一样。
String Function(int) fun = (n) => "$n";
String Function(int) fun2 = fun.call;



1)StringBuffer提供了一种高效拼接字符串的方法。
StringBuffer stringBuffer = StringBuffer();
stringBuffer.write('hello');
stringBuffer.write('word');
debugPrint(stringBuffer.toString());//helloword
2）日期时间类 DateTime
//https://api.dart.cn/stable/3.1.0/dart-core/DateTime-class.html DateTime文档
final now = DateTime.now();//现在的时间
final berlinWallFell = DateTime.utc(1989, 11, 9);
final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
debugPrint('$now');//2023-08-17 10:53:41.873738
debugPrint('$berlinWallFell');//1989-11-09 00:00:00.000Z
debugPrint('$moonLanding');//1969-07-20 20:18:04.000Z
//DateTime输出的是计算机的本地时区

    //可以通过DateTime获取年，月，日，时，分，秒
    debugPrint('${now.year}'); // 2023
    debugPrint('${now.month}'); // 8
    debugPrint('${now.day}'); // 17
    debugPrint('${now.hour}'); // 10
    debugPrint('${now.minute}'); // 57
    debugPrint('${now.second}'); // 35
    debugPrint('${now.weekday}'); // 4（星期4）

    //DateTime.november是提供的一个方便获取月份的常量，除了november还有其他的月份
    //DateTime.monday是提供的一个方便获取星期几的常量，除了monday还有其他的月份
    if(berlinWallFell.month == DateTime.november){//判断这个月是否是11月

    }

    // 比较 DateTime 对象
    // 该类DateTime包含按时间顺序比较DateTimes 的方法，例如isAfter、isBefore和isAtSameMomentAs。
    debugPrint('${now.isAfter(moonLanding)}'); // true
    debugPrint('${now.isBefore(moonLanding)}'); // false
    debugPrint('${now.isAtSameMomentAs(moonLanding)}'); // false

    // 对Duration对象使用add和minus方法可以基于另一个对象创建一个对象。例如，要查找现在 36 小时后的时间点，您可以编写：DateTime

    final nowDateTime = DateTime.now();
    final later = nowDateTime.add(const Duration(hours: 36));
    debugPrint('$later');//later的时间为 现在的时间+36个小时

3）Duration
//使用构造方法创建Duration
// Duration({int days = 0, int hours = 0, int minutes = 0, int seconds = 0, int milliseconds = 0, int microseconds = 0})
// { int 天= 0 , int 小时= 0 , int 分钟= 0 , int 秒= 0 , int 毫秒= 0 , int 微秒= 0 }
const fastestMarathon = Duration(hours: 2, minutes: 3, seconds: 2);

    //in...开头的属性可以获取总的时间，比如inHours获取的是总的小时，inMinutes获取的是总的分钟数，返回的值为向下舍入的
    debugPrint('${fastestMarathon.inDays}'); // 0
    debugPrint('${fastestMarathon.inHours}'); // 2
    debugPrint('${fastestMarathon.inMinutes}'); // 123
    debugPrint('${fastestMarathon.inSeconds}'); // 7382
    debugPrint('${fastestMarathon.inMilliseconds}'); // 7382000

    //Duration可以相加减
    const firstHalf = Duration(minutes: 45); // 00:45:00.000000
    const secondHalf = Duration(minutes: 45); // 00:45:00.000000
    const overTime = Duration(minutes: 30); // 00:30:00.000000
    final maxGameTime = firstHalf + secondHalf + overTime;
    final maxGameTime2 = firstHalf - overTime;
    debugPrint('${maxGameTime.inMinutes}'); // 120
    debugPrint('${maxGameTime2.inMinutes}'); // 15

    //还可以比较两个Duration是否相等
    // The duration of the firstHalf and secondHalf is the same, returns 0.
    var result = firstHalf.compareTo(secondHalf);
    debugPrint('$result'); // 0
    // Duration of overTime is shorter than firstHalf, returns < 0.
    result = overTime.compareTo(firstHalf);
    debugPrint('$result'); // < 0
    // Duration of secondHalf is longer than overTime, returns > 0.
    result = secondHalf.compareTo(overTime);
    debugPrint('$result'); // > 0

4）任意大的整形数
//BigInt 任意大的整数型
//1）从字符串中解析大整形数
String str = '10000000000000000000000';
BigInt bigInt = BigInt.parse(str);
debugPrint('${num.parse(str)}');//int.parse这里会报错；num.parse输出则为 1e+22
debugPrint('$bigInt');//想解决这种科学计数法的问题，需要使用 BigInt.parse,输出为 10000000000000000000000
//2）检查大整数是否可以表示为int而不丢失精度，请使用isValidInt。
debugPrint('${bigInt.isValidInt}');//true：不丢失精度；false：丢失精度
//3）要将大整数转换为int，请使用toInt。要将大整数转换为double，请使用toDouble。
debugPrint('${bigInt.toInt()}'); // 9223372036854775807
debugPrint('${bigInt.toDouble()}'); // 1e+22

5）判断Release和Debug环境          
//判断是否为Release环境，Debug和Profile环境均为false，Release时为true
bool environment = const bool.fromEnvironment("dart.vm.product");
debugPrint('$environment');

6）compareTo
compareTo和==都可以比较两个对象，一般两者是一致的，但是double和DateTime的compareTo方法与操作符==不一致。对于double, compareTo方法比==更精确，DateTime方法使用==则不那么精确。

     (0.0).compareTo(-0.0);   // => 1
                      0.0 == -0.0;             // => true
                      var now = DateTime.now();
                      var utcNow = now.toUtc();
                      now == utcNow;           // => false
                      now.compareTo(utcNow);//0
DateTime类没有比较运算符，而是具有更精确的名称DateTime.isBefore和DateTime.isAfter，它们都与DateTime.compareTo一致。
实现了Comparable接口的类都可以使用compareTo方法

7）Future的回调
使用then并且可以得到错误：
Future<int> successor = future.then((int value) {//then回调
return 42;  
},
onError: (e) {//onError
if (canHandle(e)) {
return 499;
} else {
throw e;
}
});
不过使用catchError更具有可读性
Get.toNamed(CustomSelectAreaPage.path,
arguments: {'areaParams': controller.areaParams})
?.then((value) {
controller.refreAreaParams(value ?? {});
}).catchError((e){

                  });




更多的可以阅读api文档。


8）回调函数  
1）Function
//bool select为返回值
typedef Select = void Function(bool select); //回调函数有返回值，无返回值可以用VoidCallback

typedef Select = void Function(bool select);//也可以只声明一个类型typedef Select = void Function(bool);
mixin CheckSaleSelectStatus {
/// 获取销售是否有查看其他人的权限
void requestCheckSaleSelectStatus(Select select) {
HttpUtil.getInstance().requestGet(Api.gCheckSaleSelectStatus,
success: (dynamic data) {
CheckSaleSelectStatusModel? model =
CheckSaleSelectStatusModel.fromJson(data['result']);
bool? status = model.status;
if (null == status) {
select(false);
return;
}
select(status);
}, failed: (int code, String msg) {
select(false);
});
}
}

2) VoidCallback 无返回值


9）Object是除了Null之外所有对象的基类

10）Uri
//Uri
//1)要创建具有特定组件的 URI，请使用new Uri：
var httpsUri = Uri(
scheme: 'https',
host: 'dart.dev',
path: '/guides/libraries/library-tour',
queryParameters: {'subject': 'Example'},//参数
fragment: 'numbers');
debugPrint('$httpsUri');//https://dart.dev/guides/libraries/library-tour?subject=Example#numbers

                  //2)要使用 https 方案创建 URI，请使用Uri.https或Uri.http：
                  Uri httpsUri2 = Uri.https('example.com', 'api/fetch', {'limit': '10'});
                  debugPrint('$httpsUri2');// https://example.com/api/fetch?limit=10
                  Uri httpsUri3 = Uri.http('example.com', 'api/fetch', {'limit': '10'});
                  debugPrint('$httpsUri3');// http://example.com/api/fetch?limit=10

                  //3）从字符串中创建Uri
                  final uri = Uri.parse(
                      'https://dart.dev/guides/libraries/library-tour?subject=Example&name=zhangsan#numbers');
                  debugPrint('$uri'); // https://dart.dev/guides/libraries/library-tour?subject=Example#numbers
                  debugPrint('${uri.isScheme('https')}'); // true
                  debugPrint(uri.origin); // https://dart.dev
                  debugPrint(uri.host); // dart.dev
                  debugPrint(uri.authority); // dart.dev
                  debugPrint('${uri.port}'); // 443
                  debugPrint(uri.path); // /guides/libraries/library-tour
                  debugPrint('${uri.pathSegments}'); // [guides, libraries, library-tour]
                  debugPrint(uri.fragment); // numbers
                  debugPrint('${uri.hasQuery}'); // true
                  debugPrint('${uri.queryParameters}'); // {subject: Example, name: zhangsan}
                  debugPrint('${uri.data}'); // null

                  //4)还可以解析文件路径，用到的时候可以再研究


11)全局的方法或者变量（在任何位置都可以调用）可以考虑在整个类中直接写方法和变量，不用加类，搞成顶级函数。

12）mixin和mixin class
声明mixin class定义了一个类，该类既可以用作常规类，也可以用作混合类，并且具有相同的名称和类型，mixin class不能使用on作用在类上。
而mixin不能作为常规类，不能实例化，mixin可以作用在类上面。

两者都不可以实现extends和with

12）abstract mixin和mixin
//如果把mixin去掉，那么子类如果是implements Musician的话，就需要实现Musician中所有的方法
abstract mixin class Musician {
// No 'on' clause, but an abstract method that other types must define if
// they want to use (mix in or extend) Musician:
void playInstrument(String instrumentName);

void playPiano() {
playInstrument('Piano');
}

void playFlute() {
playInstrument('Flute');
}
}

//继承Musician，可以实现Musician中的任何方法
class Virtuoso with Musician {
// Use Musician as a mixin
@override
void playInstrument(String instrumentName) {
print('Plays the $instrumentName beautifully');
}
}
//extends Musician的话，需要重新Musician中所有的抽象方法
class Novice extends Musician {
// Use Musician as a class
@override
void playInstrument(String instrumentName) {
print('Plays the $instrumentName poorly');
}
}
通过将Musician混入类声明为抽象，您可以强制使用它的任何类型定义其行为所依赖的抽象方法。这类似于on指令如何通过指定接口的超类来确保 mixin 可以访问它所依赖的任何接口。



13）扩展补充
扩展可以具有泛型类型参数。List<T>例如，下面是一些使用 getter、运算符和方法扩展内置类型的代码：

extension MyFancyList<T> on List<T> {
int get doubleLength => length * 2;
List<T> operator -() => reversed.toList();
List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}


14）规范相关
对于未使用的回调参数，优先使用__、 等，有时回调函数的类型签名需要参数，但回调实现不使用该参数。在这种情况下，习惯上将未使用的参数命名为_。如果函数有多个未使用的参数，请使用额外的下划线以避免名称冲突：__、___等。

futureOfVoid.then((_) {//回调参数不使用时用 _ 表示
print('Operation complete.');
});

要尽可能的使用集合字面量
//推荐
var points = <Point>[];
var addresses = <String, Address>{};
var counts = <int>{};
//不推荐
var addresses = Map<String, Address>();
var counts = Set<int>();

通过调用length 来判断集合是否包含内容是非常低效的。相反，Dart 提供了更加高效率和易用的 getter 函数：.isEmpty 和.isNotEmpty。使用这些函数并不需要对结果再次取非。
//推荐
if (lunchBox.isEmpty) return 'so hungry...';
if (words.isNotEmpty) return words.join(' ');
//不推荐
if (lunchBox.length == 0) return 'so hungry...';
if (!words.isEmpty) return words.join(' ');


避免 在 Iterable.forEach() 中使用字面量函数

forEach() 函数在 JavaScript 中被广泛使用，这因为内置的 for-in 循环通常不能达到你想要的效果。在Dart中，如果要对序列进行迭代，惯用的方式是使用循环。

for (final person in people) {
...
}
people.forEach((person) {
...
});
例外情况是，如果要执行的操作是调用一些已存在的并且将每个元素作为参数的函数，在这种情况下，forEach() 是很方便的。
people.forEach(print);




要 使用 whereType() 按类型过滤集合
假设你有一个 list 里面包含了多种类型的对象，但是你指向从它里面获取整型类型的数据。那么你可以像下面这样使用 where() ：
var objects = [1, 'a', 2, 'b', 3];
var ints = objects.where((e) => e is int);
这个很罗嗦，但是更糟糕的是，它返回的可迭代对象类型可能并不是你想要的。在上面的例子中，虽然你想得到一个 Iterable<int>，然而它返回了一个 Iterable<Object>，这是因为，这是你过滤后得到的类型。

有时候你会看到通过添加 cast() 来“修正”上面的错误：
var objects = [1, 'a', 2, 'b', 3];
var ints = objects.where((e) => e is int).cast<int>();

代码冗长，并导致创建了两个包装器，获取元素对象要间接通过两层，并进行两次多余的运行时检查。幸运的是，对于这个用例，核心库提供了 whereType() 方法：

var objects = [1, 'a', 2, 'b', 3];
var ints = objects.whereType<int>();
使用 whereType() 简洁，生成所需的 Iterable（可迭代）类型，并且没有不必要的层级包装。



如果有更合适的方法，不要使用cast()：
如果你已经使用了 toList() ，那么请使用 List<T>.from() 替换，这里的 T 是你想要的返回值的类型。

var stuff = <dynamic>[1, 2];
var ints = List<int>.from(stuff);
var stuff = <dynamic>[1, 2];
var ints = stuff.toList().cast<int>();

如果你正在调用 map() ，给它一个显式的类型参数，这样它就能产生一个所需类型的可迭代对象。类型推断通常根据传递给 map() 的函数选择出正确的类型，但有的时候需要明确指明。

var stuff = <dynamic>[1, 2];
var reciprocals = stuff.map<double>((n) => 1 / n);
var stuff = <dynamic>[1, 2];
var reciprocals = stuff.map((n) => 1 / n).cast<double>();



推荐 使用 final 关键字来创建只读属性
如果一个变量对于外部代码来说只能读取不能修改，最简单的做法就是使用 final 关键字来标记这个变量。
//推荐
class Box {
final contents = [];
}
//不推荐
class Box {
Object? _contents;
Object? get contents => _contents;
}




考虑 对简单成员使用 =>
除了使用 => 可以用作函数表达式以外， Dart 还允许使用它来定义成员。这种风格非常适合，仅进行计算并返回结果的简单成员。

double get area => (right - left) * (bottom - top);

String capitalize(String name) =>
'${name[0].toUpperCase()}${name.substring(1)}';
编写代码的人似乎很喜欢 => 语法，但是它很容易被滥用，最后导致代码不容易被阅读。如果你有很多行声明或包含深层的嵌套表达式（级联和条件运算符就是常见的罪魁祸首），你以及其他人有谁会愿意读这样的代码！你应该换做使用代码块和一些语句来实现。

Treasure? openChest(Chest chest, Point where) {
if (_opened.containsKey(chest)) return null;

var treasure = Treasure(where);
treasure.addAll(chest.contents);
_opened[chest] = treasure;
return treasure;
}
Treasure? openChest(Chest chest, Point where) => _opened.containsKey(chest)
? null
: _opened[chest] = (Treasure(where)..addAll(chest.contents));
您还可以对不返回值的成员使用 => 。这里有个惯例，就是当 setter 和 getter 都比较简单的时候使用 => 。
num get x => center.x;
set x(num value) => center = Point(value, center.y);


除了重定向明明函数和避免冲突的情况，其他情况不要使用 this.
class Box {
Object? value;

void clear() {
update(null);
}

void update(Object? value) {
this.value = value;
}
}

class ShadeOfGray {
final int brightness;

ShadeOfGray(int val) : brightness = val;

ShadeOfGray.black() : this(0);

// But now it will!
ShadeOfGray.alsoBlack() : this.black();
}



避免 在方法命名中使用 get 开头。
在大多数情况下，getter 方法名称中应该移除 get 。例如，定义一个名为 breakfastOrder 的 getter 方法，来替代名为 getBreakfastOrder() 的方法。


不要 为 setter 方法指定返回类型。
在 Dart 中，setter 永远返回 void 。为 setter 指定类型没有意义。
//不推荐
void set foo(Foo value) { ... }
//推荐
set foo(Foo value) { ... }


要 使用 Future<void> 作为无法回值异步成员的返回类型。


避免布尔类型的位置参数


不要 使用 == 操作符与可空值比较。
Dart 指定此检查是自动完成的，只有当右侧不是 null 时才调用 == 方法。

//推荐
class Person {
final String name;
// ···

bool operator ==(Object other) => other is Person && name == other.name;
}
//不推荐
class Person {
final String name;
// ···
//不用对other判空，other.name为null时不会掉用==
bool operator ==(Object? other) =>
other != null && other is Person && name == other.name;
}





Flutter中的字符串encode和decode
var uri = 'https://example.org/api?foo=some message';
var encoded = Uri.encodeComponent(uri);             
debugPrint(encoded);//https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message
var decoded = Uri.decodeComponent(encoded);
debugPrint(decoded);//https://example.org/api?foo=some message
除了上面的api外，还有encodeFull和decodeFull:
var encoded = Uri.encodeFull(uri);
var encoded = Uri.decodeFull(uri);


等待多个Future
有时代码逻辑需要调用多个异步函数，并等待它们全部完成后再继续执行。使用 Future.wait() 静态方法管理多个 Future 以及等待它们完成：
Future<void> deleteLotsOfFiles() async =>  ...
Future<void> copyLotsOfFiles() async =>  ...
Future<void> checksumLotsOfOtherFiles() async =>  ...

await Future.wait([
deleteLotsOfFiles(),
copyLotsOfFiles(),
checksumLotsOfOtherFiles(),
]);
print('Done with all the long steps!');



AndroidStudio4.1.0的sdk位置：
local.properties:
sdk.dir=/Users/wj/Library/Android/sdk

grade-wrapper.properties:
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-5.4.1-all.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists


最新版的AndroidStudio:

Local.properies
sdk.dir=/Users/wj/Library/Android/sdk
flutter.sdk=/Users/wj/cuiboye/Flutter-Tools/FlutterSDK/flutter
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1

grade-wrapper.properties:
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=file:///Users/wj/cuiboye/Flutter-Tools/gradle-8.1.1-all.zip


Typora

AndroidStuido4.1.0:
.gradle
.android
上面这两个放在 User/wj下面
Android放在/Users/wj/Library/Android

vim ~/.bash_profile


//Android相关的环境配置
export ANDROID_HOME=/Users/wj/Library/Android/sdk

export PATH=${PATH}:${ANDROID_HOME}/platform-tools

export PATH=${PATH}:{ANDROID_HOME}/tool
export PATH=${PATH}:{ANDROID_HOME}/platform-tools/dmtracedump


// 配置 flutter、dart 环境变量，不配置这个不能使用flutter相关命令
export FLUTTER_HOME=/Users/wj/cuiboye/Flutter-Tools/FlutterSDK/flutter
export PATH=$PATH:/Users/wj/cuiboye/Flutter-Tools/FlutterSDK/flutter/bin
export PATH=$PATH:/Users/wj/cuiboye/Flutter-Tools/FlutterSDK/flutter/bin/cache/dart-sdk/bin

修改好后点击esc退出编辑，在任意位置输入：“:wq”来保存并退出文件（键盘输入引号内的内容，注意为英文键盘）
退出后，需执行以下命令使配置文件生效
source ~/.bash_profile
使用以下命令，可查看环境变量配置文件是否更改成功
open -e ~/.bash_profile
执行相关命令，验证环境变量是否生效。例如：python3 --version等


设置距离底部的安全区域：
MediaQuery.paddingOf(context).bottom,



性能优化相关：
1）避免在build()方法中进行重复且耗时的工作，因为当父widget重建时，子widget的build()方法会被频繁的调用。
2）避免在一个超长的build()方法中返回一个过于庞大的widget，可以把他们分拆成不同的widget并进行封装；并且避免在widget树的更高层级中调用setState()，进行局部刷新。
3）尽可能的在widget上使用const构造函数，这将让flutter的widget重建时间大大缩短。
4）在构建可服用的UI代码时，最好使用StatelessWidget而不是函数。
5）尽量减少使用不透明度和裁剪
Opacity：对于 0.0 和 1.0 以外的不透明度值，这个类绘制比较昂贵，因为它需要将子项绘制到中间缓冲区中。对于值 0.0，根本不绘制子项。对于值 1.0，将立即绘制子项，无需中间缓冲区。
对不透明度小部件进行动画处理会直接导致小部件（可能还有其子树）重建每个帧，这不是很有效。考虑使用以下替代小部件之一：
AnimatedOpacity，它在内部使用动画来有效地设置不透明度的动画。
要在图像中实现淡入淡出，请使用FadeTransition，它使用提供的动画来有效地设置不透明度的动画。

如果仅需要使用 0.0 到 1.0 之间的不透明度合成单个图像或颜色，则直接使用它们而不使用不透明度小部件会快得多 。
例如，Container(color: Color.fromRGBO(255, 0, 0, 0.5))比 快得多Opacity(opacity: 0.5, child: Container(color: Colors.red))。
还比如；
Image.network(
'https://raw.githubusercontent.com/flutter/assets-for-api-docs/master/packages/diagrams/assets/blend_mode_destination.jpeg',
color: const Color.fromRGBO(255, 255, 255, 0.5),
colorBlendMode: BlendMode.modulate
)
直接绘制具有不透明度的图像或颜色比在其上使用不透明度更快 ，因为不透明度可以将不透明度应用于一组小部件，因此将使用昂贵的屏幕外缓冲区。将内容绘制到离屏缓冲区中也可能会触发渲染目标切换，并且这种切换在较旧的 GPU 中特别慢。
也可以看看：

Visibility，它可以更有效地隐藏子项（尽管不那么巧妙，因为它要么可见，要么隐藏，而不是允许分数不透明度值）。具体来说，Visibility.maintain 构造函数相当于使用值为 0.0或的不透明度小部件1.0。
ShaderMask，它可以对其子项应用更精细的效果。
Transform，在绘制时对其子部件应用任意变换。
SliverOpacity，该小部件的银色版本

如果要实现一个圆角，不要使用裁剪来得到圆角的效果，而是要使用很多widget都提供的borderRadius属性。

6）GridView和ListView
不要直接使用GridView和ListView的构造方法来加载列表，这样会将所有的数据全都加载出来（包含屏幕外的数据），GridView和ListView的构造函数只适用于短列表，对于具有大量列表项的长列表，需要用 ListView.builder 构造函数来创建，ListView.builder构造函数只在列表项从屏幕外滑入屏幕时才去创建列表项。

如果可能的话，为item设置大小绘制会更加快，因为这样就不需要繁琐的计算item的大小了。

DevTools可以查看性能视图。

ListView中字元素的生命周期：
布局列表时，将根据现有小部件（例如使用默认构造函数时）或惰性提供的小部件（例如使用 ListView.builder 构造函数时）延迟创建可见子元素、状态和渲染对象。当子元素滚动到视图之外时，关联的元素子树、状态和渲染对象将被销毁。当向后滚动时，列表中同一位置的新子项将与新元素、状态和渲染对象一起延迟重新创建。

保持ListView的状态：
1）KeepAlive：让KeepAlive成为需要保留的列表子控件子树的根控件。KeepAlive小部件将子子树的顶部渲染对象子标记为保持活动。当关联的顶部渲染对象滚动到视图之外时，列表会将子级的渲染对象（以及扩展的其关联的元素和状态）保留在缓存列表中，而不是销毁它们。当滚动回到视图中时，渲染对象将按原样重新绘制（如果在此期间没有将其标记为脏）。仅当addAutomaticKeepAlives和addRepaintBoundaries 为 false 时才有效。
2）使用AutomaticKeepAlive小部件（当为true时默认插入 addAutomaticKeepAlives）。AutomaticKeepAlive允许后代小部件控制子树是否实际上保持活动状态。此行为与KeepAlive形成对比，后者将无条件地保持子树处于活动状态。
例如，EditableText小部件向其列表子元素子树发出信号，使其在其文本字段具有输入焦点时保持活动状态。如果它没有焦点并且没有其他后代通过 KeepAliveNotification 发出保持活动的信号 ，则列表子元素子树将在滚动时被销毁。
AutomaticKeepAlive后代通常使用AutomaticKeepAliveClientMixin来发出信号使其保持活动状态，然后实现 AutomaticKeepAliveClientMixin.wantKeepAlive getter 并调用 AutomaticKeepAliveClientMixin.updateKeepAlive。
事例可以查看flutter_money的KeepAliveWrapper类

如果要为SliverList添加padding，可以让SliverList成为SliverPadding的子项。

对空列表的特殊处理
在 Flutter 中实现此目的的最佳方法是 在构建时有条件地将ListView替换为您需要为空列表状态显示的任何小部件：
return Scaffold(
appBar: AppBar(title: const Text('Empty List Test')),
body: itemCount > 0
? ListView.builder(
itemCount: itemCount,
itemBuilder: (BuildContext context, int index) {
return ListTile(
title: Text('Item ${index + 1}'),
);
},
)
: const Center(child: Text('No items')),
);

ScrollNotification和NotificationListener，可用于在不使用ScrollController 的情况下监视滚动位置。
SingleChildScrollView：简单的滚动列表，一般和Column一起使用，用户内容不多的情况。

7）涉及到StatefulWidget相关的性能
第一个是在State.initState中分配资源并在State.dispose中销毁它们。
第二个是缩小组件刷新范围以及减少组件刷新。
第三是尽可能的使用const修饰组件，这相当于缓存了组件。
第四是避免更改创建的子树的深度或更改子树中任何组件的类型，这是因为更改子树的深度需要重建、布局和绘制整个子树，而仅更改属性将需要对渲染树进行尽可能少的更改。例如通过一个布尔值来控制组件的显示和隐藏远不如使用Visibility实现性能好，因为使用布尔值控制组件的显示和隐藏会更改组件的结构。
第五个：当创建可重用的 UI 时，使用类创建组件而不要使用函数。例如，如果有一个函数用于构建小部件，则State.setState调用将要求 Flutter 完全重建返回的包装小部件。如果改用Widget，Flutter 将能够有效地仅重新渲染那些真正需要更新的部分。更好的是如果创建的 widget 是const，Flutter 会短路大部分重建工作。

8）渲染性能
由于 Flutter 自带的 Skia 引擎以及它能够快速创建和处理组件的能力， Flutter 应用在默认情况下就能保证拥有良好的性能，因此我们只需避开常见的陷阱就可以获得出色的性能。



Get和Provider
通过 Flutter 树机制 解决，例如 Provider；
通过 依赖注入，例如 Get。

factory：
1）factory 关键词 可以用来修饰 Dart 类的构造函数，意为 工厂构造函数，它能够让 类 的构造函数天然具有工厂的功能。
普通的工厂模式为：
class SimpleFactory {
/// 工厂方法
static Product createProduct(int type) {
if (type == 1) {
return ConcreteProduct1();
}
if (type == 2) {
return ConcreteProduct2();
}
return ConcreteProduct();
}
}
调用：
void main() {
final Product product = SimpleFactory.createProduct(1);
print(product.name); // ConcreteProduct1
}

使用factory：
1）使用factory构建工厂构造模式
class Product {
/// 工厂构造函数（修饰 create 构造函数）
factory Product.createFactory(int type) {
if (type == 1) {
return Product.product1;
} else if (type == 2) {
return Product._concrete2();
}
return Product._concrete();
}

/// 命名构造函数
Product._concrete() : name = 'concrete';

/// 命名构造函数1
Product._concrete1() : name = 'concrete1';

/// 命名构造函数2
Product._concrete2() : name = 'concrete2';

String name;
}
使用：
void main() {
final Product product = SimpleFactory.createProduct(1);
print(product.name); // ConcreteProduct1
}
factory 修饰的构造函数需要返回一个当前类的对象实例，我们可以根据参数调用对应的构造函数，返回对应的对象实例。
class Product {
/// 工厂构造函数（修饰 create 构造函数）
factory Product.createFactory(int type) {
if (type == 1) {
return Product.product1;
} else if (type == 2) {
return Product._concrete2();
}
return Product._concrete();
}
/// 命名构造函数
Product._concrete() : name = 'concrete';

/// 命名构造函数1
Product._concrete1() : name = 'concrete1';

/// 命名构造函数2
Product._concrete2() : name = 'concrete2';

String name;
}

void main() {
//如果没有factory修饰，那么createFactory方法将不能返回一个类的对象实例
Product product = Product.createFactory(1);
print(product.name); // concrete1
}

2）使用factory实现单例模式
工厂构造函数也并不要求我们每次都必须生成新的对象，我们也可以在类中预先定义一些对象供工厂构造函数使用，这样每次在使用同样的参数构建对象时，返回的会是同一个对象
class Product {
/// 工厂构造函数
factory Product.create(int type) {
if (type == 1) {
return product1;
} else if (type == 2) {
return product2();
}
return Product._concrete();
}

static final Product product1 = Product._concrete1();
static final Product product2 = Product._concrete2();
}
3）factory 除了可以修饰命名构造函数外，也可以修饰默认的非命名构造函数
class Product {
factory Product(int type) {
return Product._concrete();
}

String? name;
}
使用：
void main() {
Product product = Product(1);
print(product.name); // concrete1
}
不过这样的用法很容易造成使用者的困扰，因此，我们应当尽量使用特定的 命名构造函数 作为工厂构造函数

平台共享 assets：
从Android中加载asset/images中的文件（加载Flutter项目中目录结构的文件）:
AssetManager assetManager = registrar.context().getAssets();
String key = registrar.lookupKeyForAsset("icons/heart.png");
AssetFileDescriptor fd = assetManager.openFd(key);





20230904：
1）最新的渲染引擎为Impeller，可以在IOS和Android上面使用，Flutter引擎将底层C++代码包装成Dart代码，通过dart:ui暴露给Flutter框架层，包含用于驱动输入，图形和文本渲染的类。
2）渲染：在绘制内容时，需要调用 Android 框架的 Java 代码。 Android的系统库提供了可以将自身绘制到Canvas对象的组件，接下来Android就可以使用由C/C++编写的 Skia 图像引擎，调用 CPU 和 GPU 完成在设备上的绘制。
Flutter将图像内容的Dart代码被编译为机器码，并使用 Skia 进行渲染。 Flutter 同时也嵌入了自己的 Skia引擎（最新渲染引擎为Impeller），让开发者能在设备未更新到最新的系统时，也能跟进升级自己的应用，保证稳定性并提升性能。

RenderObjectElement 是底层 RenderObject 与对应的 widget 之间的桥梁。
任何 widget 都可以通过其 BuildContext 引用到 Element，它是该 widget 在树中的位置的句柄。类似 Theme.of(context) 方法调用中的 context，它作为 build() 方法的参数被传递。

在渲染树中，每个节点的基类都是 RenderObject，该基类为布局和绘制定义了一个抽象模型。

在构建阶段，Flutter 会为 Element 树中的每个 RenderObjectElement 创建或更新其对应的一个从 RenderObject 继承的对象。

在进行布局的时候，Flutter 会以深度优先遍历方式遍历渲染树，并 将限制以自上而下的方式从父节点传递给子节点。子节点若要确定自己的大小，则必须遵循父节点传递的限制。子节点的响应方式是在父节点建立的约束内将大小以自下而上的方式传递给父节点。在遍历完一次树后，每个对象都通过父级约束而拥有了明确的大小，随时可以通过调用 paint() 进行渲染。

所有 RenderObject 的根节点是 RenderView。在垂直同步信号到来平台需要渲染新的一帧内容时，会调用一次 compositeFrame() 方法，它是 RenderView 的一部分。该方法会创建一个 SceneBuilder 来触发当前画面的更新。当画面更新完毕，RenderView 会将合成的画面传递给 dart:ui 中的 Window.render() 方法，控制 GPU 进行渲染。

Flutter 的界面构建、布局、合成和绘制全都由 Flutter 自己完成，而不是转换为对应平台系统的原生组件。

平台通道：通过创建一个常用的通道（封装通道名称和编码），开发者可以在 Dart 与使用 Kotlin/Java语言编写的平台组件之间发送和接收消息。数据会由 Dart 类型（例如 Map）序列化为一种标准格式，然后反序列化为 Kotlin（例如 HashMap）。


通过比较新旧Widget的runTimeType和Key，这样就可能找到在所有不匹配子节点的。然后框架将旧Widget的key 放入一个哈希表中。接下来，框架将会遍历新的子Widget能够匹配哈希表中的 key。无法匹配的Widget将会被丢弃并从头开始重建，匹配到的Widget则使用它们新的 widget 进行重建。


Flutter多线程下载：
1）在pubspec.yaml中添加依赖：
flutter_downloader: ^1.11.2
android_path_provider: ^0.3.0
device_info_plus: ^8.0.0
2）AndroidManifest.xml中的配置：
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
xmlns:tools="http://schemas.android.com/tools"
package="com.example.flutter_money">
<!-- 需要的权限 -->
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" tools:ignore="ScopedStorage"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.INTERNET" />

    <application
        android:usesCleartextTraffic="true"//需要添加
        android:requestLegacyExternalStorage="true"//android10及以上需要添加
        android:networkSecurityConfig="@xml/network_security_config"
        android:label="flutter_money"
        android:name=".MyApplication"
        android:icon="@mipmap/ic_launcher">
        
        <provider
            android:name="vn.hunghd.flutterdownloader.DownloadedFileProvider"
            android:authorities="${applicationId}.flutter_downloader.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths"/>
        </provider>
        <!-- Begin FlutterDownloader customization -->
        <!-- disable default Initializer -->
        <provider
            android:name="androidx.startup.InitializationProvider"
            android:authorities="${applicationId}.androidx-startup"
            android:exported="false"
            tools:node="merge">
            <meta-data
                android:name="androidx.work.WorkManagerInitializer"
                android:value="androidx.startup"
                tools:node="remove" />
        </provider>

        <!-- declare customized Initializer -->
        <provider
            android:name="vn.hunghd.flutterdownloader.FlutterDownloaderInitializer"
            android:authorities="${applicationId}.flutter-downloader-init"
            android:exported="false">
            <!-- changes this number to configure the maximum number of concurrent tasks -->
            <meta-data
                android:name="vn.hunghd.flutterdownloader.MAX_CONCURRENT_TASKS"
                android:value="5" />
        </provider>
    </application>
</manifest>

3）main入口设置：
//这个回调设置为全局的
@pragma('vm:entry-point')
void downloadCallback(
String id,
int status,
int progress,
) {
print(
'Callback on background isolate: '
'task ($id) is in status ($status) and process ($progress)',
);
//更新UI
IsolateNameServer.lookupPortByName('downloader_send_port')
?.send([id, status, progress]);
}

void main() async{
WidgetsFlutterBinding.ensureInitialized();
// await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
await FlutterDownloader.initialize(debug: true);
FlutterDownloader.registerCallback(downloadCallback, step: 1);//回调监听
}

4）检查是否有下载的权限
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

5）获取下载的权限后设置下载目录
Future<void> _prepareSaveDir() async {
_localPath = (await _getSavedDir())!;
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

    final dirs = [
      temporary,
      applicationSupport,
      library,
      applicationDocuments,
      downloads
    ];
    return dirs;
}

6）开始下载，暂停，取消，继续下载
//任务的状态未知或已损坏
if (task.status == DownloadTaskStatus.undefined) {
debugPrint('aaaaaa');
_requestDownload(task);//开始下载
} else if (task.status == DownloadTaskStatus.running) {
_pauseDownload(task);
debugPrint('_pauseDownload');//暂停下载
} else if (task.status == DownloadTaskStatus.paused) {
_resumeDownload(task);
debugPrint('_resumeDownload');//继续下载
} else if (task.status == DownloadTaskStatus.complete ||
task.status == DownloadTaskStatus.canceled) {
_delete(task);//下载完成后删除下载了
debugPrint('_delete(task)');
} else if (task.status == DownloadTaskStatus.failed) {
debugPrint('_retryDownload');
_retryDownload(task);
}



//开始下载
Future<void> _requestDownload(TaskInfo task) async {
await [Permission.storage,].request();
debugPrint('_localPath $_localPath');
task.taskId = await FlutterDownloader.enqueue(
url: task.link!,//下载url
headers: {'authaaa': 'test_for_sql_encoding123123213'},//headers
savedDir: _localPath,//存储目录，如 /storage/emulated/0/Download
// savedDir: '/storage/emulated/0/Download',
showNotification: false,//是否在通知栏显示下载进度
//是否存储在外部目录，在Android上的目录为：/storage/emulated/0/Download
saveInPublicStorage: _saveInPublicStorage,
);
}

//取消和删除下载，只不过取消下载不用做是否下载完成的判断
Future<void> _delete(TaskInfo task) async {
debugPrint('没有下载完成然后取消下载了');
await FlutterDownloader.remove(
taskId: task.taskId!,
shouldDeleteContent: true,
);
await _prepare();
setState(() {});
}

//暂停下载
Future<void> _pauseDownload(TaskInfo task) async {
await FlutterDownloader.pause(taskId: task.taskId!);
}

//继续下载
Future<void> _resumeDownload(TaskInfo task) async {
final newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
task.taskId = newTaskId;
}
//重新尝试下载
Future<void> _retryDownload(TaskInfo task) async {
await Permission.storage.request();
final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
task.taskId = newTaskId;
}













1.Flutter为什么可以一套代码运行在多个平台上？Flutter跨平台原理？Flutter的性能为什么可以媲美原生？

先说下android系统的绘制，Android系统的绘制Bitmap和Canvas都是调用skia引擎来实现的，首先拿到xml文件，通过DOM解析，xml想要变成页面上可以看到的东西，就得将xml解析出来，然后再通过反射构建TextView，然后调用TextView中的onDraw()方法，只有调用onDraw()方法才能调用canvas，最后通过skia将图像渲染到屏幕上。

Flutter通过将drat语言转换为skia可以认识的API，Flutter的启动和Android的启动是一样的，入口都是MainActivity，MainActivity继承自FlutterActivity，FlutterActivity的onCreate方法中将FlutterActivityAndFragmentDelegate这个delegate添加到了setContantView中，在FlutterActivityAndFragmentDelegate中的onCreateView将FlutterSurfaceView添加进了FlutterView中，FlutterView其实就是一个FrameLayout，FlutterSurfaceView继承自SurfaceView，相当于是原生提供了一个画布，让Flutter可以在这个画布上面任意的操作。

Flutter提供了一套Dart API，在底层通过OpenGL这种跨平台的绘制库调用操作系统的API，OpenGL调用显卡驱动告诉GPU干活，GPU经过各种计算把最终的图像渲染出来。由于Dart API也是调用了操作系统的API，不需要像原生那样进行DOM解析和反射组件，所以性能和原生接近。虽然Dart显示调用了OpenGL，OpenGL才会调用操作系统API，但是它仍然是原生渲染，因为OpenGL只是操作系统API的一个封装库，它并不像WebView渲染那样需要JavaScript运行环境和CSS渲染器，所以不会有性能损失。

垂直同步信号：

显示器上的图像是由像素点构成的，为了更新显示画面，显示器是以固定的频率刷新（从GPU取数据），手机屏幕的刷新频率是60Hz，当一帧图像绘制完毕后准备绘制下一帧时，显示器会发出一个垂直同步信号（VSync,16毫秒发送一次），60Hz就会在一秒内发出60次（每次差不多为16毫秒）这样的信号，而这个信号主要是用于同步CUP、GPU和显示器的。CUP将计算好的显示内容交给GPU，GPU渲染后放入帧缓冲区，然后视频控制器按照同步信号从帧缓冲区取帧数据传递给显示器显示。

Skia：
Skia引擎是图像渲染引擎，Skia能实现用户手指交互与渲染，文字排版引擎等。在安卓上，系统自带了Skia，在每个平台上都包含了Skia引擎，Flutter是基于Skia引擎实现跨平台的。

Flutter的架构（从上到下）：
1）框架层：可以理解为UI层，最上面的是Material和Cupertino库，提供符合Material和iOS的设计规范，然后就是widget层，再往下就是渲染层，用于基于widget树生成渲染树，再往下就是底层的基础层（这个在开发中很少打交道）。
2）引擎层：引擎层是flutter的核心部分，核心api的底层实现，比如图形绘制，文本布局，网络请求，io操作，dart运行环境创建等。
这一层有个很重要的部分就是图片渲染，所有的widget最终的目的都是为了绘制在屏幕上，这块的底层实现就是依靠Skia，Skia也是开源库，同时兼容了多个平台。所有flutter UI层的代码，都是用dart语言编写的，在发布的时候，会编译成native语言，然后交给Skia去渲染。

Flutter和原生交互使用MethodChnnel的核心实现也是在引擎层跟原生交互，需要各个平台去适配，比如高德官方的flutter地图插件不支持POI检索，就需要flutter用MethodChnnel发起一个方法调用，ios和Android接收这个方法，各自集成原生的地图SDK，然后通过原生的SDK调用POI功能，再把结果返回给flutter。

3）嵌入层：嵌入层可以与原生地层操作系统进行交互，可以根据不同的平台单独实现，实现语言也不一样，可以把嵌入层理解为一个壳子，flutter应用本体是一个模块，套一个Android的壳，就是一个Android的应用，套一个ios的壳，就是一个ios的应用。

总结：flutter用一个跨平台的开发语言Dart来开发UI层，然后核心功能用C++实现，最后用嵌入层做一层包装，适配各个不同的平台，由于UI部分，都是在框架层，从而实现跨平台的实现。另外由于flutter是直接跟原生接口打交道，所以在性能上也会媲美原生app，这也是Flutter为什么可以跨平台的原因。

跟Android、iOS原生开发类似，Flutter用dart语言实现一整套UI控件。Flutter先将控件树转成渲染树，然后交由skia库绘制界面，Skia的绘制页面是通过OpenGL底层图形接口来完成的，Skia应用广泛并且可以跨平台，Skia屏蔽了底层图形API接口的差异，可以用于Flutter和Android操作系统，还支持Mac,IOS,Widdows和浏览器。

OpenGL（Open Graphics Library”）是目前使用最广泛的跨平台图形API接口，跨平台特性好，大部分操作系统和GPU。Skia在大部分平台采用OpenGL实现GPU绘图，少部分平台调用Metal和vulkan(IOS)。
Metal是苹果公司2014年推出的和 OpenGL类似的面向底层的图形编程接口，只支持iOS。
Vulkan是新一代跨平台的2D和3D绘图应用程序接口（API）,旨在取代OpenGL，理论上性能强于OpenGL。
Skia对上述三种图形接口进行了封装，屏蔽了不同底层图形API接口的差异。OpenGL接口的封为GrGLOpsRenderPass，Metal的封装层为GrMTOpsRenderPass,Vuklan的封装层为 GrVKOpsRenderPass。

Flutter 上的渲染，是先由 Dart 侧主动发起垂直同步信号的请求，而不是被动等待垂直信号的通知。等到垂直同步信号到来后，再通过回调通知Dart进行渲染。


SurfaceView的双缓冲机制使用两个缓冲区分别处理帧的绘制和展示，即当应用绘制下一帧时，它不是直接绘制在屏幕上，而是在一个后备缓冲区中绘制，待所有绘制完成后，将该缓冲区的内容直接绘制在屏幕上以完整的显示帧。在绘制当前帧期间，上一帧仍显示在屏幕上，由此可以看出SurfaceView的双缓冲机制可以避免出现。

SurfaceView和Surface的关系？
Surface对应了一块屏幕缓冲区，Surface中的Canvas是用来画画的场所，就像黑板一样，得到了Surface就得到了Canvas，缓冲区和其他内容，Surface是用来管理数据的。
SurfaceView是把这些数据显示到屏幕上。

2.整个flutter的框架，其实是一个独立的整体，跟原生是独立的，那有些功能，原生已经有成熟的实现了，flutter为了避免重复实现一套，希望可以直接用原生的UI展示在flutter上面flutter为了解决这个问题，使用两个特定的widget来实现 (AndroidView and UiKitView)，实现代码大致如下：
if (defaultTargetPlatform == TargetPlatform.android) {
return AndroidView(
viewType: 'plugins.flutter.io/google_maps',
onPlatformViewCreated: onPlatformViewCreated,
gestureRecognizers: gestureRecognizers,
creationParams: creationParams,
creationParamsCodec: const StandardMessageCodec(),
);
} else if (defaultTargetPlatform == TargetPlatform.iOS) {
return UiKitView(
viewType: 'plugins.flutter.io/google_maps',
onPlatformViewCreated: onPlatformViewCreated,
gestureRecognizers: gestureRecognizers,
creationParams: creationParams,
creationParamsCodec: const StandardMessageCodec(),
);
}
return Text(
'$defaultTargetPlatform is not yet supported by the maps plugin');

3.Widget，Element，Renderobject三棵树的架构关系
Wiwget树和Element树节点是一一对应关系，每一个Widget都会有其对应的Element，但是RenderObject树则不然，只有需要渲染的Widget才会有对应的节点。
Element树相当于一个中间层，它持有Widget和RenderObject的引用。
当Widget不断变化的时候，将新Widget拿到Element来进行对比，看一下和之前保留的Widget类型和key是否相同，如果都一样，那完全没有必要重新创建Element和RenderObject，只需要更新里面的一些属性即可，这样可以以最小的开销更新RenderObject，引擎在解析RenderObject的时候，发现只有属性修改了，那么也可以以最小的开销来做渲染。
简单总结：
Widget树就是配置信息的树
RenderObject树是渲染树，负责计算布局，绘制，Flutter引擎就是根据这棵树来进行渲染的。
Element树作为中间者，管理着Widget的生成和RenderObject的更新操作.



Widget、RenderObject和Elements的关系
Widget：仅用于存储渲染所需要的信息
RenderObject：负责管理布局、绘制等操作
Element：才是这颗巨大的控件树上的实体
Widget会被inflate（填充）到Element，并由Element管理底层渲染树。Widget并不会直接管理状态及渲染，而是通过State这个对象来管理状态。Flutter创建Element得可见树，相对于Widget来说，是可变的，通常界面开发中，我们不用直接操作Eelement，而是由框架层实现内部逻辑。就如一个UI视图树中，可能包含多个TextWidget（Widget被使用多次），但是放在内部视图树的视角，这些TextWidget都是填充到一个个独立的Element中。Element会持有renderObject和widget实例。记住，Widget只是一个配置，RenderObject负责管理布局、绘制等操作，在第一次创建Widget的时候，会对应创建一个Element，然后将该元素插入树中。如果之后Widget发生了变化，则将其与旧的Widget进行比较，并且相应地更新Element。重要的是，Element不会被重建，只是更新而已。



Flutter的绘制流程？
在Flutter中，UI都是一帧一帧的绘制，但这绘制的背后都会经过如下阶段
1.动画与微任务阶段，主要是处理动画及执行一系列微任务
2.构建阶段（build），找出标记为“脏”的节点与布局边界直接的所有节点，并做相应的更新
3.布局阶段，计算Widget的大小及位置的确定
4.compositingBits阶段。重绘之前的预处理操作，检查RenderObject是否需要重绘
5.绘制阶段，根据Widget大小及位置来绘制UI
6.compositing阶段，将UI数据发生给GPU处理
7.semantics阶段，与平台的辅助功能相关
8.finalization阶段，主要是从Element树中移除无用的Element对象及处理绘制结束回调



Widget的作用：
1）Widget的所有方法，都是在同个线程（主线程）按照从外层到内层逐级往里调用，也就是主线程，dart中叫main ioslate
如果在Widget中，有耗时的方法，应该放在异步执行，可以使用compute，或者ioslate提供的异步方法
3）Widget的目的是为了生成对应的element，也就是Widget树是为了生成对应的element树

Widget是如何加载出来的？
Widget的加载，都是因为父Widget对应的Element调用了inflateWidget，然后调用了当前Widget的createElement和mount方法

Widget是如何绘制出来的？

setState的作用？
setState其实就是告诉系统，在下一帧刷新的时候，需要更新当前widget，整个过程，是一个异步的行为，所以下面的三个写法，效果上是一样的。
// 写法一
_counter++;        
setState(() {});

// 写法二
setState(() {  
_counter++;  
});

// 写法三
setState(() {});
_counter++;



在子 widget 树中获取父级 StatefulWidget 的State 对象
1.2通过context获取
context对象有一个findAncestorStateOfType()方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。
// 查找父级最近的Scaffold对应的ScaffoldState对象
ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>()!;
// 打开抽屉菜单
_state.openDrawer();
1.2直接通过of静态方法来获取ScaffoldState
ScaffoldState _state=Scaffold.of(context);
// 打开抽屉菜单
_state.openDrawer();
如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；如果 State不希望暴露，则不提供of方法。







所有的Widget会生成一个Widget树，所有的Element会生成一个Element树，所有的renderObject会生成一个RenderObject树，
Element会持有Widget和RenderObject的引用，Widget和Element是一一对应的，Element和RenderObject不一定是一一对应的。
通过Widget生成Element，通过Element生成renderObject，通过renderObject进行layout和paint来生成layer，最后将
layer交给GPU去加载。

setState()方法：

```
Flutter中的两大组件为StatefulWidget和StatelessWidget，StatefulWidget中组件的状态是可以通过setState()方法来进行修改的，StatelessWidget中不能使用StatelessWidget。这是一个同步方法，通知框架该对象的内部状态发生了变化，对象状态的改变可能会影响子树中的用户界面，这会导致框架会调用build。在框架调用dispose之后调用此方法是错误的，为了避免这种情况，Flutter建议我们可以通过检查mounted属性是否为真来确定调用setState()是否合法。

该方法中会调用StatefulElement的markNeedsBuild方法来标记这个元素会被用来重新构建RenderObject渲染树
当前元素不活跃的话将直接返回，如果已经设置完_dirty则返回，调用BuildOwner的scheduleBuildFor方法将当前元素加入脏数据中，如果已经在脏数据集合中不需要重新添加，如果在脏数据中不存在将当前要改变的元素加入到脏数据_dirtyElements集合中，并标记元素已经放入脏数据集合中，可以看出SetState方法就是将当前的Element放入脏数据集合，而后标记它为脏元素，此时setState方法就处理完了，那么
 是谁来处理的这个脏数据集合呢？这里的脏数据集合其实就是用来记录当前哪些元素需要重新构建RenderObject的属性，从而重
 新实现哪些RenderObject需要重新渲染。通俗的讲就是每当硬件层的垂直同步信号到来将重新实现View树的测量、布局、重绘，然
 后将数据交给Gpu渲染的屏幕上，也就是说每过约16.6666666....ms,脏数据元素会被处理一次，然后清空。
 
 那么垂直同步信号是什么时候被注册的？
  Flutter sdk中的Dart部分最重要的就是binding类，而实现监听同步信号的Binding类为SchedulerBinding这个类，
  最终注册的方法为initInstances-》readInitialLifecycleStateFromNativeWindow-》handleAppLifecycleStateChanged-》scheduleFrame

  Flutter在android中最终通过Choreographer（编排者）注册了垂直同步信号的监听方法，而注册了垂直信号之后，每过16.6毫秒
  最终会回调给Dart层。Flutter这边收到垂直同步信号后：
  1）开始根据标记为脏数据元素重新构建渲染树：将根元素下的所有子元素都生成Element元素和调用对脏数据元素的
  重构方法rebuild，也就是从当前的节点的元素开始构建子元素以及子元素的RenderObject的创建，当然子元素并不一定重新
  创建，这需要和旧的元素去做比较。
  2）重新测量布局和渲染，布局和渲染完成后将绘制的数据发送给GPU渲染。
  pipelineOwner.flushLayout();//确定布局的位置
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();//开始执行画画
  renderView.compositeFrame();//合并图层将绘制的数据发送给Gpu渲染

```

Widget和APP的生命周期：https://blog.csdn.net/eclipsexys/article/details/130097089?spm=1001.2014.3001.5502

BuildContext:

参考链接：https://blog.csdn.net/eclipsexys/article/details/129828429?spm=1001.2014.3001.5502

BuildContext对象表示当前widget在widget树中的上下文，类似于Android中的Context。它实际上是Element，BuildContext接口用于阻止对Element对象的直接操作，它就是为了避免直接操纵Element类而创建的。

比如它提供了从当前 widget 开始向上遍历 widget树以及按照 widget类型 查找父级widget的方法 findAncestorWidgetOfExactType。具体可以查看test2.dart这个文件。

Flutter 在 BuildContext 类中为我们提供了方法进行向上和向下的查找
abstract class BuildContext {
///查找父节点中的T类型的State
T findAncestorStateOfType<T extends State>();
///遍历子元素的element对象
void visitChildElements(ElementVisitor visitor);
///查找父节点中的T类型的 InheritedWidget 例如 MediaQuery 等
T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({ Object aspect })
...... }
这个 BuildContext 对应我们在每个 Widget 的 build(context) 方法中的 context。可以把 context 当做树中的一个实体节点。借助 findAncestorStateOfType 方法，我们可以一层一层向上的访问到 WidgetA，获取到 name 属性。
调用的 findAncestorStateOfType()方法，会一级一级父节点的向上查找，很显然，查找快慢取决于树的深度。而数据共享的场景在 Flutter 中非常常见，比如主题，比如用户信息等，为了更快的访问速度，Flutter 中提供了dependOnInheritedWidgetOfExactType() 方法，它会将 InheritedWidget 存储到 Map 中。不过这两种方法本质上都是通过树机制实现，他们都需要借助 context。



Element是Flutter UI中的一个非常重要的组成，Flutter UI在创建时，会通过Widget的createElement方法创建Element，然后Framework会调用Element实例的mount方法，在这个方法中，根据需要创建RenderObject，并挂载到Element的renderObject属性上，实际的布局和绘制，通常都是通过RenderObject的实现类RenderBox来实现的。

Wdiget测量自身，测量父组件和子组件：https://blog.csdn.net/eclipsexys/article/details/129700802?spm=1001.2014.3001.5502

Flutter布局行为：

首先，上层 widget 向下层 widget 传递约束条件；
然后，下层 widget 向上层 widget 传递大小信息。
最后，上层 widget 决定下层 widget 的位置。

紧约束和松约束：

```
tight（紧约束）：当 max 和 min 值相等时，这时传递给子类的是一个确定的宽高值。
紧约束使用的地方主要有两个：
1）Container的child == null && (constraints == null || !constraints!.isTight)
2）另一个ModalBarrier，这个组件我们不太熟悉，但查看调用发现被嵌套在了Route中，所以每次我们push一个新Route的时候，默认新的页面就是撑满屏幕的模式。
loose（松约束）：当 minWidth 和 minHeight 为 0，这时传递给子类的是一个不确定的宽高值
1）在我们最常使用的Scaffold组件中就采用了这种布局，所以Scaffold对于子布局传递的是一个松的约束。
如果最大值和最小值都为0， 那它即是紧约束也是松约束
```

在Flutter中，每个组件都有自己的布局行为：

Root，传递紧约束，即它的子元素，必须是设备的尺寸，不然Root根本不知道未被撑满的内容该如何显示

Container，在有Child的时候，传递紧约束，即子元素必须和它一样大，否则Container也不知道该怎么放置Child

对于Container来说：

- 有Child就选择Child的尺寸（有设置alignment时会将约束放松）
- 没有Child就撑满父级空间（父级空间为Unbound时，尺寸为0）

Center，将紧约束转换为松约束，Center可以将父级的紧约束，变松，这样它的子元素可以选择放置在居中的位置，而子元素具体有多大？只要不超过父容器大小都可以，除了Center以外，还可以使用UnconstrainedBox，Align，这些都可以将紧约束放松为松约束。

单个Child的容器布局方式，我们称之为Box布局，相对而言，类似Column和Row这样的布局方式，我们称之为Flex布局。

Row为例，Row对child的约束会修改为松约束，从而不会限制child在主轴方向上的尺寸，所以当Row内的Child宽度大于屏幕宽度时，就会产生内容溢出的警告。

当 Column 包裹 ListView 会出现异常 `Vertical viewport was given unbounded height.` 原因 Column 和 ListView 都是 `unbounded` height。无限高度组件嵌入无限高度组件就报异常了解决如下。对 ListView 用 Expanded 或者 Flexible 包裹，转为弹性组件，也即是占完Column 剩余的空间即可。

如果所有 Row 的子级都被包裹了 `Expanded` widget，那么每一个Widget的权重都是1，Expanded忽略了其子 Widget 想要的宽度。

`Row` 要么使用子级的宽度，要么使用`Expanded` 和 `Flexible` 从而忽略子级的宽度。

```
//屏幕强制 Scaffold 变得和屏幕一样大，所以 Scaffold 充满屏幕。然后 Scaffold 告诉 Container 可以变为任意大小，但不能超出屏幕。
return Scaffold(
  body: Container(
    color: Colors.blue,
    child: Column(
      children: [
        Text("sdfds"),
        Text("sdfds2"),
      ],
    ),
  ),
);
结果：宽度包裹，高度充满。
当一个 widget 告诉其子级可以比自身更小的话，我们通常称这个 widget 对其子级使用 宽松约束（loose）。

如果你想要 Scaffold 的子级变得和 Scaffold 本身一样大的话，你可以将这个子级外包裹一个 SizedBox.expand。
```

从如何处理约束的角度来看，有以下三种类型的渲染框：

- 尽可能大。比如Center和 ListView的渲染框。
- 与子 widget 一样大，比如Opacity的渲染框。
- 特定大小，比如 Image和Text 的渲染框。

Widget大概可以分为三类组合类、代理类、绘制类

组合类：StatefulWidget，StatelessWidget

代理类：InheritedWidget

绘制类：RenderObjectWidget，RenderObjectWidget是所有需要渲染的Widget的基类。

Flutter中有两大布局协议BoxConstraints和SliverConstraints。对于非滑动的控件例如Padding，Flex等一般都使用BoxConstraints盒约束。

Row和Column不同的情况（子节点没有设置flex的时候）：

1）如果cross轴上alignment等于CrossAxisAlignment.stretch（即填满纵轴，默认不是这种模式）

如果主轴方向是水平，则垂直方向为高度强制为当前的最大约束值

如果主轴是垂直方向，则水平方向宽度强制为当前的最大约束值

2）如果cross轴上alignment等于CrossAxisAlignment.center(默认)，start,end,baseline

如果主轴方向是水平，则垂直方向高度为松约束范围0-maxHeight

如果主轴方向是垂直，则水平方向宽度为为松约束0-maxWidth

```
//这种布局是左边是垂直方向的2个文本，右边是一个文本（右边的这个文本在左侧的水平中间位置）
Row(
  children: [
    Column(
      mainAxisSize: MainAxisSize.min,//这里需要设置为MainAxisSize.min，否则右侧的会在整个屏幕的中间（垂直方向）
      children: [
        Text("sdfds"),
        Text("sdfds2"),
      ],
    ),
    Text("sdfdsfd")
  ],
)
```

```
//在行列布局中，如何使得所有的部件跟宽度/高度最大的部件同宽/同高呢？
return Scaffold(
    body:Scaffold(
      appBar: AppBar(title: Text('IntrinsicWidth')),
      body: Center(
      //同理，如果你想所有的部件的高度跟最高的部件一样高，你需要结合 IntrinsicHeight 和 Row 来实现。
        child: IntrinsicWidth(//没有这个的话，垂直方向的3个按钮的宽度将不一样
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('Short'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('A bit Longer'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('The Longest text button'),
              ),
            ],
          ),
        ),
      ),
    )
);

https://blog.51cto.com/jdsjlzx/5921731
https://blog.51cto.com/jdsjlzx/category1.html
```



Flutter Inspector的使用：AndroidStudio中打开View-Tool Windows-Flutter Inspector



Flutter适配安全区域的方法：

1）使用SafeArea组件，SafeArea通过MediaQuery来检测屏幕尺寸，使应用程序的大小能与屏幕适配。

2）MaterialApp+Scaffold

3）MediaQuery

flutter packages pub deps      查看项目的依赖树。 比如我们在项目中引入了一个支持网络缓存的图片库cached_network_image: ^0.5.0+1





========================State============================
在Flutter中，一个 StatefulWidget 类会对应一个 State类，State表示与其对应的 StatefulWidget 要维护的状态，State中的保护的状态信息可以：

1)在widget构建时可以被同步读取；
2)在widget生命周期改变时可以被读取，当 State 被改变时，可以手动调用 其 setState() 方法通知 Flutter framework状态发送改变，Flutter framework在收到消息后，会重新调用其 build 方法重新构建 widget 树，从而达到更新UI的目的.
State 中有两个常用属性：

widget: 它表示与该State 实例关联的 widget 实例，由 Flutter framework 动态设置，不过这种关联并非永久，因为在应用生命周期中，UI树上的某一个节点 widget 实例在重新构建时可能会变化，但 State 实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter framework 会动态设置State, widget为新的 widget 实例。
context： StatefulWidget 对应的 BuildContext, 作用同 StatelessWidget 的 BuildContext一致。
State生命周期
initState()
当 Widget 第一次插入到 Widget树时被调用。对于每一个 State 对象，Flutter framework只会调用一次回调。适合做一些一次性的操作，比如状态初始化，订阅子树的事件通知等。

不能在 该回调 中调用 BuildContext.dependOnInheritedWidgetOfExactType,原因是在初始化完成后， Widget 树中的 InheritFromWidget 也可能会发生变化，所以正确的做法应该在 build 方法或 didChangDependencied() 中调用它。

didChangeDependencies()
当State 对象的依赖发生变化时被调用。

build()
主要用于构建 Widget 子树时被调用，它会在如下场景被调用：

在调用 initState 之后
调用 didUpdateWidget 之后
调用 setState 之后
调用 didChangeDependencies 之后
在 State 对象从树中一个位置移除后，又重新插入到树的其它位置之后
reassemble()
此回调是专门为开发调试而提供，在热重载 (hot reload) 时被调用，此回调在 release 下永远不会被调用。

didUpdateWidget()
widget重建时，如果新旧 widget 的key相同就会调用此方法

deactivate()
当State对象从树中被移除时，会调用此方法。在一些场景下，Flutter framework 会将State 对象重新插入到树中，如包含此 State 对象的子树在树的一个位置移动到了另一个位置时。如果移除后没有重新插入到树中则紧挨着会调用 disponse 方法。

dispose()
当State对象从树中被永久移除时调用，通常用于在此回调中释放资源。

如何获取State对象?
由于 StatefulWidget 的具体逻辑都在其对应的 State 中，所以很多时候，我们需要获取 StatefulWidget 对应的 State对象来调用一些方法，比如 Scaffold 组件对应的状态类 ScaffoldState 中就定义了打开 SncakBar(路由底部提示条)的方法，我们有两种方法在子 widget 树中获取 父级 StatefulWidget的 State 对象。



Flutter生命周期

一、Flutter 中两个主要的 Widget

StatelessWidget（无状态组件）
无状态组件是不可变的，这意味着它们的属性不能变化，所有的值都是最终的。可以理解为将外部传入的数据转化为界面展示的内容，只会渲染一次。 对于无状态组件生命周期只有 build 这个过程。

无状态组件的构建方法通常只在三种情况下会被调用：小组件第一次被插入树中，小组件的父组件改变其配置，以及它所依赖的 InheritedWidget 发生变化时。

StatefulWidget（有状态组件）：

初始化显示页面的时候执行的生命周期，主要是

initState
didChangeDependencies
build
调用setState 刷新页面的时候执行的生命周期，主要是

didUpdateWidget
build

当调用setState 的时候，会将对应的Element 标记为脏，等到下一帧到来的时候刷新该Element。实际就是在下一帧的时候调用脏Element 的rebuild 的方法。

关闭页面的时候执行的声明周期，主要是

deactivate
dispose

有状态组件持有的状态可能在 Widget 生命周期中发生变化，是定义交互逻辑和业务逻辑。可以理解为具有动态可交互的内容界面，会根据数据的变化进行多次渲染。

StatefulWidget 类本身是不可变的，但是 State 类在 Widget 生命周期中始终存在。StatefulWidget 将其可变的状态存储在由 createState 方法创建的 State 对象中，或者存储在该 State 订阅的对象中。

StatefulWidget 生命周期(也可以说是State类中的生命周期方法，因为这些方式是在State中调用的)

createState：
该函数为 StatefulWidget 中创建 State 的方法，当 StatefulWidget 被创建时会立即执行 createState。createState 函数执行完毕后表示当前组件已经在 Widget 树中，此时有一个非常重要的属性 mounted 被置为 true。

createState 是在StatefulElement的构造方法中调用的，也就是创建StatefulElement的时候就创建了对应的State,而且这个State 在之后保持不变。

initState：
该函数为 State 初始化调用，只会被调用一次，因此，通常会在该回调中做一些一次性的操作，如执行 State 各变量的初始赋值、订阅子树的事件通知、与服务端交互，获取服务端数据后调用 setState 来设置 State。

didChangeDependencies：
当State对象的依赖发生变化时会被调用；例如：在之前`build()` 中包含了一个`InheritedWidget` （第七章介绍），然后在之后的`build()` 中`Inherited widget`发生了变化，那么此时`InheritedWidget`的子 widget 的`didChangeDependencies()`回调都会被调用。典型的场景是当系统语言 Locale 或应用主题改变时，Flutter 框架会通知 widget 调用此回调。需要注意，组件第一次被创建后挂载的时候（包括重创建）对应的`didChangeDependencies`也会被调用。

build：
主要是返回需要渲染的 Widget，由于 build 会被调用多次，因此在该函数中只能做返回 Widget 相关逻辑，避免因为执行多次而导致状态异常。
使用场景：
a.在调用initState()之后。
b.在调用didChangeDependencies()之后。
c.在调用setState()之后。
d.在调用didUpdateWidget()之后。
e.在State对象从树中一个位置移除后（会调用deactivate）又重新插 入 到树的其它位置之后。

didUpdateWidget
该函数主要是在`组件重新构建，比如说热重载`，父组件发生 build 的情况下，子组件该方法才会被调用，其次`该方法调用之后一定会再调用本组件中的 build 方法。

在 widget 重新构建时，Flutter 框架会调用`widget.canUpdate`来检测 widget 树中同一位置的新旧节点，然后决定是否需要更新，如果`widget.canUpdate`返回`true`则会调用此回调。正如之前所述，`widget.canUpdate`会在新旧 widget 的 `key` 和 `runtimeType` 同时相等时会返回true，也就是说在在新旧 widget 的key和runtimeType同时相等时`Element会被复用，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element。didUpdateWidget()也会被调用。

deactivate：
在组件被移除节点后会被调用，如果该组件被移除节点，然后未被插入到其他节点时，则会继续调用 dispose 永久移除。

dispose：
永久移除组件，并释放组件资源。调用完 dispose 后，mounted 属性被设置为 false，也代表组件生命周期的结束。









1）通过Context获取
context 对象有一个 findAncestorStateOfType() 方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。

ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
2）of静态方法

ScaffoldState _state = Scaffold.of(context);


尽可能使用 const 关键字：在构建自己的 widgets 或使用 Flutter widgets 时，尽可能使用 const 构造函数。这有助于 Flutter 只重新构建应该更新的 widgets。

4.添加集合尽可能使用展开运算符：

```
//Do
var y = [4,5,6];
var x = [1,2,...y];//将y集合添加进x集合中

//Do not
var y = [4,5,6];
var x = [1,2];
x.addAll(y);
```

5.在 Flutter 使用 SizedBox 代替 Container：

Container 是一个非常棒的 widgets，您将在 Flutter 广泛使用它。 Container() 扩展到适合父节点给出的约束，并且不是常量构造函数。相反，SizedBox 是一个常量构造函数，构建一个固定大小的盒子。宽度和高度参数可以为 null，以指定不应在相应的维度中约束盒子的大小。因此，当我们必须实现占位符时，应该使用 SizedBox，而不是使用 Container。

```
// Do
return _isNotLoaded ? SizedBox.shrink() : YourWidget();

//Do not
return _isNotLoaded ? Container() : YourWidget();
```

6.使用 if 代替三元运算符语法, 在如下情况:当设计一个 Flutter 应用程序时，通常情况下需要有条件地呈现不同的 widgets。您可能需要基于不同判断生成一个 widgets，例如:

```
Row(
    children: [
      Text("Amir"),
      Platform.isAndroid ? Text("This is From Android") : SizeBox(),
      Platform.isIOS ? Text("This is From IOS") : SizeBox(),
    ]
);
在这种情况下，您可以删除三元运算符，并利用 Dart 的内置语法在数组中添加 if 语句。
Row(
            children: [
              Text("Amir"),
              if (Platform.isAndroid) Text("This is From Android"),
              if (Platform.isIOS) Text("This if From IOS"),
            ]
        );
或者：Platform.isIOS ? Text("This if From IOS") :nil
nil需要插件：nil: ^1.1.1

```

7.指定变量类型：当值的类型已知时，请务必指定成员的类型，尽可能避免使用 var



8.使用 ListView.builder 构建长列表：
当使用无限列表或者非常大的列表时，通常建议使用 ListView.builder 以提高性能。默认的 ListView 构造函数一次生成整个列表，ListView.builder 创建一个惰性列表，当用户向下滚动列表时，Flutter 会按需构建 Widget

9.使用 for/while 代替 foreach/map，foreach/map比较耗时

10.状态管理框架

使用的状态管理框架有Provider和Getx。
1）为什么使用状态管理框架
可以对逻辑和页面 UI进行解耦
难以跨组件和跨页面访问数据
跨组件通信可以分为两种，1、父组件访问子组件 2、子组件访问父组件。第一种可以借助 Notification 机制实现，而第二种可以使用 callback。如果遇到 widget 嵌套层级过多，处理就会很麻烦。这个问题也同样体现在访问数据上，比如有两个页面，他们中的数据是共享，并没有一个很优雅的机制去解决这种跨页面的数据访问。
无法轻松的控制刷新范围，因为setState的变化会导致全局页面的变化
很多场景我们只是部分状态的修改，例如按钮的颜色。但是整个页面的 setState 会使的其他不需要变化的地方也进行重建（build）

============================================Provider start==============================================

1）数据共享

2）局部刷新

我们可以在Provider的局部刷新部分使用。 它能绑定InheritedWidget与依赖它的子孙组件的依赖关系，并且当InheritedWidget数据发生变化时，可以自动更新依赖的子孙组件！利用这个特性，我们可以将需要跨组件共享的状态保存在InheritedWidget中，然后在子组件中引用InheritedWidget即可。

数据发生变化怎么通知？

使用Flutter SDK中提供的ChangeNotifier（这个类需要了解下）类 ，它继承自Listenable，也实现了一个Flutter风格的发布者-订阅者模式。

ChangeNotifier通过调用addListener()和removeListener()来添加、移除监听器（订阅者）；通过调用notifyListeners() 可以触发所有监听器回调。

谁来重新构建InheritedProvider？

我们将要共享的状态放到一个Model类中，然后让它继承自ChangeNotifier，这样当共享的状态改变时，我们只需要调用notifyListeners() 来通知订阅者，然后由订阅者来重新构建InheritedProvider。

Provider的原理和流程？

Model变化后会自动通知ChangeNotifierProvider（订阅者），ChangeNotifierProvider内部会重新构建InheritedWidget，而依赖该InheritedWidget的子孙Widget就会更新。

============================================Provider end==============================================



============================================Get start==============================================

Get 通过依赖注入的方式，实现了对 Presenter 层的获取。简单来说，就是将 Presenter 存到一个单例的 Map 中，这样在任何地方都能随时访问。
全局单例存储一定要考虑到 Presenter 的回收，不然很有可能引起内存泄漏。使用 get 要么手动在页面 dispose的时候做 delete操作，要么使用 GetBuilder，其实它里面也是在 dispose 去做了释放。

为什么使用 Provider 的时候不需要考虑这个问题？
这是因为一般页面级别的 Provider 总是跟随 PageRoute。随着页面的退出，整树中的节点都被会回收，所以可以理解为系统机制为我们解决了这个问题。

Provider和Get如何解决无法轻松的控制刷新范围的问题？
通过缓存

1）手动管理
class Controller extends GetxController {
int counter = 0;
void increment() {
counter++;
update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
}
}
GetxController 实现了Listenable可监听对象的协议
addListener时记录到一个List对象里, 并取名为updater
调用update()，将会刷新所有监听者并调用GetBuilder，GetBuilder是一个状态类，它建立了和Controller的关系并在initState()时增加当前View作为监听者. Controller里维护了一个updater的列表记录每个监听者，在update()的时候会通知刷新所有View的状态 手动管理的
优点: API足够简单清晰，占用很少内存资源。
不足: 1）还是需要我们去手动update() 2）自动管理 GetX 初始化的时候会创建一个Stream,它来监听当前View的变化，当UI中加载 obs.value 时，就会把 View刷新挂载到这个obs属性上。 只要属性变化就会通知View刷新页面。 GetX原理详解： 在了解GetX之前，可以先看一下InheritedWidget，它的精髓是InheritedElement，InheritedWidget的数据传递，通过存和取两个过程。
InheritedWidget存数据，是一个比较简单的操作，数据存储在InheritedElement中即可
class TransferDataWidget extends InheritedWidget {
TransferDataWidget({required Widget child}) : super(child: child);
@override
bool updateShouldNotify(InheritedWidget oldWidget) => false;
@override
InheritedElement createElement() => TransferDataElement(this);
}
class TransferDataElement extends InheritedElement {
TransferDataElement(InheritedWidget widget) : super(widget);
///随便初始化什么, 设置只读都行
String value = '传输数据';
}
取数据只要是 TransferDataWidget（上面InheritedWidget的子类） 的子节点，通过子节点的BuildContext（Element是BuildContext的实现类），都可以无缝的取数据。
var transferDataElement = context.getElementForInheritedWidgetOfExactType<TransferDataWidget>()
as TransferDataElement?;
var msg = transferDataElement.value;
只需要通过Element的getElementForInheritedWidgetOfExactType方法，就可以拿到父节点的TransferDataElement实例（必须继承InheritedElement），拿到实例后，自然就可以很简单的拿到相应数据了。
可以发现我们是拿到了XxxInheritedElement实例，继而拿到了储存的值，所以关键在 getElementForInheritedWidgetOfExactType() 这个方法。

abstract class Element extends DiagnosticableTree implements BuildContext {
Map? _inheritedWidgets;
@override
InheritedElement? getElementForInheritedWidgetOfExactType() {
assert(_debugCheckStateIsActiveForAncestorLookup());
final InheritedElement? ancestor = _inheritedWidgets == null ? null : _inheritedWidgets![T];
return ancestor;
}



============================================Provider end==============================================

11.Flutter中的持久化存储方案
1）SharedPreference，使用shared_preferences
2）sqflite是Flutter的SQLite插件，它能在App端能够高效的存储和处理数据库数据，适用于需要查询大量持久化数据的应用。
3）文件储存，使用path_provider

12.InheritedWidget
InheritedWidget是 Flutter 中非常重要的一个功能型组件，它提供了一种在 widget 树中从上到下共享数据的方式，比如我们在应用的根 widget 中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget 中来获取该共享的数据！这个特性在一些需要在整个 widget 树中共享数据的场景中非常方便。InheritedWidget在 widget 树中数据传递方向是从上到下的，这和通知Notification的传递方向正好相反。InheritedWidget中的updateShouldNotify方法决定当数据发生变化时，是否通知子树中依赖该数据的Widget重新build，该方法如果返回true，并且子组件通过dependOnInheritedElement()来获取监听的对象时，则会回调子组件的didChangeDependencies和build方法。
dependOnInheritedElement方法中主要是注册了依赖关系，调用dependOnInheritedWidgetOfExactType()和 getElementForInheritedWidgetOfExactType()的区别就是前者会注册依赖关系，而后者不会，所以在调用dependOnInheritedWidgetOfExactType()时，InheritedWidget和依赖它的子孙组件关系便完成了注册，之后当InheritedWidget发生变化时，就会更新依赖它的子孙组件，也就是会调这些子孙组件的didChangeDependencies()方法和build()方法。而当调用的是getElementForInheritedWidgetOfExactType()时，由于没有注册依赖关系，所以之后当InheritedWidget发生变化时，就不会更新相应的子孙Widget。
注意，如果我们自己调用getElementForInheritedWidgetOfExactType()，运行代码后，点击"Increment"按钮，会发现自组件的didChangeDependencies()方法确实不会再被调用，但是其build()仍然会被调用，造成这个的原因其实是，点击"Increment"按钮后，会调用父组件的setState()方法，此时会重新构建整个页面，由于示例中，TestWidget 并没有任何缓存，所以它也都会被重新构建，所以也会调用build()方法。要想解决这个问题，就需要使用缓存来实现，将目标组件使用HashMap缓存起来，使用的时候直接取出。
应该在didChangeDependencies()中做什么？
一般来说，子 widget 很少会重写此方法，因为在依赖改变后 Flutter 框架也都会调用build()方法重新构建组件树。
但是，如果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是在此方法中执行，这样可以避免每次build()都执行这些昂贵操作。

InheritedWidget 主要实现两个方法：
创建了 InheritedElement，该 Element 属于特殊 Element，  主要增加了将自身也添加到映射关系表 _inheritedWidgets，方便子孙 element 获取；同时通过 notifyClients 方法来更新依赖。
增加了 updateShouldNotify 方法，当方法返回 true 时，那么依赖该 Widget 的实例就会更新。 所以我们可以简单理解：InheritedWidget 通过 InheritedElement实现了由下往上查找的支持（因为自身添加到 _inheritedWidgets），同时具备更新其子孙的功能。 每个 Element 都有一个_inheritedWidgets ,它是一个 HashMap，它保存了上层节点中出现的 InheritedWidget 与其对应 element 的映射关系。 接着我们看 BuildContext，BuildContext 其实只是接口， Element实现了它。InheritedElement是 Element的子类，所以每一个 InheritedElement 实例是一个 BuildContext 实例。同时我们日常使用中传递的 BuildContext 也都是一个 Element 。 在 InheritedElement 中，notifyClients通过 InheritedWidget的 updateShouldNotify方法判断是否更新，比如在 Theme的  _InheritedTheme是：
bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;



13.Flutter View

Key: 这个key属性类似于 React/Vue 中的key，主要的作用是决定是否在下一次build时复用旧的 widget ，决定的条件在canUpdate()方法中。
static bool canUpdate(Widget oldWidget, Widget newWidget) {
return oldWidget.runtimeType == newWidget.runtimeType
&& oldWidget.key == newWidget.key;
}
canUpdate(…)是一个静态方法，它主要用于在 widget 树重新build时复用旧的 widget ，其实具体来说，应该是：是否用新的 widget 对象去更新旧UI树上所对应的Element对象的配置；通过其源码我们可以看到，只要newWidget与oldWidget的runtimeType和key同时相等时就会用new widget去更新Element对象的配置，否则就会创建新的Element。 Widget这是描述一个UI元素的配置信息，真正的布局，绘制是由谁来完成的？ Flutter 框架的的处理流程是这样的：
根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。
根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。 组件最终的Layout、渲染都是通过RenderObject来完成的，从创建到渲染的大体流程是：根据Widget生成Element，然后创建相应的RenderObject并关联到Element.renderObject属性上，最后再通过RenderObject来完成布局排列和绘制。所以真正的布局和渲染逻辑在 Render 树中，Element 是 Widget 和 RenderObject 的粘合剂，可以理解为一个中间代理。 三棵树中，Widget 和 Element 是一一对应的，但并不和 RenderObject 一一对应。比如 StatelessWidget 和 StatefulWidget 都没有对应的 RenderObject。 渲染树在上屏前会生成一棵 Layer 树。 2）Contextbuild方法有一个context参数，它是BuildContext类的一个实例，表示当前 widget 在 widget 树中的上下文，每一个 widget 都会对应一个 context 对象（因为每一个 widget 都是 widget 树上的一个节点）。实际上，context是当前 widget 在 widget 树中位置中执行”相关操作“的一个句柄(handle)，比如它提供了从当前 widget 开始向上遍历 widget 树以及按照 widget 类型查找父级 widget 的方法。下面是在子树中获取父级 widget 的一个示例
class ContextRoute extends StatelessWidget  {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text("Context测试"),
),
body: Container(
child: Builder(builder: (context) {
// 在 widget 树中向上查找最近的父级`Scaffold`  widget
Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
// 直接返回 AppBar的title， 此处实际上是Text("Context测试")
return (scaffold.appBar as AppBar).title;
}),
),
);
}
}

State
一个 StatefulWidget 类会对应一个 State 类，State表示与其对应的 StatefulWidget 要维护的状态，State 中的保存的状态信息可以：
在 widget 构建时可以被同步读取。
在 widget 生命周期中可以被改变，当State被改变时，可以手动调用其setState()方法通知Flutter 框架状态发生改变，Flutter 框架在收到消息后，会重新调用其build方法重新构建 widget 树，从而达到更新UI的目的。 4）GlobalKey GlobalKey 是 Flutter 提供的一种在整个 App 中引用 element 的机制。如果一个 widget 设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该 widget 对象、globalKey.currentElement来获得 widget 对应的element对象，如果当前 widget 是StatefulWidget，则可以通过globalKey.currentState来获得该 widget 对应的state对象。 注意：使用 GlobalKey 开销较大，如果有其他可选方案，应尽量避免使用它。另外，同一个 GlobalKey 在整个 widget 树中必须是唯一的，不能重复。 3）Element的生命周期：
Framework 调用Widget.createElement 创建一个Element实例，记为element
Framework 调用 element.mount(parentElement,newSlot) ，mount方法中首先调用element所对应Widget的createRenderObject方法创建与element相关联的RenderObject对象，然后调用element.attachRenderObject方法将element.renderObject添加到渲染树中插槽指定的位置（这一步不是必须的，一般发生在Element树结构发生变化时才需要重新attach）。插入到渲染树后的element就处于“active”状态，处于“active”状态后就可以显示在屏幕上了（可以隐藏）。
当有父Widget的配置数据改变时，同时其State.build返回的Widget结构与之前不同，此时就需要重新构建对应的Element树。为了进行Element复用，在Element重新构建前会先尝试是否可以复用旧树上相同位置的element，element节点在更新前都会调用其对应Widget的canUpdate方法，如果返回true，则复用旧Element，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element。Widget.canUpdate主要是判断newWidget与oldWidget的runtimeType和key是否同时相等，如果同时相等就返回true，否则就会返回false。根据这个原理，当我们需要强制更新一个Widget时，可以通过指定不同的Key来避免复用。
当有祖先Element决定要移除element 时（如Widget树结构发生了变化，导致element对应的Widget被移除），这时该祖先Element就会调用deactivateChild 方法来移除它，移除后element.renderObject也会被从渲染树中移除，然后Framework会调用element.deactivate 方法，这时element状态变为“inactive”状态。
“inactive”态的element将不会再显示到屏幕。为了避免在一次动画执行过程中反复创建、移除某个特定element，“inactive”态的element在当前动画最后一帧结束前都会保留，如果在动画执行结束后它还未能重新变成“active”状态，Framework就会调用其unmount方法将其彻底移除，这时element的状态为defunct,它将永远不会再被插入到树中。
如果element要重新插入到Element树的其他位置，如element或element的祖先拥有一个GlobalKey（用于全局复用元素），那么Framework会先将element从现有位置移除，然后再调用其activate方法，并将其renderObject重新attach到渲染树。 看完Element的生命周期，可能有些读者会有疑问，开发者会直接操作Element树吗？其实对于开发者来说，大多数情况下只需要关注Widget树就行，Flutter框架已经将对Widget树的操作映射到了Element树上，这可以极大的降低复杂度，提高开发效率。但是了解Element对理解整个Flutter UI框架是至关重要的，Flutter正是通过Element这个纽带将Widget和RenderObject关联起来，了解Element层不仅会帮助读者对Flutter UI框架有个清晰的认识，而且也会提高自己的抽象能力和设计能力。另外在有些时候，我们必须得直接使用Element对象来完成一些操作，比如获取主题Theme数据，具体细节将在下文介绍。 4）RenderObject StatelessWidget和 StatefulWidget都是用于组合其他组件的，它们本身没有对应的 RenderObject。Flutter 组件库中的很多基础组件都不是通过StatelessWidget和 StatefulWidget来实现的，比如 Column、Align等，就好比搭积木，StatelessWidget和 StatefulWidget可以将积木搭成不同的样子，但前提是得有积木，而这些积木都是通过自定义 RenderObject 来实现的。实际上Flutter 最原始的定义组件的方式就是通过定义RenderObject 来实现，而StatelessWidget和 StatefulWidget只是提供的两个帮助类。 每个Element都对应一个RenderObject，我们可以通过Element.renderObject 来获取。并且我们也说过RenderObject的主要职责是Layout和绘制，所有的RenderObject会组成一棵渲染树Render Tree。本节我们将重点介绍一下RenderObject的作用。RenderObject就是渲染树中的一个对象，它主要的作用是实现事件响应以及渲染管线中除过 build 的部分（build 部分由 element 实现），即包括：布局、绘制、层合成以及上屏 RenderObject拥有一个parent和一个parentData属性，parent指向渲染树中自己的父节点，而parentData是一个预留变量，在父组件的布局过程，会确定其所有子组件布局信息（如位置信息，即相对于父组件的偏移），而这些布局信息需要在布局阶段保存起来，因为布局信息在后续的绘制阶段还需要被使用（用于确定组件的绘制位置），而parentData属性的主要作用就是保存布局信息，比如在 Stack 布局中，RenderStack就会将子元素的偏移数据存储在子元素的parentData中。 RenderObject类本身实现了一套基础的布局和绘制协议，但是并没有定义子节点模型（如一个节点可以有几个子节点，没有子节点？一个？两个？或者更多？）。 它也没有定义坐标系统（如子节点定位是在笛卡尔坐标中还是极坐标？）和具体的布局协议（是通过宽高还是通过constraint和size?，或者是否由父节点在子节点布局之前或之后设置子节点的大小和位置等）。 为此，Flutter框架提供了一个RenderBox和一个RenderSliver类，它们都是继承自RenderObject`，布局坐标系统采用笛卡尔坐标系，屏幕的(top, left)是原点。而 Flutter 基于这两个类分别实现了基于 RenderBox 的盒模型布局和基于 Sliver 的按需加载模型， StatelessWidget和StatefulWidget继承自Widget，而Opacity 和 ErrorWidget 等控件都是继承RenderObject Element 是联系 Widget 和 RenderObject 的纽带。
Widget - 存放渲染内容、视图布局信息
Element - 存放上下文信息，通过 Element 遍历视图树，Element 同时持有Widget和RenderObject
RenderObject - 根据 Widget 的布局属性进行 layout，对 widget 传入的内容进行渲染绘制 Element 是如何发挥其纽带作用的?
每个 Widget 会创建一个对应的 Element 对象 (通过 Widget.createElement())
每个 Element 会持有对应 Widget 对象的引用 (注意 createElement() 方法第一个参数)
RenderObjectElement 是 Element 的子类，这种 Element 持有一个 RenderObject 对象的引用 其次，Element 也是树形结构。我们常说 Widget 是配置/蓝图，其实更具体来说 Widget 是 Element 的配置/蓝图。 配置(Widget)的变更导致 Element 树进行相应地更新。Element.updateChild() 是 Widget 系统的核心方法，它负责处理这个更新。 Widget 的更新和 Element 的更新有着非常重大的差别：
Widget 是配置数据，是轻量级对象。Widget 的更新对应着 Stateless.build() 和 StatefulWidget.build()，重新创建整个 Widget 树，是个全量过程。
Element 是重量级对象。Element 的更新对应着 Element.updateChild()，更新整个 Element 树，是个增量过程。 RenderObjectWidget分为SingleChildRenderObjectWidget 和MultiChildRenderObjectWidget

16.Dart中的单线程是如何运行的？
Dart在单线程中是以消息轮轮询机制来运行的，包含两个任务队列，一个是微任务队列microtaskqueue，一个是事件队列event queue，当Flutter启动后，消息轮训机制便启动了，首先会判断微任务队列是否为空，如果不为空，则执行微任务，执行完成后会继续判断微任务队列是否为空，如此循环，直到微任务队列为空。然后会执行事件任务，会判断事件任务队列是否为空，如果不为空则执行事件任务，事件任务也有可能会包含微任务，所以每次执行完事件任务会先问一下微任务队列是否为空，如果不为空则执行微任务，接着会判断事件任务队列是否为空，直到事件队列为空。

17.Dart是如何实现多任务并行的？
Dart是一种单线程模型语言，可以理解为 Dart 中的线程,isolate 与线程的区别就是线程与线程之间是共享内存的，而 isolate 和 isolate 之间是不共享的，所以叫 isolate (隔离)，它的资源开销低于线程。主要是通过 Isolate.spawn及Isolate.spawnUri来创建Isolate，由于isolate之间没有共享内存，所以他们之间的通信唯一方式只能是通过Port进行，而且Dart中的消息传递总是异步的。 两个Isolate是通过两对Port对象通信，一对Port分别由用于接收消息的ReceivePort对象，和用于发送消息的SendPort对象构成。其中SendPort对象不用单独创建，它已经包含在ReceivePort对象之中。需要注意，一对Port对象只能单向发消息，这就如同一根自来水管，ReceivePort和SendPort分别位于水管的两头，水流只能从SendPort这头流向ReceivePort这头。因此，两个Isolate之间的消息通信肯定是需要两根这样的水管的，这就需要两对Port对象。 Isolate对象的创建是异步的。这里的线程池是在Dart VM初始化的时候创建的。 一个ReceivePort对象包含一个RawReceivePort对象及SendPort对象。其中RawReceivePort对象是在虚拟机中创建的， 在创建ReceivePort对象对象之前，首先会将当前Isolate中的MessageHandler对象添加到map中。这里是一个全局的map，在Dart VM初始化的时候创建，每个元素都是一个Entry对象，在Entry中，有一个MessageHandler对象，一个端口号及该端口的状态。 这里的map的初始容量是8，当达到容量的3/4时，会进行扩容，新的容量是旧的容量2倍。这跟HashMap类似，初始容量为8，加载因子为0.75，扩容是指数级增长。 消息的处理是在HandleMessages函数中进行的。在HandleMessages函数中会根据消息的优先级别来遍历所有消息并一一处理，直至处理完毕。 至此，一个Isolate就已经成功的向另外一个Isolate成功发送并接收消息。而双向通信也很简单，在父Isolate中创建一个端口，并在创建子Isolate时，将这个端口传递给子Isolate。然后在子Isolate调用其入口函数时也创建一个新端口，并通过父Isolate传递过来的端口把子Isolate创建的端口传递给父Isolate，这样父Isolate与子Isolate分别拥有对方的一个端口号，从而实现了通信。

18.Flutter框架的优缺点
Flutter是Google推出的一套开源跨平台UI框架，可以快速地在android、iOS和web平台上构建高质量的原生用户界面，在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。Flutter采用现代响应式框架构建，其中心思想是使用组件来构建应用的UI。当组件的状态发生改变时，组件才会重构它的描述，Flutter会对比之前的描述，以确定底层渲染树从当前状态切换到下一个状态所需要的最小改变。
优点：
热重载，利用AS直接ctl+s就可以保存并重载，模拟器立马就可以看见效果，相比原生长久的编译过程强很多。
一切皆为Widget的理念，对于Flutter来说，手机应用里的所有东西都是Widget，通过可组合的空间集合、丰富的动画以及分层课扩展的架构实现了富有感染力的灵活界面设计借助可移植的GPU加速的渲染引擎及高性能本地化代码运行时，以达到跨平台设备的高质量用户体验。简单来说就是：最终结果就是利用Flutter构建的应用在运行效率上会和原生应用差不多。
缺点：
不支持热更新
三方库有限
Dart语言编写，增加学习难度



19.Dart有哪些特性？
在Dart中，一切皆对象，所有的对象都继承自Object。
Dart是强类型语言，可以使用var或者dynamic来声明一个变量，Dart会自动推断其数据类型。
没有赋值的变量默认值为null
Dart支持顶层方法和闭包。
Dart没有类似public的关键字，使用_下划线来声明变量或者方法是私有的。

20.全面屏的适配
1）通过MaterialApp+Scaffold的方式，系统自动为我们适配全面屏的安全区域
2）使用 MediaQuery 来控制距离上下的距离
3）在Android的AndroidManifest中添加设置：
<meta-data
android:name="android.max_aspect"
android:value="2.3" />
除了适配全面屏幕，还可以使用第三方插件 flutter_screenutil 来适配Widget

21.Flutter中的绘制
Flutter 中存在 Widget 、 Element、RenderObject、Layer四棵树，其中 Widget与Element是一对多的关系 ，
Element中持有Widget和 RenderObject， 而 Element与 RenderObject是一一对应的关系（除去 Element 不存在 RenderObject 的情况，如 ComponentElement是不具备 RenderObject)，
当 RenderObject的 isRepaintBoundary为true` 时，那么个区域形成一个 Layer，所以不是每个RenderObject都具有 Layer 的，因为这受 isRepaintBoundary的影响。
Flutter 中 Widget不可变，每次保持在一帧，如果发生改变是通过 State 实现跨帧状态保存，而真实完成布局和绘制数组的是 RenderObject ，Element充当两者的桥梁， State就是保存在 Element` 中。
Flutter 中的 BuildContext 只是接口，而 Element实现了它。
Flutter 中 setState 其实是调用了 markNeedsBuild，该方法内部标记此Element 为 Dirty，然后在下一帧 WidgetsBinding.drawFrame 才会被绘制，这可以看出 setState并不是立即生效的。
通过isRepaintBoundary 往上确定了更新区域，通过 requestVisualUpdate 方法触发更新往下绘制。
Flutter 中 InheritedWidget一般用于状态共享，如Theme、 MediaQuery等，都是通过它实现共享状态，这样我们可以通过 context 去获取共享的状态，比如 ThemeData theme = Theme.of(context);
Flutter 中默认主要通过 runtimeType和 key判断更新：
static bool canUpdate(Widget oldWidget, Widget newWidget) {
return oldWidget.runtimeType == newWidget.runtimeType
&& oldWidget.key == newWidget.key;
}
}

22.Flutter的编译模式

Flutter 的 Debug下是 JIT 模式，release下是AOT模式。

Flutter的编译模式
Flutter是基于Dart语言开发的，Dart同时支持即时变异JIT和事前编译AOT，在开发期使用JIT可以更快的调试且支持热重载，在发布期使用AOT，本地代码的执行效率更高，用户体验更好。
Flutter的编译模式：
1）Debug模式对应的是Dart的JIT模式，可以在真机和模拟器上同时运行，该模式会打开所有的断言，调试信息和服务扩展，这个模式为快速运行和开发做了优化，支持热重载，但并没有优化代码执行速度，二进制包大小和部署。flutter run --debug就是以这种模式运行的。
2）Release模式对应的是Dart的AOT模式，只能在真机上运行，不能在模拟器上运行，它的目标就是最终的线上发布，这个模式会关闭所有的断言以及极可能多的调试信息和服务扩展。另外这个模式优化了应用快速启动，代码快速执行，以及二进制包大小，因此编译时间比较长。flutter run --release 命令就是以这种模式运行的。
3）Profile模式，基本与Release模式一致，只是多了对Profile模式服务扩展的支持，这个模式用于分析真是设备运行性能。
flutter run profile命令就是以这种模式运行的

23.事件传递和分发
参考文章：
https://juejin.cn/post/6844904083371851790
https://www.jianshu.com/p/b9a93763ef69
在flutter中，一个事件的产生，会经过native，engine和flutter层，native是生产者，engine是传递者，flutter是消费者。
Android也有自己的事件分发机制，整体就是dispatchTouchEvent-onInterceptTouchEvent-onTouchEvent这样一个流程，flutter在安卓中是以FlutterView(FrameLayout)为媒介的，flutter中所获取到的事件，实际上就是FlutterView在安卓体系中接收到的事件，再进一步通过flutter engine传递给flutter，安卓中的事件一般是通过onTouchEvent这个方法消费的，这个方法的参数是MotionEvent，然后把MotionEvent存储在ByteBuffer中交给flutter engine层，再进一步传递给flutter，最后通过flutter engine层将数据通过_dispatchPointerDataPacket传递给flutter。
传递给flutter后，会调用 PlatformDispatcher 的 onPointerDataPacket 函数，也就是在 GestureBinding 初始化时传给给 PlatformDispatcher 的 _handlePointerDataPacket，事件分发由此进入 flutter 层。其中还涉及到数据转换，engine 层向 flutter 层传递事件数据时并不能直接传递对象，也是先转成 buffer 数据再传递，此处还需要调用 _unpackPointerDataPacket 将 buffer 数据再转回 PointerDataPacket 对象。
一个MotionEvent可能包含多个触摸点，需要将每一个触摸点的数据拆分开，依次装载到 packet 中
flutter层接收事件：
从 flutter app 的启动 runApp 函数中开始，对 WidgetsflutterBinding 进行了初始化，而 WidgetsflutterBinding 的其中一个 mixin 是 GestureBinding，即实现了手势相关的能力，包括从 native 层获取到事件信息，然后从 widget 树的根结点开始一步一步往下传递事件。
在 GestureBinding 中事件传递有两种方式，一种是通过 HitTest 过程，另一种是通过 route ，前者就是常规流程，GestureBinding 获取到事件之后，在 render 树中从根结点开始向下传递，而 route 方式则是某个结点通过向 GestureBinding 中的 pointerRoute 添加路由，使得 GestureBinding 接收到事件之后直接通过路由传递给对应的结点，相较于前一种方式，更直接，也更灵活。
程序入口是runApp，WidgetsFlutterBindbing混入了很多的mixin，手势相关的是GestureBinding这个混入类，会在GestureBinding的
initInstances方法中对手势事件进行初始化。
@override
void initInstances() {
super.initInstances();
_instance = this;
platformDispatcher.onPointerDataPacket = _handlePointerDataPacket;
}
为platformDispatcher注册了onPointerDataPacket回调，其实现是_handlePointerDataPacket()。
_handlePointerDataPacket()方法:
GestureBinding 接收事件信息的函数为 _handlePointerDataPacket，它接收的参数为 PointerDataPacket，内含一系列的事件 PointerData，然后就先是通过 PointerEventConverter.expand 将其转换为 flutter 中使用的 PointerEvent 保存在 _pendingPointerEvents 中，再调用 _flushPointerEventQueue 处理事件。
_flushPointerEventQueue()方法:
_flushPointerEventQueue 中就是一个循环，不断从 _pendingPointerEvents 中取出事件，然后交给 _handlePointerEvent 处理。
_handlePointerEvent()方法:
在 _handlePointerEvent 中会创建 HitTestResult，它贯穿整个事件分发的过程，并起着重要的作用。首先，HitTestResult 可以表示一系列的事件，它在 PointerDownEvent 到来时被创建并加入 _hitTests，并在 PointerUpEvent/PointerCancelEvent 到来时被移出 _hitTests，在一系列事件的中间，则可以通过 _hitTests[event.pointer] 获取到对应的 HitTestResult。HitTestResult 的分发对象是由 hitTest 函数执行确定的，由 RendererBinding 的 hitTest 函数作为入口，开始调用 RenderView 的 hitTest 函数，RenderView 可以认为是 render 树的入口，它再调用 child.hitTest 使得 HitTestResult 在 render 树中传递，之后再通过 hitTest/hitTestChildren 不断递归，找到消费这个事件的 RenderObject，并保存从根结点到这个结点的路径，方便之后的系列事件分发， RenderObject 的子类可以通过重写 hitTest/hitTestChildren 判断自己是否需要消费当前事件。
如果结点（或其子结点）需要消费事件，就会调用 HitTestResult.add 将自己加入到 HitTestResult 的路径中，保存在 HitTestResult 的 _path 中，后面具体分发的时候就会根据按照这个路径进行。比如在 GestureBinding 的 hitTest 中，
事件分发：
事件分发有两种，一种就是由 HitTestResult 确定的分发路径，另一种是当 HitTestResult 为 null 时（一般当使用外部设备如鼠标时，HitTestResult 就无法有效地判断分发路径，或者上层直接通过 GestureDecter 等进行手势检测），需要由路由直接导向对应的结点。
HitTestResult 方式中，dispatchEvent 会调用 HitTestResult 保存路径中每一个结点的 handleEvent 处理事件，也就是在 hitTest 阶段中确定的事件分发路径，从 GestureBinding 开始，调用他们的 handleEvent 函数。
在 route 方式中，GestureBinding 回调用 pointerRouter.route 函数执行事件分发，事件的接受者就是 _routeMap 中保存的结点，而接收者通过 addRoute 和 removeRoute 进行添加和删除，接受者分为两种，普通的 route 存储在  _routeMap 中，globalRoute 存储在 _globalRoutes 中，前者是与 pointer 绑定的，后者会响应所有的事件。
HitTest的分发流程：
HitTest 方式的分发流程，可以将其分为两部分，第一部分是 hitTest 过程，确定事件接收者路径，这个过程只在 PointerDownEvent 和 PointerSignalEvent 事件发生时执行，对于一系列事件，只会执行一次，后续的都会通过 pointer 找到首次事件时创建的 HitTestResult，如果没有就不会执行分发（这里先不考虑 route 流程）；第二部分就是后面的 dispatchEvent，会调用 HitTestResult 路径中的所有结点的 handleEvent 函数，这个过程在每一个事件到来时（且有对应的 HitTestResult）会执行。而单独从 HitTestResult 角度来看，第一个过程就是给事件注册接收者，第二个过程则是将事件分发给接收者，所以它的基本流程与 route 保持一致，只不过二者在不同的维度上作用，前者依赖 Widgets 树这样一个结构，它的接收者之间有着包含关系，这是一个事件正常的传递-消费过程。route 流程相较而言更加随意，它可以直接通过 GestureBinding.instance.pointerRouter.addRoute 注册一系列事件的接收者，而不需要传递的过程，没有结点之间的限制，更适合用于手势的监听等操作。
在 HitTest 流程中，从 GestureBinding 的 hitTest 开始，首先将 GestureBinding 加入到 HitTestResult 的路径中，也就是说所有的 HitTest 流程中首先都会调用  GestureBinding 的 handleEvent 函数。然后在  RendererBinding 中通过调用了 RenderView 的 hitTest，RenderView 是 RenderObject 的子类，也是 render 树的入口，RenderObject 实现了 HitTestTarget，但是 hitTest 的实现是在 RenderBox 中，RenderBox 可以看作是 render 结点的基类，它有实现 hitTest 和 hitTestChildren 函数
如果事件的 position 在自己身上，就接着调用 hitTestChildren 和 hitTestSelf 判断子结点或者自身是否消费事件，决定是否将自己加入到 HitTestResult 路径，从这里也可以看出，在 HitTestResult 路径中顺序是从子结点到根结点，最后到 GestureBinding。
route的分发流程：
route 流程整体来说也分为两个过程，第一步是进行事件监听，通过调用 GestureBinding.instance.pointerRouter.addRoute 完成注册，此处传入参数为 pointer（一般来说，对于触摸事件，每一次触摸 pointer 都会更新，对于鼠标事件，pointer 始终为 0）、handleEvent（处理事件函数）和 transform（用作点位的转换，比如将 native 层传来的位置转换成 flutter 中的位置），在 addRoute 中它们被封装成 _RouteEntry 保存在 _routeMap 等待被分发事件。除此之外还有addGlobalRoute、removeRoute 等可用于注册全局监听、移出监听。
在 flutter 中事件分发有两种，一种是常规的在 render 树中传递事件的方式，也就是 HitTest 方式，另一种是直接向 GestureBinding 中注册回调函数的方式，也就是 route 方式，它们在 flutter 系统中扮演着不同的角色，其中 HitTest 方式主要是用于监听基本的事件，例如 PointerDownEvent、PointerUpEvent 等，而 route 方式一般都是与 GestureRecognizer 一起使用，用于检测手势，如 onTap、onDoubleTap 等，另外，在手势检测的过程中，GestureArenaManager 也是重度参与用户，协助 GestureRecognizer 保证同一个事件同一时间只会触发一种手势。
也就是说事件从 android 传到 flutter 中执行了 5 次转换：
android 中，从 MotionEvent 中取出事件，并保存在 ByteBuffer 中
engine 中，将 ByteBuffer 转成 PointerDataPacket（类对象）
engine 中，为了传递给 dart，将 PointerDataPacket 转成 buffer
dart 中，将 buffer 再转成 PointerDataPacket（类对象）
dart 中，将 PointerData 转成 PointerEvent，供上层使用，这一步还在后面 ###
当触摸事件按下时，Flutter会对应用程序执行命中测试(HitTest)，以确定触摸事件与屏幕接触的位置存在哪些组件（widget）， 按下事件（以及该触摸事件的后续事件）然后被分发到由命中测试发现的最内部的组件，然后从
那里开始，事件会在组件树中向上冒泡，这些事件会从最内部的组件被分发到组件树根的路径上的所有组件，只有通过命中测试的组件才能触发事件。
`GestureDetector`内部是使用一个或多个`GestureRecognizer`来识别各种手势的，而`GestureRecognizer`的作用就是通过`Listener`来将原始指针事件转换为语义手势，`GestureDetector`直接可以接
收一个子widget。`GestureRecognizer`是一个抽象类，一种手势的识别器对应一个`GestureRecognizer`的子类，Flutter实现了丰富的手势识别器，我们可以直接使用。
Flutter事件机制-电子书的理解：
Flutter 事件处理流程主要分两步：
命中测试：当手指按下时，触发 PointerDownEvent 事件，按照深度优先遍历当前渲染（render object）树，对每一个渲染对象进行“命中测试”（hit test），如果命中测试通过，则该渲染对象会
被添加到一个 HitTestResult 列表当中。
事件分发：命中测试完毕后，会遍历 HitTestResult 列表，调用每一个渲染对象的事件处理方法（handleEvent）来处理 PointerDownEvent 事件，该过程称为“事件分发”（event dispatch）。随
后当手指移动时，便会分发 PointerMoveEvent 事件。
事件清理：当手指抬（ PointerUpEvent ）起或事件取消时（PointerCancelEvent），会清空 HitTestResult 列表。
需要注意：
1）命中测试是在 PointerDownEvent 事件触发时进行的，一个完成的事件流是 down > move > up (cancle)。
2）如果父子组件都监听了同一个事件，则子组件会比父组件先响应事件。这是因为命中测试过程是按照深度优先规则遍历的，所以子渲染对象会比父渲染对象先加入 HitTestResult 列表，又因为在事件分
发时是从前到后遍历 HitTestResult 列表的，所以子组件比父组件会更先被调用 handleEvent 。
==================================================命中测试==================================================
一个对象是否可以响应事件，取决于在其对命中测试过程中是否被添加到了 HitTestResult 列表 ，如果没有被添加进去，则后续的事件分发将不会分发给自己。当发生用户事
件时，Flutter 会从根节点（RenderView）开始调用它hitTest() 。
整体是命中测试分两步：
第一步： renderView 是 RenderView 对应的 RenderObject 对象， RenderObject 对象的 hitTest 方法主要功能是：从该节点出发，按照深度优先的顺序递归遍历子树（渲染树）上的每
一个节点并对它们进行命中测试。这个过程称为“渲染树命中测试”。
渲染树命中测试过程:
渲染树的命中测试流程就是父节点 hitTest 方法中递归调用子节点 hitTest 方法的过程。
因为 RenderView 只有一个孩子，所以直接调用child.hitTest 即可。如果一个渲染对象有多个子节点，则命中测试逻辑为：如果任意一个子节点通过了命中测试或者当前节点“强行声明”自己通过
了命中测试，则当前节点会通过命中测试。
hitTestChildren() 功能是判断是否有子节点通过了命中测试，如果有，则会将子组件添加到 HitTestResult 中同时返回 true；如果没有则直接返回false。该方法中会递归调用子组件的 hitTest 方法。
hitTestSelf() 决定自身是否通过命中测试，如果节点需要确保自身一定能响应事件可以重写此函数并返回true ，相当于“强行声明”自己通过了命中测试。
整体逻辑就是：
先判断事件的触发位置是否位于组件范围内，如果不是则不会通过命中测试，此时 hitTest 返回 false，如果是则到第二步。
会先调用 hitTestChildren() 判断是否有子节点通过命中测试，如果是，则将当前节点添加到 HitTestResult 列表，此时 hitTest 返回 true。即只要有子节点通过了命中测试，那
么它的父节点（当前节点）也会通过命中测试。
如果没有子节点通过命中测试，则会取 hitTestSelf 方法的返回值，如果返回值为 true，则当前节点通过命中测试，反之则否。
如果当前节点有子节点通过了命中测试或者当前节点自己通过了命中测试，则将当前节点添加到 HitTestResult 中。又因为 hitTestChildren()中会递归调用子组件的 hitTest 方法，所以组件树的
命中测试顺序深度优先的，即如果通过命中测试，子组件会比父组件会先被加入HitTestResult 中。
主要逻辑是遍历调用子组件的 hitTest() 方法，同时提供了一种中断机制：即遍历过程中只要有子节点的 hitTest() 返回了 true 时：
会终止子节点遍历，这意味着该子节点前面的兄弟节点将没有机会通过命中测试。注意，兄弟节点的遍历倒序的。 父节点也会通过命中测试。因为子节点 hitTest() 返回了 true 导父节点 hitTestChildren 也会返
回 true，最终会导致 父节点的 hitTest 返回 true，父节点被添加到 HitTestResult 中。
当子节点的 hitTest() 返回了 false 时，继续遍历该子节点前面的兄弟节点，对它们进行命中测试，如果所有子节点都返回 false 时，则父节点会调用自身的 hitTestSelf 方法，如果该方法也
返回 false，则父节点就会被认为没有通过命中测试。
为什么要制定这个中断呢？
因为一般情况下兄弟节点占用的布局空间是不重合的，因此当用户点击的坐标位置只会有一个节点，所以一旦找到它后（通过了命中测试，hitTest 返回true），就没有必要再判断其他兄弟节点了。但是也有例外
情况，比如在 Stack 布局中，兄弟组件的布局空间会重叠，如果我们想让位于底部的组件也能响应事件，就得有一种机制，能让我们确保：即使找到了一个节点，也不应该终止遍历，也就是说所有的子组件的 hitTest 方法都必
须返回 false！为此，Flutter 中通过 HitTestBehavior 来定制这个过程，这个我们会在本节后面介绍。
为什么兄弟节点的遍历要倒序？
兄弟节点一般不会重叠，而一旦发生重叠的话，往往是后面的组件会在前面组件之上，点击时应该是后面的组件会响应事件，而前面被遮住的组件不能响应，所以命中测试应该优先对后面的节点进行测试，因为一旦通过
测试，就不会再继续遍历了。如果我们按照正向遍历，则会出现被遮住的组件能响应事件，而位于上面的组件反而不能，这明显不符合预期。
如果不重写 hitTestChildren，则默认直接返回 false，这也就意味着后代节点将无法参与命中测试，相当于事件被拦截了，这也正是 IgnorePointer 和 AbsorbPointer 可以拦截事件下发的原理。
如果 hitTestSelf 返回 true，则无论子节点中是否有通过命中测试的节点，当前节点自身都会被添加到 HitTestResult 中。而 IgnorePointer 和 AbsorbPointer 的区别就是，前者的 hitTestSelf 返
回了 false，而后者返回了 true。
命中测试完成后，所有通过命中测试的节点都被添加到了 HitTestResult 中。
==================================================事件分发==================================================
事件分发过程很简单，即遍历HitTestResult，调用每一个节点的 handleEvent 方法，所以组件只需要重写 handleEvent 方法就可以处理事件了。
总结：
组件只有通过命中测试才能响应事件。
一个对象是否可以响应事件，取决于在其对命中测试过程中是否被添加到了 HitTestResult 列表
一个组件是否通过命中测试取决于 hitTestChildren(...) || hitTestSelf(...) 的值。
组件树中组件的命中测试顺序是深度优先的。
组件子节点命中测试的循序是倒序的，并且一旦有一个子节点的 hitTest 返回了 true，就会终止遍历，后续子节点将没有机会参与命中测试。这个原则可以结合 Stack 组件来理解。

24. Element的生命周期：
    Element有4种状态：initial，active，inactive，defunct。其对应的意义如下：
    initial：初始状态，Element刚创建时就是该状态。
    active：激活状态。此时Element的Parent已经通过mount将该Element插入Element Tree的指定位置，Element此时随时可能显示在屏幕上。
    inactive：未激活状态。当Widget Tree发生变化，Element对应的Widget发生变化，同时由于新旧Widget的Key或者的RunTimeType不匹配等原因导致该Element也被移除，因此该Element的状态变为未激活状态，被从屏幕上移除。并将该Element从Element Tree中移除，如果该Element有对应的RenderObject，还会将对应的RenderObject从Render Tree移除。
    defunct：失效状态。如果一个处于未激活状态的Element在当前帧动画结束时还是未被复用，此时会调用该Element的unmount函数，将Element的状态改为defunct，并对其中的资源进行清理。     Element的分类： Element从功能上可以分为两大类：ComponentElement和RenderObjectElement ComponentElement:组合类Element。这类Element主要用来组合其他更基础的Element，得到功能更加复杂的Element。开发时常用到的StatelessWidget和StatefulWidget相对应的Element：StatelessElement和StatefulElement，即属于ComponentElement。
    ComponentElement持有Parent Element及Child Element，由此构成Element Tree.
    ComponentElement持有其对应的Widget,对于StatefulElement，其还持有对应的State，以此实现Element和Widget之间的绑定。
    State是被StatefulElement持有，而不是被StatefulWidget持有，便于State的复用。事实上，State和StatefulElement是一一对应的，只有在初始化StatefulElement时，才会初始化对应的State并将其绑定到StatefulElement上。 RenderObjectElement: 渲染类Element，对应Renderer Widget，是框架最核心的Element。RenderObjectElement主要包括SingleChildRenderObjectElement，和MultiChildRenderObjectElement。其中，SingleChildRenderObjectElement对应的Widget是SingleChildRenderObjectWidget，有一个子节点；MultiChildRenderObjectElement对应的Widget是MultiChildRenderObjecWidget，有多个子节点。
    Element的创建过程？
    1 当Element=null ,newWidget=null Element的值直接返回null
    2 当Element=null.newWidget!=null 就是之前这个地方没有widget，但是刷新一个之后出现了一个widget，
    就相当于新创建，于是走的是inflateWidget
    3 当Element！=null ,newWidge==null 就是之前这个地方有一个widget，刷新之后这个Widget没有了，那么这个时候需要回
    收之前创建的Element，于是这里执行了 deactivateChild(child);
    4 当Element！=null ,newWidge！=null 的时候，这里也可以分为两种情形 通过判断新旧widget的runtimetype和key是否一致
    来判断对应的element是不是可以复用，如果可以复用只需要调用 Element的update(newWidget)更新一个Widget就可以了，如果
    不可复用将回收旧的element(deactivateChild)然后创建一个新的element(inflateWidget).

25.Flutter要求每个图片必须提供1x图，然后才会识别到对应的其他倍率目录下的图片：
flutter:
assets:

- images/cat.png
- images/2x/cat.png
- images/3.5x/cat.png
  new Image.asset('images/cat.png');
  这样配置后，才能正确地在不同分辨率的设备上使用对应密度的图片。但是为了减小APK包体积我们的位图资源一般只提供常用的2x分辨率，其他分辨率的设备会在运行时自动缩放到对应大小。

如何加载不同分辨率的图？
例如android中的hdpi，xhdpi，xxhdpi和ios中的1x，2x，3x。只需要在images文件夹中在创建两个2.0x，3.0x文件夹用来存放2x，3x的图片资源：
然后在pubspec.yaml中声明
assets:

- images/ic_qq.png
- images/2.0x/ic_qq.png
- images/3.0x/ic_qq.png
  这样在加载图片的时候不用去管2x，3x，flutter自己会去选择加载
  Image.asset('images/ic_qq.png')

26.热重载

并不是所有的代码改动都可以通过热重载来更新
控件类型从StatelessWidget到StatefulWidget的转换，因为Flutter在执行热刷新时会保留程序原来的state，而某个控件从stageless→stateful后会导致Flutter重新创建控件时报错“myWidget is not a subtype of StatelessWidget”，而从stateful→stateless会报错“type ‘myWidget’ is not a subtype of type ‘StatefulWidget’ of ‘newWidget’”。
全局变量和静态成员变量，这些变量不会在热刷新时更新。
修改了main函数中创建的根控件节点，Flutter在热刷新后只会根据原来的根节点重新创建控件树，不会修改根节点。

27.ListView优化

关于ListView 的优化
ListView是我们最常用的组件之一，用于展示大量数据的列表。如果展示大量数据请使用 ListView.builder或者 ListView.separated，千万不要直接使用如下方式：
ListView(
children: <Widget>[
item,item1,item2,...
],
)
这种方式一次加载所有的组件，没有“懒加载”，消耗极大的性能。
ListView 中 itemExtent 属性对动态滚动到性能提升非常大，比如，有2000条数据展示，点击按钮滚动到最后，代码如下：
class ListViewDemo extends StatefulWidget {
@override
_ListViewDemoState createState() => _ListViewDemoState();
}
class _ListViewDemoState extends State<ListViewDemo> {
ScrollController _controller;
@override
void initState() {
super.initState();
_controller = ScrollController();
}
@override
Widget build(BuildContext context) {
return Stack(
children: [
ListView.builder(
controller: _controller,
itemBuilder: (context, index) {
return Container(
height: 80,
alignment: Alignment.center,
color: Colors.primaries[index % Colors.primaries.length],
child: Text('$index',style: TextStyle(color: Colors.white,fontSize: 20),),
);
},
itemCount: 2000,
),
Positioned(
child: RaisedButton(
child: Text('滚动到最后'),
onPressed: () {
_controller.jumpTo(_controller.position.maxScrollExtent);
},
))
],
);
}
}
加上itemExtent属性，修改如下：
ListView.builder(
controller: _controller,
itemBuilder: (context, index) {
return Container(
height: 80,
alignment: Alignment.center,
color: Colors.primaries[index % Colors.primaries.length],
child: Text('$index',style: TextStyle(color: Colors.white,fontSize: 20),),
);
},
itemExtent: 80,
itemCount: 2000,
)
优化后瞬间跳转到底部。
这是因为不设置 itemExtent 属性，将会由子组件自己决定大小，大量的计算导致UI堵塞。
如果 list 有很多 item，使用 ListView.builder，这个方法会在 item 滚动进入屏幕的时候才创建 item，而不是一次性创建所有的 item。这在 list 很复杂和 widget 嵌套很深的情况下，有明显的性能优势。

28.避免更改组件树的结构和组件的类型
有如下场景，有一个 Text组件有可见和不可见两种状态，代码如下：
bool _visible = true;
@override
Widget build(BuildContext context) {
return Center(
child: Column(
children: [
if(_visible)
Text('可见'),
Container(),
],
),
);
}
图片: https://uploader.shimo.im/f/8iLSlp9gvyUfd682.webp!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2ODkzMjcyNjcsImZpbGVHVUlEIjoiQjFBd2REN3l4bnVqZDNtOCIsImlhdCI6MTY4OTMyNjk2NywiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.VYhPywlivvDIty-56DcShBbA004YMvd8ntdp_X5WhiM
不可见时的组件树：
图片: https://uploader.shimo.im/f/Vj6G6O7i80dxZkjb.webp!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2ODkzMjcyNjcsImZpbGVHVUlEIjoiQjFBd2REN3l4bnVqZDNtOCIsImlhdCI6MTY4OTMyNjk2NywiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.VYhPywlivvDIty-56DcShBbA004YMvd8ntdp_X5WhiM
两种状态组件树结构发生变化，应该避免发生此种情况，优化如下：
Center(
child: Column(
children: [
Visibility(
visible: _visible,
child: Text('可见'),
),
Container(),
],
),
)
此时不管是可见还是不可见状态，组件树都不会发生变化，如下：
图片: https://uploader.shimo.im/f/dGKXFEFDH868bJPI.webp!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2ODkzMjcyNjcsImZpbGVHVUlEIjoiQjFBd2REN3l4bnVqZDNtOCIsImlhdCI6MTY4OTMyNjk2NywiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.VYhPywlivvDIty-56DcShBbA004YMvd8ntdp_X5WhiM

29.MediaQuery优化
首先我们需要简单解释一下，通过 MediaQuery.of获取到的  MediaQueryData里有几个很类似的参数：
viewInsets： 被系统用户界面完全遮挡的部分大小，简单来说就是键盘高度
padding ： 简单来说就是状态栏和底部安全区域，但是 bottom会因为键盘弹出变成 0
viewPadding ：和 padding 一样，但是 bottom部分不会发生改变 举个例子，在 iOS 上，如下图所示，在弹出键盘和未弹出键盘的情况下，可以看到 MediaQueryData里一些参数的变化：
viewInsets  在没有弹出键盘时是 0，弹出键盘之后 bottom 变成 336
padding 在弹出键盘的前后区别， bottom 从 34 变成了 0
viewPadding  在键盘弹出前后数据没有发生变化 MediaQueryData里的数据是会根据键盘状态发生变化，又因为   MediaQuery 是一个 InheritedWidget，所以我们可以通过 MediaQuery.of(context)获取到顶层共享的  MediaQueryData InheritedWidget的更新逻辑，是通过登记的 context来绑定的，也就是MediaQuery.of(context)本身就是一个绑定行为，然后MediaQueryData又和键盘状态有关系，所以：键盘的弹出可能会导致使用MediaQuery.of(context)的地方触发 rebuild 所以小技巧一：要慎重在Scaffold之外使用MediaQuery.of(context)，可能你现在会觉得奇怪什么是  Scaffold 之外，没事后面继续解释。 那到这里有人可能就要说了：我们通过    MediaQuery.of(context)  获取到的   MediaQueryData  ，不就是对应在  MaterialApp  里的 MediaQuery  吗？那它发生改变，不应该都会触发下面的 child 都 rebuild 吗？ 这其实和页面路由有关系，也就是我们常说的 PageRoute 的实现。 因为嵌套结构的原因，事实上弹出键盘确实会导致  MaterialApp   下的 child 都触发 rebuild ，因为设计上 MediaQuery 就是在 Navigator 上面，所以弹出键盘自然也就触发  Navigator的  rebuild。 那正常情况下 Navigator都触发 rebuild 了，为什么页面不会都被 rebuild 呢？ 这就和路由对象的基类 ModalRoute 有关系，因为在它的内部会通过一个 _modalScopeCache参数把     Widget缓存起来，正如注释所说：缓存区域不随帧变化，以便得到最小化的构建。 其实这个行为也体现在了 Scaffold 里，如果你去看 Scaffold 的源码，你就会发现 Scaffold 里大量使用了 MediaQuery.of(context) 。 虽然 Scaffold里大量使用 MediaQuery.of(context)，但是影响范围是约束在Scaffold内部。 可以看到MediaQuery.of里的 context 对象很重要：
如果页面MediaQuery.of用的是  Scaffold外的 context ，获取到的是顶层的 MediaQueryData，那么弹出键盘时就会导致页面 rebuild
MediaQuery.of用的是  Scaffold内的 context ，那么获取到的是   Scaffold对于区域内的 MediaQueryData  ，比如前面介绍过的 body ，同时获取到的 MediaQueryData 也会因为Scaffold的配置不同而发生改变。

30.优化BuildContext Flutter 里的 BuildContext它实际是 Element 的抽象对象，而在 Flutter 里，它主要来自于 ComponentElement 。 关于 ComponentElement 可以简单介绍一下，在 Flutter 里根据 Element 可以简单地被归纳为两类：
RenderObjectElement ：具备 RenderObject ，拥有布局和绘制能力的 Element
ComponentElement ：没有 RenderObject ，我们常用的 StatelessWidget 和 StatefulWidget 里对应的 StatelessElement 和 StatefulElement 就是它的子类。 所以一般情况下，我们在 build 方法或者 State 里获取到的 BuildContext 其实就是 ComponentElement 。 1）延迟任务中使用了context，如果在延迟任务完成前销毁了当前页面会报错 原因：Widget 对应的 Element 已经不在了，因为在页面销毁时，context 对应的 Element 已经随着我们的退出销毁。 解决：是增加 mounted判断，通过 mounted判断就可以避免上述的错误，mounted标识位来自于 State，因为 State是依附于 Element 创建，所以它可以感知 Element 的生命周期，例如 mounted就是判断 _element != null;。 2）在异步操作里使用 of(context) ，可以提前获取，之后再做异步操作，这样可以尽量保证流程可以完整执行。 可以通过 of(context)去获取上层共享往下共享的 InheritedWidget，那在哪里获取就比较好？ 为什么官方会建议在didChangeDependencies方法里去调用 of(context) ？ 通过 of(context)获取到的是 InheritedWidget，而 当 InheritedWidget发生改变时，就是通过触发绑定过的 Element 里 State 的didChangeDependencies来触发更新，所以在 didChangeDependencies里调用 of(context)有较好的因果关系。 可以在 initState里提前调用吗？ 不行，首先如果在 initState直接调用如 ScaffoldMessenger.of(context).showSnackBar方法，会报错。 这是因为 Element 里会判断此时的 _StateLifecycle状态，如果此时是 _StateLifecycle.created或者 _StateLifecycle.defunct，也就是在 initState和dispose，是不允许执行 of(context)操作。 of(context)操作指的是 context.dependOnInheritedWidgetOfExactTyp。 当然，如果想在 initState 下调用也行，增加一个 Future 执行就可以成功执行
@override
void initState() {
super.initState();
Future((){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("initState")));
});
}
简单理解，因为 Dart 是单线程轮询执行，initState里的 Future相当于是下一次轮询，自然也就不在 _StateLifecycle.created的状态下。
可以在 build 里直接调用吗？
直接在 build里调用肯定可以，虽然 build会被比较频繁执行，但是 of(context)操作其实就是在一个 map 里通过 key - value 获取泛型对象，所以对性能不会有太大的影响。
真正对性能有影响的是 of(context)的绑定数量和获取到对象之后的自定义逻辑，例如你通过 MediaQuery.of(context).size获取到屏幕大小之后，通过一系列复杂计算来定位你的控件。
@override
Widget build(BuildContext context) {
var size = MediaQuery.of(context).size;
var padding = MediaQuery.of(context).padding;
var width = size.width / 2;
var height = size.width / size.height  *  (30 - padding.bottom);
return Container(
color: Colors.amber,
width: width,
height: height,
);
}

31.控件圆角裁剪
日常开发中我们大致上会使用两种圆角方案：
一种是通过 Decoration 的实现类 BoxDecoration 去实现。
一种是通过 ClipRRect 去实现。 其中 BoxDecoration 一般应用在 DecoratedBox 、 Container 等控件，这种实现一般都是直接 Canvas 绘制时，针对当前控件的进行背景圆角化，并不会影响其 child 。这意味着如果你的 child 是图片或者也有背景色，那么很可能圆角效果就消失了。 而 ClipRRect 的效果就是会影响 child 的，具体看看其如下的 RenderObject 源码可知。

32.Flutter中图片的缓存
Flutter 默认在进行图片加载时，会先通过对应的 `ImageProvider` 去加载图片数据，然后通过 PaintingBinding 对数据进行编码，之后返回包含编码后图片数据和信息的 ImageInfo去实现绘制。

本身这个逻辑并没有什么问题，问题就在于 Flutter 中对于图片在内存中的 Cache 对象是一个 `ImageStream` 对象。

Flutter 中 ImageCache 缓存的是一个异步对象，缓存异步加载对象的一个问题是：在图片加载解码完成之前，你无法知道到底将要消耗多少内存，并且大量的图片加载，会导致的解码任务需要产生大量的IO。

所以一开始最粗暴的情况是：通过 `PaintingBinding.instance` 去设置 `maximumSize` 和 `maximumSizeBytes`，但是这种简单粗爆的处理方法并不能解决长列表图片加载的溢出问题，因为在长列表中，快速滑动的情况下可能会在一瞬间“并发”出大量图片加载需求。

所以在 1.17 版本上，官方针对这种情况提供了场景化的处理方式： ScrollAwareImageProvider。

在 `Image` 控件中原本 `_resolveImage` 方法所使用的 `imageProvider` 被 `ScrollAwareImageProvider` 所代理，并且多了一个叫 `DisposableBuildContext<State<Image>>` 的 context 参数。那 `ScrollAwareImageProvider` 的作用是什么呢？

其实 `ScrollAwareImageProvider` 对象最主要的使用就是在 `resolveStreamForKey` 方法中，通过 `Scrollable.recommendDeferredLoadingForContext` 方法去判断当前是不是需要推迟当前帧画面的加载，换言之就是：是否处于快速滑动的过程。

那 `Scrollable.recommendDeferredLoadingForContext` 作为一个 `static` 方法，如何判断当前是不是处于列表的快速滑动呢？

这就需要通过当前 `context` 的 `getElementForInheritedWidgetOfExactType` 方法去获取 `Scrollable` 内的 `_ScrollableScope` 。

`_ScrollableScope` 是 `Scrollable` 内的一个 `InheritedWidget` ，而 Flutter 中的可滑动视图内必然会有 `Scrollable` ，所以只要 `Image` 是在列表内，就可以通过 `context.getElementForInheritedWidgetOfExactType<_ScrollableScope>()` 去获取到 `_ScrollableScope` 。

获取到 `_ScrollableScope` 就可以获取到它内部的 `ScrollPosition` ， 进而它的 `ScrollPhysics` 对应的 `recommendDeferredLoading` 方法，判断列表是否处于快速滑动状态。所以判断是否快速滑动的逻辑其实是在 `ScrollPhysics`。

如果判断此时不再是快速滑动，就走正常的图片加载逻辑。

在 `ScrollAwareImageProvider` 的 `resolveStreamForKey` 方法中，当 `stream.completer != null` 且存在缓存时，直接就去加载原本已有的流程，如果快速滑动过程中图片还没加载的，就先不加载。

而 `resolveStreamForKey` 将原本 `imageCache` 和 `ImageStreamCompleter` 的流程抽象出来，并且在 `ScrollAwareImageProvider` 中重写了 `resolveStreamForKey` 方法的执行逻辑，这样快速滑动时，图片的下载和解码可以被中断，从而减少了不必要的内存占用。

虽然这种方法不能100%解决图片加载时 OOM 的问题，但是很大程度优化了列表中的图片内存占用，官方提供的数据上看理论上可以在原本基础上节省出 70% 的内存。

Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M。

`Image` 组件的`image` 参数是一个必选参数，它是ImageProvider类型。下面我们便详细介绍一下`ImageProvider`，`ImageProvider`是一个抽象类，定义了图片数据获取和加载的相关接口。它的主要职责有两个：

1. 提供图片数据源
2. 缓存图片

ImageProvider通过load()方法加载图片数据源的接口，不同的数据源的加载方法不同，每个`ImageProvider`的子类必须实现它。比如`NetworkImage`类和`AssetImage`类，它们都是ImageProvider的子类，但它们需要从不同的数据源来加载图片数据：NetworkImage是从网络来加载图片数据，而AssetImage则是从最终的应用包里来加载（加载打到应用安装包里的资源图片）。

Flutter 中 ImageCache 缓存的是 ImageStream 对象，也就是缓存的是一个异步加载的图片的对象。WidgetsFlutterBinding这个混入类，其中Mixins 了 PaintingBinding ，这个 binding 就是负责图片缓存，在 PaintingBinding内有一个 ImageCache对象，该对象全局一个单例的，在图片加载时的被 ImageProvider所使用。

ImageProvider主要负责图片数据的加载和缓存，而绘制部分逻辑主要是由RawImage来完成。 而Image正是连接起ImageProvider和RawImage的桥梁。

项目中可以使用CachedNetworkImage，CachedNetworkImage除了可以缓存图片，还可以提供占位图

CachedNetworkImage(
imageUrl: 'https://picsum.photos/250?image=9',
);
