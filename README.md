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