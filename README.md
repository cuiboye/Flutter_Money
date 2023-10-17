1.Flutter的跨平台
为什么可以一套代码运行在多个平台上？Flutter跨平台原理？Flutter的性能为什么可以媲美原生？
先说下android系统的绘制，Android系统的绘制Bitmap和Canvas都是调用skia引擎来实现的，首先拿到xml文件，通过DOM解析，xml想要变成页面上可以看到的东西，就得将xml解析出来，然后再通过反射构建TextView，然后调用TextView中的onDraw()方法，只有调用onDraw()方法才能调用canvas，最后通过skia将图像渲染到屏幕上。

Flutter通过将drat语言转换为skia可以认识的API，Flutter的启动和Android的启动是一样的，入口都是MainActivity，MainActivity继承自FlutterActivity，FlutterActivity的onCreate方法中将FlutterActivityAndFragmentDelegate这个delegate添加到了setContantView中，在FlutterActivityAndFragmentDelegate中的onCreateView将FlutterSurfaceView添加进了FlutterView中，FlutterView其实就是一个FrameLayout，FlutterSurfaceView继承自SurfaceView，相当于是原生提供了一个画布，让Flutter可以在这个画布上面任意的操作。
SurfaceView和Surface
SurfaceView的双缓冲机制使用两个缓冲区分别处理帧的绘制和展示，即当应用绘制下一帧时，
它不是直接绘制在屏幕上，而是在一个后备缓冲区中绘制，待所有绘制完成后，将该缓冲区的内
容直接绘制在屏幕上以完整的显示帧。在绘制当前帧期间，上一帧仍显示在屏幕上，由此可以看
出SurfaceView的双缓冲机制可以避免出现卡顿。
SurfaceView和Surface的关系？
Surface对应了一块屏幕缓冲区，Surface中的Canvas是用来画画的场所，就像黑板一样，得
到了Surface就得到了Canvas，缓冲区和其他内容，Surface是用来管理数据的。SurfaceView是
把这些数据显示到屏幕上。

Flutter提供了一套Dart API，在底层通过OpenGL这种跨平台的绘制库调用操作系统的API，OpenGL调用显卡驱动告诉GPU干活，GPU经过各种计算把最终的图像渲染出来。由于Dart API也是调用了操作系统的API，不需要像原生那样进行DOM解析和反射组件，所以性能和原生接近。虽然Dart显示调用了OpenGL，OpenGL才会调用操作系统API，但是它仍然是原生渲染，因为OpenGL只是操作系统API的一个封装库，它并不像WebView渲染那样需要JavaScript运行环境和CSS渲染器，所以不会有性能损失。
垂直同步信号：
显示器上的图像是由像素点构成的，为了更新显示画面，显示器是以固定的频率刷新（从GPU取数据），手机屏幕的刷新频率是60Hz，当一帧图像绘制完毕后准备绘制下一帧时，显示器会发出一个垂直同步信号（VSync,16毫秒发送一次），60Hz就会在一秒内发出60次（每次差不多为16毫秒）这样的信号，而这个信号主要是用于同步CUP、GPU和显示器的。CUP将计算好的显示内容交给GPU，GPU渲染后放入帧缓冲区，然后视频控制器按照同步信号从帧缓冲区取帧数据传递给显示器显示。
Skia
Skia引擎是图像渲染引擎，Skia能实现用户手指交互与渲染，文字排版引擎等。在安卓上，系统自带了Skia，在每个平台上都包含了Skia引擎，Flutter是基于Skia引擎实现跨平台的。
Flutter的架构：
框架层：可以理解为UI层，最上面的是Material和Cupertino库，提供符合Material和iOS的设计规范，然后就是widget层，再往下就是渲染层，用于基于widget树生成渲染树，再往下就是底层的基础层（这个在开发中很少打交道）。
引擎层：引擎层是flutter的核心部分，核心api的底层实现，比如图形绘制，文本布局，网络请求，io操作，dart运行环境创建等。这一层有个很重要的部分就是图片渲染，所有的widget最终的目的都是为了绘制在屏幕上，这块的底层实现就是依靠Skia，Skia也是开源库，同时兼容了多个平台。所有flutter UI层的代码，都是用dart语言编写的，在发布的时候，会编译成native语言，然后交给Skia去渲染。Flutter和原生交互使用MethodChnnel的核心实现也是在引擎层跟原生交互，需要各个平台去适配，比如高德官方的flutter地图插件不支持POI检索，就需要flutter用MethodChnnel发起一个方法调用，ios和Android接收这个方法，各自集成原生的地图SDK，然后通过原生的SDK调用POI功能，再把结果返回给flutter。
嵌入层：嵌入层可以与原生的底层操作系统进行交互，可以根据不同的平台单独实现，实现语言也不一样，可以把嵌入层理解为一个壳子，flutter应用本体是一个模块，套一个Android的壳，就是一个Android的应用，套一个ios的壳，就是一个ios的应用。

总结：flutter用一个跨平台的开发语言Dart来开发UI层，然后核心功能用C++实现，最后用嵌入层做一层包装，适配各个不同的平台，由于UI部分，都是在框架层，从而实现跨平台的实现。另外由于flutter是直接跟原生接口打交道，所以在性能上也会媲美原生app，这也是Flutter为什么可以跨平台的原因。
跟Android、iOS原生开发类似，Flutter用dart语言实现一整套UI控件。Flutter先将控件树转成渲染树，然后交由skia库绘制界面，Skia的绘制页面是通过OpenGL底层图形接口来完成的，Skia应用广泛并且可以跨平台，Skia屏蔽了底层图形API接口的差异，可以用于Flutter和Android操作系统，还支持Mac,IOS,Widdows和浏览器。
OpenGL
OpenGL（Open Graphics Library”）是目前使用最广泛的跨平台图形API接口，跨平台特性好，大部分操作系统和GPU。Skia在大部分平台采用OpenGL实现GPU绘图，少部分平台调用Metal和vulkan(IOS)。Metal是苹果公司2014年推出的和 OpenGL类似的面向底层的图形编程接口，只支持iOS。Vulkan是新一代跨平台的2D和3D绘图应用程序接口（API）,旨在取OpenGL，理论上性能强于OpenGL。Skia对上述三种图形接口进行了封装，屏蔽了不同底层图形API接口的差异。OpenGL接口的封为GrGLOpsRenderPass，Metal的封装层为GrMTOpsRenderPass,Vuklan的封装层为 GrVKOpsRenderPass。

Flutter 上的渲染，是先由 Dart 侧主动发起垂直同步信号的请求，而不是被动等待垂直信号的通知。等到垂直同步信号到来后，再通过回调通知Dart进行渲染。

2.UI相关
Widget，Element，Renderobject
StatefulWidget和StatelessWidget是没有对应的RenderObject。在Flutter渲染流程中，最终是针对Render树中的目标进行渲染；当一个Widget被创立时，都会经过createElement办法创立一个Element加入到Element树中，然后会执行mount办法，此刻假如含RenderObject(Element是否承继自RenderObjectElement)，则会在mount办法中经过createRenderObject办法创立RenderObject树，反之则不创立。
在Flutter三棵树中Widget和Element的节点是一一对应，而RenderObject是少于或等于Widget的数量的。当Widget是RenderObjectWidget的派生类的时分才有对应的RenderObject。
RenderObject的子类会重写createRenderObject来创建对应的RenderObject。
RepaintBoundary是继承 SingleChildRenderObjectWidget,也属于RenderObjectWidget的派生类，所以RepaintBoundary也会有对应的RenderObject，当RepaintBoundary对应的RenderObject中的isRepaintBoundary为true时此时当前节点的RenderObject(以及子节点)的绘制会在新创立Layer完结,这样就和其他Layer做了隔离，由于Layer是能够复用的，这样帧改写的时候就不需要把每个RenderObject的paint办法都履行一遍。

Widget树和Element树节点是一一对应关系，每一个Widget都会有其对应的Element，但是RenderObject树则不然，只有需要渲染的Widget才会有对应的节点。
Element树相当于一个中间层，它持有Widget和RenderObject的引用。当Widget不断变化的时候，将新旧Widget进行对比，看一下和之前保留的Widget类型和key是否相同，如果都一样，那完全没有必要重新创建Element和RenderObject，只需要更新里面的一些属性即可，这样可以以最小的开销更新RenderObject，引擎在解析RenderObject的时候，发现只有属性修改了，那么也可以以最小的开销来做渲染。
简单总结：
Widget树就是配置信息的树
RenderObject树是渲染树，负责计算布局，绘制，Flutter引擎就是根据这棵树来进行渲染的。
Element树作为中间者，管理着Widget的生成和RenderObject的更新操作.

Widget、RenderObject和Elements的关系
Widget：仅用于存储渲染所需要的信息
RenderObject：负责管理布局、绘制等操作
Element：才是这颗巨大的控件树上的实体
Widget会被inflate（填充）到Element，并由Element管理底层渲染树。Widget并不会直接管理状态及渲染，而是通过State这个对象来管理状态。Flutter创建Element得可见树，相对于Widget来说，是可变的，通常界面开发中，我们不用直接操作Eelement，而是由框架层实现内部逻辑。就如一个UI视图树中，可能包含多个TextWidget（Widget被使用多次），但是放在内部视图树的视角，这些TextWidget都是填充到一个个独立的Element中。Element会持有renderObject和widget实例。记住，Widget只是一个配置，RenderObject负责管理布局、绘制等操作，在第一次创建Widget的时候，会对应创建一个Element，然后将该元素插入树中。如果之后Widget发生了变化，则将其与旧的Widget进行比较，并且相应地更新Element。重要的是，Element不会被重建，只是更新而已。

Widget 存放渲染内容、视图布局信息
Element - 存放上下文信息，通过 Element 遍历视图树，Element 同时持有Widget和
RenderObject - 根据 Widget 的布局属性进行 layout，对 widget 传入的内容进行渲染绘制
Element 是如何发挥其纽带作用的?
每个 Widget 会创建一个对应的 Element 对象 (通过 Widget.createElement())
每个 Element 会持有对应 Widget 对象的引用 (注意 createElement() 方法第一个参数)
RenderObjectElement 是 Element 的子类，这种 Element 持有一个 RenderObject 对象的引用 其次，Element 也是树形结构。我们常说 Widget 是配置/蓝图，其实更具体来说 Widget 是 Element 的配置/蓝图。 配置(Widget)的变更导致 Element 树进行相应地更新。Element.updateChild() 是 Widget 系统的核心方法，它负责处理这个更新。 Widget 的更新和 Element 的更新有着非常重大的差别：
Widget 是配置数据，是轻量级对象。Widget 的更新对应着 StatelessWidget.build() 和 StatefulWidget.build()，重新创建整个 Widget 树，是个全量过程。
Element 是重量级对象。Element 的更新对应着 Element.updateChild()，更新整个 Element 树，是个增量过程。 RenderObjectWidget分为SingleChildRenderObjectWidget 和MultiChildRenderObjectWidget

Flutter的绘制流程
在Flutter中，UI都是一帧一帧的绘制，但这绘制的背后都会经过如下阶段
1.动画与微任务阶段，主要是处理动画及执行一系列微任务
2.构建阶段（build），找出标记为“脏”的节点与布局边界直接的所有节点，并做相应的更新
3.布局阶段，计算Widget的大小及位置的确定
4.compositingBits阶段。重绘之前的预处理操作，检查RenderObject是否需要重绘
5.绘制阶段，根据Widget大小及位置来绘制UI
6.compositing阶段，将UI数据发生给GPU处理
7.semantics阶段，与平台的辅助功能相关
8.finalization阶段，主要是从Element树中移除无用的Element对象及处理绘制结束回调

Flutter 中存在 Widget 、 Element、RenderObject、Layer四棵树，其中 Widget与Element是多对一的关系 ，Element中持有Widget和 RenderObject， 而 Element与 RenderObject是一一对应的关系（除去 Element 不存在 RenderObject 的情况，如 ComponentElement(组合)是不具备 RenderObject)，
当 RenderObject的 isRepaintBoundary为true` 时，那么这个区域形成一个 Layer，所以不是每个RenderObject都具有 Layer 的，因为这受 isRepaintBoundary的影响。
Flutter 中 Widget不可变，每次保持在一帧，如果发生改变是通过 State 实现跨帧状态保存，而真实完成布局和绘制数据的是 RenderObject ，Element充当两者的桥梁， State就是保存在 Element` 中。
Flutter 中的 BuildContext 只是接口，而 Element实现了它。
Flutter 中 setState 其实是调用了 markNeedsBuild，该方法内部标记此Element 为 Dirty，然后在下一帧也就是垂直同步信号到来时 WidgetsBinding.drawFrame 才会被绘制，这可以看出 setState并不是立即生效的。
通过isRepaintBoundary 往上确定了更新区域，通过 requestVisualUpdate 方法触发更新往下绘制。
因为Element复用的原因所以页面刷新的时候Widget和Element的生命方法并不会重复调用（解决构建耗时性能问题），但是在不使用RepaintBoundary的情况下RenderObject中的paint方法会被频繁调用。
当RenderObject中isRepaintBoundary返回true时当前节点的RenderObject(以及子节点)的绘制会在新创建Layer完成,这样就和其他Layer做了隔离，因为Layer是可以复用的，这样帧刷新的时候就不需要把每个RenderObject的paint方法都执行一遍。
Flutter 中 InheritedWidget一般用于状态共享，如Theme、 MediaQuery等，都是通过它实现共享状态，这样我们可以通过 context 去获取共享的状态，比如 ThemeData theme = Theme.of(context);
Flutter 中默认主要通过 runtimeType和 key判断更新：
static bool canUpdate(Widget oldWidget, Widget newWidget) {
return oldWidget.runtimeType == newWidget.runtimeType
&& oldWidget.key == newWidget.key;
}
Flutter 中存在 Widget 、 Element 、RenderObject 、Layer 四棵树，其中 Widget 与 Element 是多对一的关系 ，Element 中持有Widget 和 RenderObject ， 而 Element 与 RenderObject 是一一对应的关系 。
3）当 RenderObject 的 isRepaintBoundary 为 true 时，那么这个区域形成一个 Layer，所以不是每个 RenderObject 都具有 Layer 的，因为这受 isRepaintBoundary 的影响。
4）Flutter 中 Widget 不可变，每次保持在一帧，如果发生改变时通过 State 实现跨帧状态保存，而真实完成布局和绘制数组的是 RenderObject ， Element 充当两者的桥梁， State 就是保存在 Element 中。
5）Flutter 中的 BuildContext 只是接口，而 Element 实现了它。
6）Flutter 中 setState 其实是调用了 markNeedsBuild ，该方法内部标记此Element 为 Dirty ，然后在下一帧 WidgetsBinding.drawFrame 才会被绘制，这可以看出 setState 并不是立即生效的。
7）通过isRepaintBoundary 往上确定了更新区域，通过 requestVisualUpdate 方法触发更新往下绘制。
8）在 Element 的 inheritFromWidgetOfExactType 方法实现里，有一个 Map _inheritedWidgets 的对象。_inheritedWidgets 一般情况下是空的，只有当父控件是 InheritedWidget 或者本身是 InheritedWidgets 时才会被初始化，而当父控件是 InheritedWidget 时，这个 Map 会被一级一级往下传递与合并 。所以当我们通过 context 调用 inheritFromWidgetOfExactType 时，就可以往上查找到父控件的 Widget 。

布局和渲染流程？
1）图画显现原理
CPU担任图画数据核算, 然后交给 GPU
GPU担任图画数据烘托, 烘托后放入帧缓冲区
视频控制器根据笔直同步信号（VSync）以每秒60次的速度，从帧缓冲区读取帧数据交由显现器完结图画显现。
UI线程运用Dart来构建视图结构数据(Widget)，这些数据会在GPU线程进行图层组成，随后交给Skia引擎加工成GPU数据，GPU数据经过OpenGL终究提供给GPU烘托。需要在两个VSync信号之间完结这些操作,不然会卡顿

        2）Skia是什么？
        Skia是一款C++开发的、跨平台、功能优秀的2D图画制作引擎
        Skia是Android官方的图画烘托引擎，所以无需内嵌Skia引擎就可以取得天然的Skia支持；
        iOS: 嵌入到Flutter的 iOS SDK中，代替了iOS闭源的Core Graphics/Core Animation/Core Text，这也正是 iOS App包体积比Android要大一些的原因。
        Skia 优点
        Skia一致了各个系统的烘托逻辑, 保证同一套代码在Android和iOS平台上的烘托作用是完全一致的。
        3）Flutter界面烘托进程
        页面中的Widget以树的方式组织成控件树。
        为控件树中的每个Widget创建不同类型的绘制目标(RenderObject)，组成绘制目标树。
        绘制目标树展现进程分为四个阶段：布局、制作、组成和绘制
        4）布局
        Flutter采用深度优先遍历绘制目标树，决定绘制目标树中各绘制目标在屏幕上的位置和尺度。
        绘制目标树中的每个绘制目标都会接纳父目标的布局约束参数，决定自己的大小，
        父目标依照控件逻辑决定各个子目标的位置，完成布局进程。
        5）制作
        把绘制目标制作到不同的图层上。
        制作进程也是深度优先遍历，先制作本身，再制作子节点。


Element
Element的生命周期
Framework 调用Widget.createElement 创建一个Element实例，记为element
Framework 调用 element.mount(parentElement,newSlot) ，mount方法中首先调用element所对应Widget的createRenderObject方法创建与element相关联的RenderObject对象，然后调用element.attachRenderObject方法将element.renderObject添加到渲染树中插槽指定的位置（这一步不是必须的，一般发生在Element树结构发生变化时才需要重新attach）。插入到渲染树后的element就处于“active”状态，处于“active”状态后就可以显示在屏幕上了（可以隐藏）。
当有父Widget的配置数据改变时，同时其State.build返回的Widget结构与之前不同，此时就需要重新构建对应的Element树。为了进行Element复用，在Element重新构建前会先尝试是否可以复用旧树上相同位置的element，element节点在更新前都会调用其对应Widget的canUpdate方法，如果返回true，则复用旧Element，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element。Widget.canUpdate主要是判断newWidget与oldWidget的runtimeType和key是否同时相等，如果同时相等就返回true，否则就会返回false。根据这个原理，当我们需要强制更新一个Widget时，可以通过指定不同的Key来避免复用。
当有祖先Element决定要移除element 时（如Widget树结构发生了变化，导致element对应的Widget被移除），这时该祖先Element就会调用deactivateChild 方法来移除它，移除后element.renderObject也会被从渲染树中移除，然后Framework会调用element.deactivate 方法，这时element状态变为“inactive”状态。
“inactive”态的element将不会再显示到屏幕。为了避免在一次动画执行过程中反复创建、移除某个特定element，“inactive”态的element在当前动画最后一帧结束前都会保留，如果在动画执行结束后它还未能重新变成“active”状态，Framework就会调用其unmount方法将其彻底移除，这时element的状态为defunct,它将永远不会再被插入到树中。
如果element要重新插入到Element树的其他位置，如element或element的祖先拥有一个GlobalKey（用于全局复用元素），那么Framework会先将element从现有位置移除，然后再调用其activate方法，并将其renderObject重新attach到渲染树。 看完Element的生命周期，可能有些读者会有疑问，开发者会直接操作Element树吗？其实对于开发者来说，大多数情况下只需要关注Widget树就行，Flutter框架已经将对Widget树的操作映射到了Element树上，这可以极大的降低复杂度，提高开发效率。但是了解Element对理解整个Flutter UI框架是至关重要的，Flutter正是通过Element这个纽带将Widget和RenderObject关联起来，了解Element层不仅会帮助读者对Flutter UI框架有个清晰的认识，而且也会提高自己的抽象能力和设计能力。另外在有些时候，我们必须得直接使用Element对象来完成一些操作，比如获取主题Theme数据。

Element的生命周期
Element有4种状态：initial，active，inactive，defunct。其对应的意义如下：
initial：初始状态，Element刚创建时就是该状态。
active：激活状态。此时Element的Parent已经通过mount将该Element插入Element Tree的指定位置，Element此时随时可能显示在屏幕上。
inactive：未激活状态。当Widget Tree发生变化，Element对应的Widget发生变化，同时由于新旧Widget的Key或者的RunTimeType不匹配等原因导致该Element也被移除，因此该Element的状态变为未激活状态，被从屏幕上移除。并将该Element从Element Tree中移除，如果该Element有对应的RenderObject，还会将对应的RenderObject从Render Tree移除。
defunct：失效状态。如果一个处于未激活状态的Element在当前帧动画结束时还是未被复用，此时会调用该Element的unmount函数，将Element的状态改为defunct，并对其中的资源进行清理。     
Element的分类
Element从功能上可以分为两大类：ComponentElement和RenderObjectElement
ComponentElement:组合类Element
这类Element主要用来组合其他更基础的Element，得到功能更加复杂的Element。开发时常用到的StatelessWidget和StatefulWidget相对应的Element：StatelessElement和StatefulElement，即属于ComponentElement。ComponentElement持有Parent Element及Child Element，由此构成Element Tree。ComponentElement持有其对应的Widget,对于StatefulElement，其还持有对应的State，以此实现Element和Widget之间的绑定。
State是被StatefulElement持有，而不是被StatefulWidget持有，便于State的复用。事实上，State和StatefulElement是一一对应的，只有在初始化StatefulElement时，才会初始化对应的State并将其绑定到StatefulElement上。
RenderObjectElement: 渲染类Element
对应RendererObjectWidget和RenderObject，是框架最核心的Element。RenderObjectElement主要包括SingleChildRenderObjectElement如SizeBox和MultiChildRenderObjectElement。其中，SingleChildRenderObjectElement对应的Widget是SingleChildRenderObjectWidget，有一个子节点；MultiChildRenderObjectElement对应的Widget是MultiChildRenderObjecWidget，有多个子节点。
Element的inflateWidget会触发RenderObjectWidget的createElement创建RenderObjectElement,
再调用RenderObjectElement的mount方法
mount方法调用RenderObjectWidget的createRenderObject方法创建RenderObject
然后找到最近的一个父RenderObjectElement调用insertRenderObjectChild插入RenderObject

Element的创建过程
1 当Element=null ,newWidget=null Element的值直接返回null
2 当Element=null.newWidget!=null 就是之前这个地方没有widget，但是刷新一下之后出现了一个widget，就相当于新创建，于是走的是inflateWidget
3 当Element！=null ,newWidge==null 就是之前这个地方有一个widget，刷新之后这个Widget没有了，那么这个时候需要回收之前创建的Element，于是这里执行了 deactivateChild(child);
4 当Element！=null ,newWidge！=null 的时候，这里也可以分为两种情形 通过判断新旧widget的runtimetype和key是否一致来判断对应的element是不是可以复用，如果可以复用只需要调用 Element的update(newWidget)更新一个Widget就可以了，如果不可复用将回收旧的element(deactivateChild)然后创建一个新的element(inflateWidget).
RenderObject
StatelessWidget和 StatefulWidget都是用于组合其他组件的，它们本身没有对应的 RenderObject。Flutter 组件库中的很多基础组件都不是通过StatelessWidget和 StatefulWidget来实现的，比如 Column、Align等，就好比搭积木，StatelessWidget和 StatefulWidget可以将积木搭成不同的样子，但前提是得有积木，而这些积木都是通过自定义 RenderObject 来实现的。实际上Flutter 最原始的定义组件的方式就是通过定义RenderObject 来实现，而StatelessWidget和 StatefulWidget只是提供的两个帮助类。 每个Element都对应一个RenderObject，我们可以通过Element.renderObject 来获取。并且我们也说过RenderObject的主要职责是Layout和绘制，所有的RenderObject会组成一棵渲染树Render Tree。本节我们将重点介绍一下RenderObject的作用。RenderObject就是渲染树中的一个对象，它主要的作用是实现事件响应以及渲染管线中除过 build 的部分（build 部分由 element 实现），即包括：布局、绘制、层合成以及上屏，RenderObject拥有一个parent和一个parentData属性，parent指向渲染树中自己的父节点，而parentData是一个预留变量，在父组件的布局过程，会确定其所有子组件布局信息（如位置信息，即相对于父组件的偏移），而这些布局信息需要在布局阶段保存起来，因为布局信息在后续的绘制阶段还需要被使用（用于确定组件的绘制位置），而parentData属性的主要作用就是保存布局信息，比如在 Stack 布局中，RenderStack就会将子元素的偏移数据存储在子元素的parentData中。 RenderObject类本身实现了一套基础的布局和绘制协议，但是并没有定义子节点模型（如一个节点可以有几个子节点，没有子节点？一个？两个？或者更多？）。 它也没有定义坐标系统（如子节点定位是在笛卡尔坐标中还是极坐标？）和具体的布局协议（是通过宽高还是通过constraint和size?，或者是否由父节点在子节点布局之前或之后设置子节点的大小和位置等）。 为此，Flutter框架提供了一个RenderBox和一个RenderSliver类，它们都是继承自RenderObject`，布局坐标系统采用笛卡尔坐标系，屏幕的左上角(top, left)是原点。而 Flutter 基于这两个类分别实现了基于 RenderBox 的盒模型布局和基于 Sliver 的按需加载模型， StatelessWidget和StatefulWidget继承自Widget，而Opacity 和 ErrorWidget 等控件都是继承RenderObject，Element 是联系 Widget 和 RenderObject 的纽带。

Widget
key
Key: 这个key属性类似于 React/Vue 中的key，主要的作用是决定是否在下一次build时复用旧的 Element和RenderObject ，决定的条件在canUpdate()方法中。
static bool canUpdate(Widget oldWidget, Widget newWidget) {
return oldWidget.runtimeType == newWidget.runtimeType
&& oldWidget.key == newWidget.key;
}
GlobalKey
GlobalKey GlobalKey 是 Flutter 提供的一种在整个 App 中引用 element 的机制。如果一个 widget 设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该 widget 对象、globalKey.currentElement来获得 widget 对应的element对象，如果当前 widget 是StatefulWidget，则可以通过globalKey.currentState来获得该 widget 对应的state对象。 注意：使用 GlobalKey 开销较大，如果有其他可选方案，应尽量避免使用它。另外，同一个 GlobalKey 在整个 widget 树中必须是唯一的，不能重复。
canUpdate
canUpdate(…)是一个静态方法，它主要用于在 widget 树重新build时复用旧的 widget ，其实具体来说，应该是：是否用新的 widget 对象去更新旧UI树上所对应的Element对象的配置；通过其源码我们可以看到，只要newWidget与oldWidget的runtimeType和key同时相等时就会用new widget去更新Element对象的配置，否则就会创建新的Element。 Widget这是描述一个UI元素的配置信息，真正的布局，绘制是由谁来完成的？ Flutter 框架的的处理流程是这样的：
根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。
根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。 组件最终的Layout、渲染都是通过RenderObject来完成的，从创建到渲染的大体流程是：根据Widget生成Element，然后创建相应的RenderObject并关联到Element.renderObject属性上，最后再通过RenderObject来完成布局排列和绘制。所以真正的布局和渲染逻辑在 Render 树中，Element 是 Widget 和 RenderObject 的粘合剂，可以理解为一个中间代理。 三棵树中，Widget 和 Element 是一一对应的，但并不和 RenderObject 一一对应。比如 StatelessWidget 和 StatefulWidget 都没有对应的 RenderObject。 渲染树在上屏前会生成一棵 Layer 树。 2）ContextBuild方法有一个context参数，它是BuildContext类的一个实例，表示当前 widget 在 widget 树中的上下文，每一个 widget 都会对应一个 context 对象（因为每一个 widget 都是 widget 树上的一个节点）。实际上，context是当前 widget 在 widget 树中位置中执行”相关操作“的一个句柄(handle)，比如它提供了从当前 widget 开始向上遍历 widget 树以及按照 widget 类型查找父级 widget 的方法。下面是在子树中获取父级 widget 的一个示例
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
InheritedWidget
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

Widget的作用
1）Widget的所有方法，都是在同个线程（主线程）按照从外层到内层逐级往里调用，也就是主线程，dart中叫main ioslate，如果在Widget中，有耗时的方法，应该放在异步执行，可以使用compute，或者ioslate提供的异步方法
3）Widget的目的是为了生成对应的Element，也就是Widget树是为了生成对应的element树。

Widget是如何加载出来的？
Widget的加载，都是因为父Widget对应的Element调用了inflateWidget，然后调用了当前Widget的createElement和mount方法

Widget是如何绘制出来的？
所有的Widget会生成一个Widget树，所有的Element会生成一个Element树，所有的renderObject会生成一个RenderObject树，Element会持有Widget和RenderObject的引用，Widget和Element是一一对应的，Element和RenderObject不一定是一一对应的。
通过Widget生成Element，通过Element生成renderObject，通过RenderObject进行layout和paint来生成layer，最后将layer交给GPU去加载。

Flutter中Widget布局行为
首先，上层 widget 向下层 widget 传递约束条件；
然后，下层 widget 向上层 widget 传递大小信息。
最后，上层 widget 决定下层 widget 的位置。

紧约束和松约束：
tight（紧约束）：当 max 和 min 值相等时，这时传递给子类的是一个确定的宽高值。
紧约束使用的地方主要有两个：
1）Container的child == null && (constraints == null || !constraints!.isTight)
2）另一个ModalBarrier，这个组件我们不太熟悉，但查看调用发现被嵌套在了Route中，所以每次我们push一个新Route的时候，默认新的页面就是撑满屏幕的模式。
loose（松约束）：当 minWidth 和 minHeight 为 0，这时传递给子类的是一个不确定的宽高值
，在我们最常使用的Scaffold组件中就采用了这种布局，所以Scaffold对于子布局传递的是一个松的约束。
如果最大值和最小值都为0， 那它即是紧约束也是松约束

在Flutter中，每个组件都有自己的布局行为：
Root，传递紧约束，即它的子元素，必须是设备的尺寸，不然Root根本不知道未被撑满的内容该如何显示。
Container，在有Child的时候，传递紧约束，即子元素必须和它一样大，否则Container也不知道该怎么放置Child
对于Container来说：
- 有Child就选择Child的尺寸（有设置alignment时会将约束放松）
- 没有Child就撑满父级空间（父级空间为Unbound时，尺寸为0）
  Center，将紧约束转换为松约束，Center可以将父级的紧约束，变松，这样它的子元素可以选择放置在居中的位置，而子元素具体有多大？只要不超过父容器大小都可以，除了Center以外，还可以使用UnconstrainedBox，Align，这些都可以将紧约束放松为松约束。
  单个Child的容器布局方式，我们称之为Box布局，相对而言，类似Column和Row这样的布局方式，我们称之为Flex布局。

Row为例，Row对child的约束会修改为松约束，从而不会限制child在主轴方向上的尺寸，所以当Row内的Child宽度大于屏幕宽度时，就会产生内容溢出的警告。

当 Column 包裹 ListView 会出现异常 `Vertical viewport was given unbounded height.` 原因 Column 和 ListView 都是 `unbounded` height。无限高度组件嵌入无限高度组件就报异常了解决如下。对 ListView 用 Expanded 或者 Flexible 包裹，转为弹性组件，也即是占完Column 剩余的空间即可。

如果所有 Row 的子级都被包裹了 `Expanded` widget，那么每一个Widget的权重都是1，Expanded忽略了其子 Widget 想要的宽度。

Row要么使用子级的宽度，要么使用Expanded和Flexible从而忽略子级的宽度。

屏幕强制 Scaffold 变得和屏幕一样大，所以 Scaffold 充满屏幕。然后 Scaffold 告诉 Container 可以变为任意大小，但不能超出屏幕。
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

这种布局是左边是垂直方向的2个文本，右边是一个文本（右边的这个文本在左侧的水平中间位置）
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

在行列布局中，如何使得所有的部件跟宽度/高度最大的部件同宽/同高呢？
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

State
setState的作用？
setState其实就是告诉系统，在下一帧刷新的时候，需要更新当前widget，整个过程，是一个异步的行为，所以下面的三个写法，效果上是一样的。
写法一
_counter++;        
setState(() {});   
写法二
setState(() {  
_counter++;  
});            
写法三
setState(() {});
_counter++;
Flutter中的两大组件为StatefulWidget和StatelessWidget，StatefulWidget中组件的状态是可以通过setState()方法来进行修改的，StatelessWidget中不能使用setState()。这是一个异步方法，通知框架该对象的内部状态发生了变化，对象状态的改变可能会影响子树中的用户界面，这会导致框架会调用build。在框架调用dispose之后调用此方法是错误的，为了避免这种情况，Flutter建议我们可以通过检查mounted属性是否为真来确定调用setState()是否合法。
if (mounted) setState(() {});
该方法中会调用StatefulElement的markNeedsBuild方法来标记这个元素会被用来重新构建RenderObject渲染树，如果当前元素不活跃的话或者已经设置完_dirty都会直接返回，调用BuildOwner的scheduleBuildFor方法将当前元素加入脏数据中，如果已经在脏数据集合中不需要重新添加，如果在脏数据中不存在当前要改变的元素则加入到脏数据_dirtyElements集合中，并标记元素已经放入脏数据集合中，可以看出SetState方法就是将当前的Element放入脏数据集合，而后标记它为脏元素，此时setState方法就处理完了。
那么是谁来处理的这个脏数据集合呢？
这里的脏数据集合其实就是用来记录当前哪些元素需要重新构建RenderObject的属性，从而重新实现哪些RenderObject需要重新渲染。通俗的讲就是每当硬件层的垂直同步信号到来将重新实现View树的测量、布局、重绘，然后将数据交给GPU渲染的屏幕上，也就是说每过约16.6666666....ms,脏数据元素会被处理一次，然后清空。

State.setState内部所做的工作:
StatelessWidget 经过 StatelessElement.build 触发 build
StatefulWidget 经过 StatefulElement.build 触发 State.build
1）setState的参数是一个VoidCallBack，这个回调就是我们自己写好的信息改变逻辑。
2）将StatefulWidget对应的StatefulElement标记为dirty。
3)在垂直同步信号回调后，会经过Native到Flutter engine调用Flutter的drawFrame方法，将之前标记为dirty的Element进行重新构建，在 widget 重新构建时会执行State.build()方法，Flutter 框架会调用widget.canUpdate来检测 widget 树中同一位置的新旧节点，然后决定是否需要更新，widget.canUpdate会在新旧 widget 的 key和 runtimeType 同时相等时会返回true，也就是说在在新旧 widget 的key和runtimeType同时相 等时Element会被复用，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element。

那么垂直同步信号是什么时候被注册的？
Flutter sdk中的Dart部分最重要的就是Binding类，而实现监听同步信号的Binding类为SchedulerBinding这个类，最终注册的方法为initInstances-》readInitialLifecycleStateFromNativeWindow-》handleAppLifecycleStateChanged-》scheduleFrame

Flutter在android中最终通过Choreographer（编排者）注册了垂直同步信号的监听方法，而注册了垂直信号之后，每过16.6毫秒最终会回调给Dart层。Flutter这边收到垂直同步信号后：
1）开始根据标记为脏数据元素重新构建渲染树：将根元素下的所有子元素都生成Element元素和调用对脏数据元素的重构方法rebuild，也就是从当前的节点的元素开始构建子元素以及子元素的RenderObject的创建，当然子元素并不一定重新创建，这需要和旧的元素去做比较。
2）重新测量布局和渲染，布局和渲染完成后将绘制的数据发送给GPU渲染。
pipelineOwner.flushLayout();//确定布局的位置
pipelineOwner.flushCompositingBits();
pipelineOwner.flushPaint();//开始执行画画
renderView.compositeFrame();//合并图层将绘制的数据发送给Gpu渲染
在子 widget 树中获取父级 StatefulWidget 的State 对象
由于 StatefulWidget 的具体逻辑都在其对应的 State 中，所以很多时候，我们需要获取 StatefulWidget 对应的 State对象来调用一些方法，比如 Scaffold 组件对应的状态类 ScaffoldState 中就定义了打开 SncakBar(路由底部提示条)的方法，我们有两种方法在子 widget 树中获取 父级 StatefulWidget的 State 对象。
通过context获取
context对象有一个findAncestorStateOfType()方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。
查找父级最近的Scaffold对应的ScaffoldState对象
ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>()!;
打开抽屉菜单
_state.openDrawer();
直接通过of静态方法来获取ScaffoldState
ScaffoldState _state=Scaffold.of(context);
_state.openDrawer();
如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；如果 State不希望暴露，则不提供of方法。

Widget和APP的生命周期：https://blog.csdn.net/eclipsexys/article/details/130097089?spm=1001.2014.3001.5502

State的生命周期
在Flutter中，一个 StatefulWidget 类会对应一个 State类，State表示与其对应的 StatefulWidget 要维护的状态，State中的保护的状态信息可以：
1)在widget构建时可以被同步读取；
2)在widget生命周期改变时可以被读取，当 State 被改变时，可以手动调用 其 setState() 方法通知 Flutter framework状态发送改变，Flutter framework在收到消息后，会重新调用其 build 方法重新构建 widget 树，从而达到更新UI的目的。

State 中有两个常用属性：
widget: 它表示与该State 实例关联的 widget 实例，由 Flutter framework 动态设置，不过这种关联并非永久，因为在应用生命周期中，UI树上的某一个节点 widget 实例在重新构建时可能会变化，但 State 实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter framework 会动态设置State, widget为新的 widget 实例。
context： StatefulWidget 对应的 BuildContext, 作用同 StatelessWidget 的 BuildContext一致。

StatefuleWidget中的State生命周期
1）createState：
该函数为 StatefulWidget 中创建 State 的方法，当 StatefulWidget 被创建时会立即执行 createState。createState 函数执行完毕后表示当前组件已经在 Widget 树中，此时有一个非常重要的属性 mounted 被置为 true。
createState 是在StatefulElement的构造方法中调用的，也就是创建StatefulElement的时候就创建了对应的State,而且这个State 在之后保持不变。

2）initState()
这是创建widget时调用的除构造方法外的第一个方法：类似于Android的：onCreate() 与iOS的 viewDidLoad(),在这个方法中通常会做一些初始化工作，比如channel的初始化，监听器的初始化等。
当 Widget 第一次插入到 Widget树时被调用。对于每一个 State 对象，Flutter framework只会调用一次回调。适合做一些一次性的操作，比如状态初始化，订阅子树的事件通知等。
不能在该回调中调用 BuildContext.dependOnInheritedWidgetOfExactType,原因是在初始化完成后， Widget 树中的 InheritFromWidget 也可能会发生变化，所以正确的做法应该在 build 方法或 didChangDependencied() 中调用它。

3）didChangeDependencies()
当依赖的State对象改变时会调用：
a.在第一次构建widget时，在initState（）之后立即调用此方法；
b.当State对象的依赖发生变化时会被调用；例如在build()中包含了一个InheritedWidget，然后在之后的build()中InheritedWidget中的属性发生了变化，那么此时InheritedWidget的子widget的didChangeDependencies()回调都会被调用。典型的场景是当系统语言 Locale 或应用主题改变时，Flutter 框架会通知 widget 调用此回调。需要注意，组件第一次被创建后挂载的时候（包括重创建）对应的didChangeDependencies也会被调用。

4）build()
主要是返回需要渲染的 Widget，由于 build 会被调用多次，因此在该函数中只能做返回 Widget 相关逻辑，避免因为执行多次而导致状态异常。
使用场景：
a.在调用initState()之后。
b.在调用didChangeDependencies()之后。
c.在调用setState()之后。
d.在调用didUpdateWidget()之后。
e.在State对象从树中一个位置移除后（会调用deactivate）又重新插 入 到树的其它位置之后。

5）reassemble()
此回调是专门为开发调试而提供，在热重载 (hot reload) 时被调用，此回调在 release 下永远不会被调用。

6）didUpdateWidget()
该函数主要是在`组件重新构建，比如说热重载，父组件发生 build 的情况下，子组件该方法才会被调用，其次`该方法调用之后一定会再调用本组件中的 build 方法。

在widget重新构建时，Flutter框架会调用 widget.canUpdate   来检测 widget 树中同一位置的新旧节点，然后决定是否需要更新，如果 widget.canUpdate 返回true则会调用此回调。 widget.canUpdate 会在新旧 widget 的key和runtimeType同时相等时会返回true，也就是说在在新旧 widget 的key和runtimeType同时相等时Element会被复用，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element，didUpdateWidget()也会被调用。

6）deactivate()
在组件被移除节点后会被调用，如果该组件被移除节点，然后未被插入到其他节点时，则会继续调用 dispose 永久移除。

7）dispose()
永久移除组件，并释放组件资源。调用完dispose后，mounted属性被设置为 false，也代表组件生命周期的结束。通常在该方法中执行一些资源的释放工作比如，监听器的卸载，channel的销毁等

StatelessWidget的构建方法通常只在三种情况下会被调用：
1）小组件第一次被插入树中
2）小组件的父组件改变其配置
3）以及它所依赖的 InheritedWidget 发生变化时。

StatefulWidget不同操作调用的方法：
1）初始化显示页面的时候执行的生命周期，主要是
createState
initState
didChangeDependencies
build

2）调用setState刷新页面的时候执行的生命周期，主要是
didUpdateWidget
build

3）当调用setState 的时候，会将对应的Element 标记为脏，等到下一帧到来的时候刷新该Element。实际就是在下一帧的时候调用脏Element 的rebuild 的方法。

4）关闭页面的时候执行的声明周期，主要是
deactivate
dispose
BuildContext:
BuildContext对象表示当前widget在widget树中的上下文，类似于Android中的Context。它实际上是Element，BuildContext接口用于阻止对Element对象的直接操作，它就是为了避免直接操纵Element类而创建的。

比如它提供了从当前 widget 开始向上遍历 Widget树以及按照Widget类型查找父级Widget的方法 findAncestorWidgetOfExactType。具体可以查看test2.dart这个文件。

Flutter 在 BuildContext 类中为我们提供了方法进行向上和向下的查找
abstract class BuildContext {
查找父节点中的T类型的State
T findAncestorStateOfType<T extends State>();
遍历子元素的Element对象
void visitChildElements(ElementVisitor visitor);
查找父节点中的T类型的 InheritedWidget 例如 MediaQuery 等
T dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({ Object aspect })
}
这个 BuildContext 对应我们在每个 Widget 的 build(context) 方法中的 context。可以把 context 当做树中的一个实体节点。借助 findAncestorStateOfType 方法，我们可以一层一层向上的访问到 WidgetA，获取到 name 属性。
调用的 findAncestorStateOfType()方法，会一级一级父节点的向上查找，很显然，查找快慢取决于树的深度。而数据共享的场景在 Flutter 中非常常见，比如主题，比如用户信息等，为了更快的访问速度，Flutter 中提供了dependOnInheritedWidgetOfExactType() 方法，它会将 InheritedWidget存储到Map中。不过这两种方法本质上都是通过树机制实现，他们都需要借助 context。

BuildContext：BuildContext是构建Widget中的应用上下文，BuildContext只出现在两地方：
1）创建StatelessWidget.build方法中
2）创建StatefulWidget的State对象的build方法中，它也是State的成员变量。
BuildContext实际是Element，主要目的是为了阻止直接对Eleemnt操作而抽象出来的，所以BuildContext是Element的抽象类，所有Element都继承自BuildContext,每一个Widget都有一个BuildContext。
BuildContext的作用：
BuildContext的作用主要是通过上下文获取制定的数据，例如Theme.of(context)或者showDialog(context:context)都需要BuildContext作为参数，这里的BuildContext就是调用这些方法的Widget的代表。

BuildContext和InheritedWidget
InheritedWidget是一种widget用来在tree中向下传递变动信息，在tree的子节点中，可以通过调用BuildContext.dependOnInheritedWidgetOfExactType在子节点中查找最近的父InheritedWidget，从而将当前的BuildContext绑定的widget和InheritedWidget建立绑定关系，从而在下次InheritedWidget发生变动的时候，会自动触发BuildContext绑定的widget的rebuild方法。

在BuildContext中，有两个查找并且进行绑定的方法,他们是：
InheritedWidget dependOnInheritedElement(InheritedElement ancestor, { Object aspect });
T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({ Object? aspect });

BuildContext的优化
Flutter 里的 BuildContext它实际是 Element 的抽象对象，而在 Flutter 里，它主要来自于 ComponentElement 。 关于 ComponentElement 可以简单介绍一下，在 Flutter 里根据 Element 可以简单地被归纳为两类：
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
避免更改组件树的结构和组件的类型
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
图片: https://uploader.shimo.im/f/pQFoQ2utpw99JoRc.png!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2OTc1MzMwMDAsImZpbGVHVUlEIjoiZ1hxbWRCYXZvNWlvR1kzbyIsImlhdCI6MTY5NzUzMjcwMCwiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.V0xVIcfQHBPgbUEOWrw62iuxHXP99O2jblYGTobeQ04
不可见时的组件树：
图片: https://uploader.shimo.im/f/ZTJ25P0HBrUjuKNW.png!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2OTc1MzMwMDAsImZpbGVHVUlEIjoiZ1hxbWRCYXZvNWlvR1kzbyIsImlhdCI6MTY5NzUzMjcwMCwiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.V0xVIcfQHBPgbUEOWrw62iuxHXP99O2jblYGTobeQ04
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
图片: https://uploader.shimo.im/f/VkIhdAhxa01oYYF5.png!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2OTc1MzMwMDAsImZpbGVHVUlEIjoiZ1hxbWRCYXZvNWlvR1kzbyIsImlhdCI6MTY5NzUzMjcwMCwiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.V0xVIcfQHBPgbUEOWrw62iuxHXP99O2jblYGTobeQ04

3.状态管理框架
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

4.事件传递和分发
参考文章：
https://juejin.cn/post/6844904083371851790
https://www.jianshu.com/p/b9a93763ef69
Android和Flutter层的事件是如何传递的
原生传递事件给Flutter的过程
在flutter中，一个事件的产生，会经过native，flutter engine和flutter层，native是生产者，engine是传递者，flutter是消费者。
Android也有自己的事件分发机制，整体就是dispatchTouchEvent-onInterceptTouchEvent-onTouchEvent这样一个流程，flutter在安卓中是以FlutterView(FrameLayout)为媒介的，flutter中所获取到的事件，实际上就是FlutterView在安卓体系中接收到的事件，再进一步通过flutter engine传递给flutter，安卓中的事件一般是通过onTouchEvent这个方法消费的，这个方法的参数是MotionEvent，然后把MotionEvent存储在ByteBuffer中交给flutter engine层，再进一步传递给flutter，最后通过flutter engine层将数据通过_dispatchPointerDataPacket传递给flutter。
传递给flutter后，会调用 PlatformDispatcher 的 onPointerDataPacket 函数，也就是在 GestureBinding 初始化时传给给 PlatformDispatcher 的 _handlePointerDataPacket，事件分发由此进入 flutter 层。其中还涉及到数据转换，engine 层向 flutter 层传递事件数据时并不能直接传递对象，也是先转成 buffer 数据再传递，此处还需要调用 _unpackPointerDataPacket 将 buffer 数据再转回 PointerDataPacket 对象。一个MotionEvent可能包含多个触摸点，需要将每一个触摸点的数据拆分开，依次装载到packet 中。
flutter层接收事件的过程
从 flutter app 的启动 runApp 函数中开始，对 WidgetsflutterBinding 进行了初始化，而 WidgetsflutterBinding 的其中一个 mixin 是 GestureBinding，即实现了手势相关的能力，包括从 native 层获取到事件信息，然后从 widget 树的根结点开始一步一步往下传递事件。
在 GestureBinding 中事件传递有两种方式，一种是通过 HitTest 过程，另一种是通过 route ，前者就是常规流程，GestureBinding 获取到事件之后，在 render 树中从根结点开始向下传递，而 route 方式则是某个结点通过向 GestureBinding 中的 pointerRoute 添加路由，使得 GestureBinding 接收到事件之后直接通过路由传递给对应的结点，相较于前一种方式，更直接，也更灵活。
程序入口是runApp，WidgetsFlutterBindbing混入了很多的mixin，手势相关的是GestureBinding这个混入类，会在GestureBinding的initInstances方法中对手势事件进行初始化。
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
如果结点（或其子结点）需要消费事件，就会调用 HitTestResult.add 将自己加入到 HitTestResult 的路径中，保存在 HitTestResult 的 _path 中，后面具体分发的时候就会根据按照这个路径进行。
事件从Android到Flutter的转换
事件从 android 传到 flutter 中执行了 5 次转换：
android 中，从 MotionEvent 中取出事件，并保存在 ByteBuffer 中
engine 中，将 ByteBuffer 转成 PointerDataPacket（类对象）
engine 中，为了传递给 dart，将 PointerDataPacket 转成 buffer
dart 中，将 buffer 再转成 PointerDataPacket（类对象）
dart 中，将 PointerData 转成 PointerEvent，供上层使用

Flutter 事件处理流程主要分两步：
命中测试：当手指按下时，触发 PointerDownEvent 事件，按照深度优先遍历当前渲（render object）树，对每一个渲染对象进行“命中测试”（hit test），如果命中测试通过，则该渲染对象会被添加到一个 HitTestResult 列表当中。
事件分发：命中测试完毕后，会遍历 HitTestResult 列表，调用每一个渲染对象的事件处理方法（handleEvent）来处理 PointerDownEvent 事件，该过程称为“事件分发”（eventdispatch）。随
后当手指移动时，便会分发 PointerMoveEvent 事件。
事件清理：当手指抬（ PointerUpEvent ）起或事件取消时（PointerCancelEvent），会清空 HitTestResult 列表。
需要注意：
1）命中测试是在 PointerDownEvent 事件触发时进行的，一个完成的事件流是 down > move > up (cancle)。
2）如果父子组件都监听了同一个事件，则子组件会比父组件先响应事件。这是因为命中测试过程是按照深度优先规则遍历的，所以子渲染对象会比父渲染对象先加入 HitTestResult 列表，又因为在事件分发时是从前到后遍历 HitTestResult 列表的，所以子组件比父组件会更先被调用 handleEvent 。
命中测试
当触摸事件按下时，Flutter会对应用程序执行命中测试(HitTest)，以确定触摸事件与屏幕接触的位置存在哪些组件（widget）， 按下事件（以及该触摸事件的后续事件）然后被分发到由命中测试发现的最内部的组件，然后从那里开始，事件会在组件树中向上冒泡，这些事件会从最内部的组件被分发到组件树根的路径上的所有组件，只有通过命中测试的组件才能触发事件。
GestureDetector 内部是使用一个或多个 GestureRecognizer 来识别各种手势的，而 GestureRecognizer 的作用就是通过 Listener来将原始指针事件转换为语义手势，GestureDetector直接可以接收一个子widget。 GestureRecognizer是一个抽象类，一种手势的识别器对应一个 GestureRecognizer的子类，Flutter实现了丰富的手势识别器，我们可以直接使用。

一个对象是否可以响应事件，取决于在其对命中测试过程中是否被添加到了 HitTestResult 列表 ，如果没有被添加进去，则后续的事件分发将不会分发给自己。当发生用户事件时，Flutter 会从根节点（RenderView）开始调用它hitTest() 。
整体是命中测试分两步：
第一步： renderView 是 RenderView 对应的 RenderObject 对象， RenderObject 对象的 hitTest 方法主要功能是：从该节点出发，按照深度优先的顺序递归遍历子树（渲染树）上的每
一个节点并对它们进行命中测试。这个过程称为“渲染树命中测试”。
渲染树命中测试过程
渲染树的命中测试流程就是父节点 hitTest 方法中递归调用子节点 hitTest 方法的过程。因为 RenderView只有一个孩子，所以直接调用child.hitTest 即可。如果一个渲染对象有多个子节点，则命中测试逻辑为：如果任意一个子节点通过了命中测试或者当前节点“强行声明”自己通过了命中测试，则当前节点会通过命中测试。
hitTestChildren() 功能是判断是否有子节点通过了命中测试，如果有，则会将子组件添加到 HitTestResult 中同时返回 true；如果没有则直接返回false。该方法中会递归调用子组件的 hitTest 方法。
hitTestSelf() 决定自身是否通过命中测试，如果节点需要确保自身一定能响应事件可以重写此函数并返回true ，相当于“强行声明”自己通过了命中测试。
整体逻辑就是：
先判断事件的触发位置是否位于组件范围内，如果不是则不会通过命中测试，此时 hitTest 返回 false，如果是会先调用 hitTestChildren() 判断是否有子节点通过命中测试，如果是则将当前节点添加到 HitTestResult 列表，此时 hitTest 返回 true。即只要有子节点通过了命中测试，那
么它的父节点（当前节点）也会通过命中测试。
如果没有子节点通过命中测试，则会取 hitTestSelf 方法的返回值，如果返回值为 true，则当前节点通过命中测试，反之则否。
如果当前节点有子节点通过了命中测试或者当前节点自己通过了命中测试，则将当前节点添加到 HitTestResult 中。又因为 hitTestChildren()中会递归调用子组件的 hitTest 方法，所以组件树的命中测试顺序深度优先的，即如果通过命中测试，子组件会比父组件会先被加入HitTestResult 中。
主要逻辑是遍历调用子组件的 hitTest() 方法，同时提供了一种中断机制：即遍历过程中只要有子节点的 hitTest() 返回了 true 时，会终止子节点遍历，这意味着该子节点前面的兄弟节点（注意，兄弟节点的遍历是倒序的）将没有机会通过命中测试。 父节点也会通过命中测试。因为子节点 hitTest() 返回了 true 导父节点 hitTestChildren 也会返回 true，最终会导致 父节点的 hitTest 返回 true，父节点被添加到 HitTestResult 中。
当子节点的 hitTest() 返回了 false 时，继续遍历该子节点前面的兄弟节点，对它们进行命中测试，如果所有子节点都返回 false 时，则父节点会调用自身的 hitTestSelf 方法，如果该方法也
返回 false，则父节点就会被认为没有通过命中测试。
为什么要制定这个中断呢？
因为一般情况下兄弟节点占用的布局空间是不重合的，因此当用户点击的坐标位置只会有一个节点，所以一旦找到它后（通过了命中测试，hitTest 返回true），就没有必要再判断其他兄弟节点了。但是也有例外情况，比如在 Stack 布局中，兄弟组件的布局空间会重叠，如果我们想让位于底部的组件也能响应事件，就得有一种机制，能让我们确保：即使找到了一个节点，也不应该终止遍历，也就是说所有的子组件的 hitTest 方法都必须返回 false！为此，Flutter 中通过 HitTestBehavior 来定制这个过程。
为什么兄弟节点的遍历要倒序？
兄弟节点一般不会重叠，而一旦发生重叠的话，往往是后面的组件会在前面组件之上，点击时应该是后面的组件会响应事件，而前面被遮住的组件不能响应，所以命中测试应该优先对后面的节点进行测试，因为一旦通过测试，就不会再继续遍历了。如果我们按照正向遍历，则会出现被遮住的组件能响应事件，而位于上面的组件反而不能，这明显不符合预期。
如果不重写 hitTestChildren，则默认直接返回 false，这也就意味着后代节点将无法参与命中测试，相当于事件被拦截了，这也正是 IgnorePointer 和 AbsorbPointer 可以拦截事件下发的原理。
如果 hitTestSelf 返回 true，则无论子节点中是否有通过命中测试的节点，当前节点自身都会被添加到 HitTestResult 中。而 IgnorePointer 和 AbsorbPointer 的区别就是，前者的hitTestSelf 返回了 false，而后者返回了 true。
命中测试完成后，所有通过命中测试的节点都被添加到了 HitTestResult 中。
事件分发
事件分发过程很简单，即遍历HitTestResult，调用每一个节点的 handleEvent 方法，所以组件只需要重写 handleEvent 方法就可以处理事件了。
两种事件分发：
一种就是由 HitTestResult 确定的分发路径
HitTestResult 方式中，dispatchEvent 会调用 HitTestResult 保存路径中每一个结点的 handleEvent 处理事件，也就是在 hitTest 阶段中确定的事件分发路径，从 GestureBinding 开始，调用他们的 handleEvent 函数。
另一种是当 HitTestResult 为 null 时（一般当使用外部设备如鼠标时，HitTestResult 就无法有效地判断分发路径，或者上层直接通过 GestureDecter 等进行手势检测），需要由路由(route)直接导向对应的结点。
在 route 方式中，GestureBinding 回调用 pointerRouter.route 函数执行事件分发，事件的接受者就是 _routeMap 中保存的结点，而接收者通过 addRoute 和 removeRoute 进行添加和删除，接受者分为两种，普通的 route 存储在  _routeMap 中，globalRoute 存储在 _globalRoutes 中，前者是与 pointer 绑定的，后者会响应所有的事件。
HitTest方式的分发流程
HitTest 方式的分发流程，可以将其分为两部分，第一部分是 hitTest 过程，确定事件接收者路径，这个过程只在 PointerDownEvent 和 PointerSignalEvent 事件发生时执行，对于一系列事件，只会执行一次，后续的都会通过 pointer 找到首次事件时创建的 HitTestResult，如果没有就不会执行分发（这里先不考虑 route 流程）；第二部分就是后面的 dispatchEvent，会调用 HitTestResult 路径中的所有结点的 handleEvent 函数，这个过程在每一个事件到来时（且有对应的 HitTestResult）会执行。而单独从 HitTestResult 角度来看，第一个过程就是给事件注册接收者，第二个过程则是将事件分发给接收者，所以它的基本流程与 route 保持一致，只不过二者在不同的维度上作用，前者依赖 Widgets 树这样一个结构，它的接收者之间有着包含关系，这是一个事件正常的传递-消费过程。route 流程相较而言更加随意，它可以直接通过 GestureBinding.instance.pointerRouter.addRoute 注册一系列事件的接收者，而不需要传递的过程，没有结点之间的限制，更适合用于手势的监听等操作。
在 HitTest 流程中，从 GestureBinding 的 hitTest 开始，首先将 GestureBinding 加入到 HitTestResult 的路径中，也就是说所有的 HitTest 流程中首先都会调用  GestureBinding 的 handleEvent 函数。然后在  RendererBinding 中通过调用了 RenderView 的 hitTest，RenderView 是 RenderObject 的子类，也是 render 树的入口，RenderObject 实现了 HitTestTarget，但是 hitTest 的实现是在 RenderBox 中，RenderBox 可以看作是 render 结点的基类，它有实现 hitTest 和 hitTestChildren 函数。
如果事件的 position 在自己身上，就接着调用 hitTestChildren 和 hitTestSelf 判断子结点或者自身是否消费事件，决定是否将自己加入到 HitTestResult 路径，从这里也可以看出，在 HitTestResult 路径中顺序是从子结点到根结点，最后到 GestureBinding。
route方式的分发流程
route 流程整体来说也分为两个过程，第一步是进行事件监听，通过调用 GestureBinding.instance.pointerRouter.addRoute 完成注册，此处传入参数为 pointer（一般来说，对于触摸事件，每一次触摸 pointer 都会更新，对于鼠标事件，pointer 始终为 0）、handleEvent（处理事件函数）和 transform（用作点位的转换，比如将 native 层传来的位置转换成 flutter 中的位置），在 addRoute 中它们被封装成 _RouteEntry 保存在 _routeMap 等待被分发事件。除此之外还有addGlobalRoute、removeRoute 等可用于注册全局监听、移出监听。
在 flutter 中事件分发有两种，一种是常规的在 render 树中传递事件的方式，也就是 HitTest 方式，另一种是直接向 GestureBinding 中注册回调函数的方式，也就是 route 方式，它们在 flutter 系统中扮演着不同的角色，其中 HitTest 方式主要是用于监听基本的事件，例如 PointerDownEvent、PointerUpEvent 等，而 route 方式一般都是与 GestureRecognizer 一起使用，用于检测手势，如 onTap、onDoubleTap 等，另外，在手势检测的过程中，GestureArenaManager 也是重度参与用户，协助 GestureRecognizer 保证同一个事件同一时间只会触发一种手势。

总结：
组件只有通过命中测试才能响应事件。
一个对象是否可以响应事件，取决于在其对命中测试过程中是否被添加到了 HitTestResult 列表
一个组件是否通过命中测试取决于 hitTestChildren(...) || hitTestSelf(...) 的值。
组件树中组件的命中测试顺序是深度优先的。
组件子节点命中测试的循序是倒序的，并且一旦有一个子节点的 hitTest 返回了 true，就会终止遍历，后续子节点将没有机会参与命中测试。这个原则可以结合 Stack 组件来理解。

5.Flutter知识点
1.依赖
依赖包由Pub仓库管理，项目依赖配置在pubspec.yaml文件中声明即可，对于未发布在Pub仓库的插件可以使用git仓库地址或文件路径：
#闪验
shanyan:
git:
url: git://github.com/253CL/CLShanYan_Flutter.git
path: shanyan
ref: v2.3.3.2
2.保持页面状态
Flutter 中可以通过 mixins 混入AutomaticKeepAliveClientMixin，然后重写 wantKeepAlive保持住页面。
3.Andorid和IOS控件的区别
Android使用的是Material风格，IOS使用的是Cupertino风格。
4.Flutter报setState() called after dispose()错误解决办法
错误解析：防止页面关闭执行setState()方法
解决方法：使用mounted进行判断
if(mounted){
setState(() {});
}
5.如何解决键盘高度超出
可以使用SingleChildScrollView对输入组件进行包裹。
6.对于页面报错使用到了什么机制？
Flutter 页面中的异常处理ErrorWidget
https://blog.csdn.net/sinat_17775997/article/details/110484093?ops_request_misc=&request_id=&biz_id=102&utm_term=%E8%87%AA%E5%AE%9A%E4%B9%89Flutter%E9%94%99%E8%AF%AF%E9%A1%B5%E9%9D%A2&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-1-110484093.pc_search_result_control_group&spm=1018.2226.3001.4187

7.MediaQuery优化
首先我们需要简单解释一下，通过 MediaQuery.of获取到的  MediaQueryData里有几个很类似的参数：
viewInsets： 被系统用户界面完全遮挡的部分大小，简单来说就是键盘高度
padding ： 简单来说就是状态栏和底部安全区域，但是 bottom会因为键盘弹出变成 0
viewPadding ：和 padding 一样，但是 bottom部分不会发生改变 举个例子，在 iOS 上，如下图所示，在弹出键盘和未弹出键盘的情况下，可以看到 MediaQueryData里一些参数的变化：
viewInsets  在没有弹出键盘时是 0，弹出键盘之后 bottom 变成 336
padding 在弹出键盘的前后区别， bottom 从 34 变成了 0
viewPadding  在键盘弹出前后数据没有发生变化 MediaQueryData里的数据是会根据键盘状态发生变化，又因为   MediaQuery 是一个 InheritedWidget，所以我们可以通过 MediaQuery.of(context)获取到顶层共享的  MediaQueryData InheritedWidget的更新逻辑，是通过登记的 context来绑定的，也就是MediaQuery.of(context)本身就是一个绑定行为，然后MediaQueryData又和键盘状态有关系，所以：键盘的弹出可能会导致使用MediaQuery.of(context)的地方触发 rebuild 所以小技巧一：要慎重在Scaffold之外使用MediaQuery.of(context)，可能你现在会觉得奇怪什么是  Scaffold 之外，没事后面继续解释。 那到这里有人可能就要说了：我们通过    MediaQuery.of(context)  获取到的   MediaQueryData  ，不就是对应在  MaterialApp  里的 MediaQuery  吗？那它发生改变，不应该都会触发下面的 child 都 rebuild 吗？ 这其实和页面路由有关系，也就是我们常说的 PageRoute 的实现。 因为嵌套结构的原因，事实上弹出键盘确实会导致  MaterialApp   下的 child 都触发 rebuild ，因为设计上 MediaQuery 就是在 Navigator 上面，所以弹出键盘自然也就触发  Navigator的  rebuild。 那正常情况下 Navigator都触发 rebuild 了，为什么页面不会都被 rebuild 呢？ 这就和路由对象的基类 ModalRoute 有关系，因为在它的内部会通过一个 _modalScopeCache参数把     Widget缓存起来，正如注释所说：缓存区域不随帧变化，以便得到最小化的构建。 其实这个行为也体现在了 Scaffold 里，如果你去看 Scaffold 的源码，你就会发现 Scaffold 里大量使用了 MediaQuery.of(context) 。 虽然 Scaffold里大量使用 MediaQuery.of(context)，但是影响范围是约束在Scaffold内部。 可以看到MediaQuery.of里的 context 对象很重要：
如果页面MediaQuery.of用的是  Scaffold外的 context ，获取到的是顶层的 MediaQueryData，那么弹出键盘时就会导致页面 rebuild
MediaQuery.of用的是  Scaffold内的 context ，那么获取到的是   Scaffold对于区域内的 MediaQueryData  ，比如前面介绍过的 body ，同时获取到的 MediaQueryData 也会因为Scaffold的配置不同而发生改变。

8.ListView优化
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
//加上itemExtent属性，修改如下：
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
这是因为不设置 itemExtent 属性，将会由子组件自己决定大小，大量的计算导致UI堵塞。如果 list 有很多 item，使用 ListView.builder，这个方法会在 item 滚动进入屏幕的时候才创建item，而不是一次性创建所有的 item。这在 list 很复杂和 widget 嵌套很深的情况下，有明显的性能优势。

9.Flutter设置不同尺寸的图片
Flutter要求每个图片必须提供1x图，然后才会识别到对应的其他倍率目录下的图片：
flutter:
assets:
- images/cat.png
- images/2x/cat.png
- images/3.5x/cat.png
  使用：
  new Image.asset('images/cat.png');
  这样配置后，才能正确地在不同分辨率的设备上使用对应密度的图片。但是为了减小APK包体积我们的位图资源一般只提供常用的2x分辨率，其他分辨率的设备会在运行时自动缩放到对应大小。

10.HotReload和HotRestart
并不是所有的代码改动都可以通过热重载来更新
控件类型从StatelessWidget到StatefulWidget的转换，因为Flutter在执行热刷新时会保留程序原来的state，而某个控件从stageless→stateful后会导致Flutter重新创建控件时报错“myWidget is not a subtype of StatelessWidget”，而从stateful→stateless会报错“type ‘myWidget’ is not a subtype of type ‘StatefulWidget’ of ‘newWidget’”。
全局变量和静态成员变量，这些变量不会在热刷新时更新。
修改了main函数中创建的根控件节点，Flutter在热刷新后只会根据原来的根节点重新创建控件树，不会修改根节点。

HotReload：AndroidStudio底部的Run-左上角的小闪电
HotRestart：小闪电右边的图标

Hot Restart 和 Hot Reload 有什么差异吗？
Hot Reload比Hot Restart快，Hot Reload会编译咱们文件里新加的代码并发送给dart虚拟机，dart会更新widgets来改动UI，而Hot Restart会让dart 虚拟机从头编译运用。另一方面也是由于
这样， Hot Reload会保存之前的state，而Hot Restart会重置一切的state回到初始值。

Flutter为什么可以热重载
Flutter 的热重载是基于 JIT 编译形式的代码增量同步。因为 JIT 属于动态编译，能够将 Dart 代码编译成生成中间代码，让 Dart VM 在运行时加载，因此能够经过动态更新中间代码完成增量同步。
另一方面，因为涉及到状态的保存与恢复，涉及状态兼容与状况初始化的场景，热重载是无法支撑的，如改动前后 Widget 状况无法兼容、全局变量与静态特点的更改、main 办法里的更改、initState 办法里的更改、枚举和泛型的更改等。
热重载的步骤
工程改动：热重载Server会逐一扫描工程中的文件，检查是否有新增、删除或许改动，直到找到在上次编译之后，发生变化的 Dart 代码。
增量编译：热重载模块会将发生变化的 Dart 代码，经过编译转化为增量的 Dart Kernel(Dart内核) 文件。
推送更新：热重载Server将增量的 Dart Kernel 文件经过 RPC 协议，发送给正在手机上运转的 Dart VM。
代码兼并：Dart VM 会将收到的增量 Dart Kernel 文件，与原有的 Dart Kernel 文件进行兼并，然后从头加载新的 Dart Kernel 文件。
Widget增量烘托：在确认 Dart VM 资源加载成功后，Flutter 会将其 UI 线程重置，通知 flutter.framework 重建 Widget。


11.Flutter框架的优缺点
Flutter是Google推出的一套开源跨平台UI框架，可以快速地在android、iOS和web平台上构建高质量的原生用户界面，在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。Flutter采用现代响应式框架构建，其中心思想是使用组件来构建应用的UI。当组件的状态发生改变时，组件才会重构它的描述，Flutter会对比之前的描述，以确定底层渲染树从当前状态切换到下一个状态所需要的最小改变。
优点：
1）热重载，利用AS直接ctl+s就可以保存并重载，模拟器立马就可以看见效果，相比原生长久的编译过程强很多。
2）一切皆为Widget的理念，对于Flutter来说，手机应用里的所有东西都是Widget，通过可组合的空间集合、丰富的动画以及分层课扩展的架构实现了富有感染力的灵活界面设计借助可移植的GPU加速的渲染引擎及高性能本地化代码运行时，以达到跨平台设备的高质量用户体验。简单来说就是：最终结果就是利用Flutter构建的应用在运行效率上会和原生应用差不多。
缺点：
1）不支持热更新
2）三方库有限
3）Dart语言编写，增加学习难度
12.Flutter的编译模式
Debug模式对应的是Dart的JIT模式，可以在真机和模拟器上同时运行，该模式会打开所有的断言，调试信息和服务扩展，这个模式为快速运行和开发做了优化，支持热重载，但并没有优化代码执行速度，二进制包大小和部署。flutter run --debug就是以这种模式运行的。
Release模式对应的是Dart的AOT模式，只能在真机上运行，不能在模拟器上运行，它的目标就是最终的线上发布，这个模式会关闭所有的断言以及极可能多的调试信息和服务扩展。另外这个模式优化了应用快速启动，代码快速执行，以及二进制包大小，因此编译时间比较长。flutter run --release 命令就是以这种模式运行的。
Profile模式，基本与Release模式一致，只是多了对Profile模式服务扩展的支持，这个模式用于分析真实设备运行性能。flutter run profile命令就是以这种模式运行的。
如何敞开profile方式？
假如是独立flutter工程能够运用flutter run –profile发动。假如是混合 Flutter 运用，在 flutter/packages/flutter_tools/gradle/flutter.gradle 的 buildModeFor 办法中将 debug 方式改为 profile即可。

13.全面屏的适配
1）通过MaterialApp+Scaffold的方式，可以自动为我们适配全面屏的安全区域。这种不能适配底部的安全区域，需要使用MediaQuery。
2）如果涉及到顶部非正常的左边返回按钮+中间title样式的话，可以使用 MediaQuery 来控制距离上下安全的距离。
3）在Android的AndroidManifest中添加设置：
<meta-data
android:name="android.max_aspect"
android:value="2.3" />
除了适配全面屏幕，还可以使用第三方插件 flutter_screenutil 来适配Widget
14.Flutter中的持久化存储方案
1）SharedPreference，使用shared_preferences
2）sqflite是Flutter的SQLite插件，它能在App端能够高效的存储和处理数据库数据，适用于需要查询大量持久化数据的应用。
3）文件储存，使用path_provider
15.在 Flutter 使用 SizedBox 代替 Container
Container 是一个非常棒的 widgets，您将在 Flutter 广泛使用它。 Container() 扩展到适合父节点给出的约束，并且不是常量构造函数。相反，SizedBox 是一个常量构造函数，构建一个固定大小的盒子。宽度和高度参数可以为 null，以指定不应在相应的维度中约束盒子的大小。因此，当我们必须实现占位符时，应该使用 SizedBox，而不是使用 Container。
// Do
return _isNotLoaded ? SizedBox.shrink() : YourWidget();

//Do not
return _isNotLoaded ? Container() : YourWidget();
16.AndroidView和UiKitView
整个flutter的框架，其实是一个独立的整体，跟原生是独立的，那有些功能，原生已经有成熟的实现了，flutter为了避免重复实现一套，希望可以直接用原生的UI展示在flutter上面flutter为了解决这个问题，使用两个特定的widget来实现 (AndroidView and UiKitView)，实现代码大致如下：
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
17.Flutter单引擎和多引擎
默认情况下一个Activity或Fragment对应一个引擎，如果原生页面和Flutter页面混合嵌入，默认会创建多个引擎。
一个引擎的原生和Flutter交互可以使用flutter boost框架；多引擎的可以使用谷歌的FlutterEngineGroup引擎。

18.future和steam的区别
在 Flutter 中有两种处理异步操作的方式 Future 和 Stream，Future 用于处理单个异步操作，Stream 用来处理接连的异步操作。


6.Dart知识点
1.线程
Dart中的单线程是如何运行的？
Dart在单线程中是以消息轮轮询机制来运行的，包含两个任务队列，一个是微任务队列microtaskqueue，一个是事件队列event queue，当Flutter启动后，消息轮训机制便启动了，首先会判断微任务队列是否为空，如果不为空，则执行微任务，执行完成后会继续判断微任务队列是否为空，如此循环，直到微任务队列为空。然后会执行事件任务，会判断事件任务队列是否为空，如果不为空则执行事件任务，事件任务也有可能会包含微任务，所以每次执行完事件任务会先问一下微任务队列是否为空，如果不为空则执行微任务，接着会判断事件任务队列是否为空，直到事件队列为空。
Dart是如何实现多任务并行的？
Dart是一种单线程模型语言，可以理解为 Dart 中的线程,isolate 与线程的区别就是线程与线程之间是共享内存的，而 isolate 和 isolate 之间是不共享的，所以叫 isolate (隔离)，它的资源开销低于线程。主要是通过 Isolate.spawn及Isolate.spawnUri来创建Isolate，由于isolate之间没有共享内存，所以他们之间的通信唯一方式只能是通过Port进行，而且Dart中的消息传递总是异步的。 两个Isolate是通过两对Port对象通信，一对Port分别由用于接收消息的ReceivePort对象，和用于发送消息的SendPort对象构成。其中SendPort对象不用单独创建，它已经包含在ReceivePort对象之中。需要注意，一对Port对象只能单向发消息，这就如同一根自来水管，ReceivePort和SendPort分别位于水管的两头，水流只能从SendPort这头流向ReceivePort这头。因此，两个Isolate之间的消息通信肯定是需要两根这样的水管的，这就需要两对Port对象。 Isolate对象的创建是异步的。这里的线程池是在Dart VM初始化的时候创建的。 一个ReceivePort对象包含一个RawReceivePort对象及SendPort对象。其中RawReceivePort对象是在虚拟机中创建的， 在创建ReceivePort对象对象之前，首先会将当前Isolate中的MessageHandler对象添加到map中。这里是一个全局的map，在Dart VM初始化的时候创建，每个元素都是一个Entry对象，在Entry中，有一个MessageHandler对象，一个端口号及该端口的状态。 这里的map的初始容量是8，当达到容量的3/4时，会进行扩容，新的容量是旧的容量2倍。这跟HashMap类似，初始容量为8，加载因子为0.75，扩容是指数级增长。 消息的处理是在HandleMessages函数中进行的。在HandleMessages函数中会根据消息的优先级别来遍历所有消息并一一处理，直至处理完毕。 至此，一个Isolate就已经成功的向另外一个Isolate成功发送并接收消息。而双向通信也很简单，在父Isolate中创建一个端口，并在创建子Isolate时，将这个端口传递给子Isolate。然后在子Isolate调用其入口函数时也创建一个新端口，并通过父Isolate传递过来的端口把子Isolate创建的端口传递给父Isolate，这样父Isolate与子Isolate分别拥有对方的一个端口号，从而实现了通信。

2.赋值操作符
var result = AA ?? "999"  ///表示如果 AA 为空，返回999
AA ??= "999" ///表示如果 AA 为空，给 AA 设置成 999
3.Dart中可选位置参数和可选命名参数
可选命名参数
void enableFlags({bool? bold,bool? hidden}){//这里的参数是可选命名参数
}
enableFlags(bold: true);//不能直接传递参数值，需要 参数名:参数值 的格式
可选位置参数
eat("张三", 20,15);//正确
// eat("张三", 20,"hello");//错误，位置参数中，顺序都是固定的，所以第三个参数必须是 int? score
void eat(String name,int age,[int? score,String? description]){
print("$name $age $score");
}
4.Dart中的命名构造方法
可以通过命名方式实现，格式是 类名.方法名()，方法名可以随便起，类似于kotlin中的方法扩展。
//关键字 factory
factory Result.fromJson(Map<String, dynamic> json) {
return Result(
delivery: List<DeliveryList>.from(
json["delivery"].map((x) => DeliveryList.fromJson(x))),
);
}
5.Dart 有两个特殊的运算符可以用来替代if-else语句
条件 ? 表达式 1 : 表达式 2，
和java中的三元表达式一样，如果条件为 true，执行表达式 1并返回执行结果，否则执行表达式 2 并返回执行结果。
表达式 1 ?? 表达式 2
如果表达式1为非 null 则返回其值，否则执行表达式2并返回其值。
6.类、接口、继承
Dart中没有接口，类都可以作为接口，把某个类当做接口实现时，只需要使用 implements，然后复写父类（父类中可以完全是普通的方法）方法即可。
Dart中支持 mixins，按照出现顺序应该为extends、 mixins、implements。

1）extends
Dart语言是单继承，可以在继承的同时使用混入mixin，子类可以继承父类里面可见的属性和方法。对于Java来说，可见指的是非private修饰；对Dart来说，指的是非下划线_开头。子类调用父类的方法，使用super关键字。子类重写父类的方法，使用override关键字，子类不会继承父类的构造函数。
2）implements
Dart中没有接口，类或者抽象类都可以作为接口，把某个类当做接口实现时，只需要使用 implements，然后复写父类（父类中可以完全是普通的方法）方法即可。。
abstract class Animal{
static const String name = 'AA';
void display(){
print("名字是:${name}");
}
void eat(); //抽象方法
}
// 抽象类作为接口
abstract class swimable{
void swim();
}
3）mixin
mixin一般用于描述一种具有某种功能的组块，而某一对象可以拥有多个不同功能的组块。mixin用于修饰类，和abstract类似，该类可以拥有成员变量、普通方法、抽象方法，但是不可以实例化，没有构造方法，它类似于扩展类所获得的重用，为了解决单继承问题。
声明的时候使用mixin:
mixin Musical {
bool canPlayPiano = false;
void entertainMe() {
}
}
使用的时候使用关键字with，如果需要指定异常类型需要使用关键字on:
class Musician {
}
mixin MusicalPerformer on Musician {//只有extends或者implements Musician的类才可以 with MusicalPerformer
}
class SingerDancer extends Musician with MusicalPerformer {

7.Dart中的级联操作符
Dart中的 .. 表示级联操作符，为了方便配置使用，返回的是this。
8.Dart中的Future关键字
Dart在单线程中是以消息轮询机制来运行的，其中包含两个任务队列，一个是微任务队列，另一个叫做事件队列，执行一个异步任务可以使用Future来处理，代表一个承诺。
9.
8.单例模式
class Singleton {
static Singleton _instance;
Singleton._internal() {
_instance = this;
}
//factory关键字提供了返回自身的功能
factory Singleton() => _instance ?? Singleton._internal();
}
9.Dart中的空安全
简单的来说，空安全在代码编辑阶段帮助我们提前发现可能出现的空异常问题，但这并不意味着程序不会出现空异常。
在空安全中，所有类型在默认情况下都是非空的。例如，你有一个 String 类型的变量，那么它应该总是包含一个字符串。
如果你想要一个 String 类型的变量接受任何字符串或者 `null`，通过在类型名称后添加一个问号（?）表示该变量可以为空。例如，一个类型为 String? 可以包含任何字符串，也可以为空。在使用的时候可以使用 变量?. 的方式来操作。

引入空安全的好处
可以将原本运行时的空值引用错误转变为编辑时的分析错误
增强程序的健壮性，有效避免由Null而导致的崩溃
迭代不留坑

对于无法在定义时进行初始化，并且又想避免使用 ?. ,可以通过 late 修饰的变量，并且在使用这个变量时可以不用 ?. 。
对于插件的空安全适配：如果开启了空安全，所有的插件必须支持空安全，否则无法编译，解决办法就是使用开发工具或者命令的方式添加参数：--no-sound-null-safety
如何开启空安全
yaml文件中设置sdk的版本>=2.12.0就表示开启了空安全
空安全相关操作符有哪些？
late关键字
?.
??
?=

10.Dart: 闭包
闭包是一个方法（对象）
闭包定义在其他方法内部。（定义在函数里面的函数就是闭包。）
闭包能够访问外部方法内的局部变量，并持有其状态（这是闭包最大的作用，可以通过闭包的方式，将其暴露出去，提供给外部访问。）
11.async和await区别
Future Dart 使用Future来处理异步编程。 如果某个操作是耗时的，你可以将这个耗时操作包装成一个Future，等未来某个时间点操作完成后，就可以从这个Future里面取出结果了。
async 和 await 关键字用于实现异步编程，并且让你的代码看起来就像是同步的一样。 await 表达式的返回值通常是一个 Future 对象（Future通过then方法来获取返回值）；如果不是的话也会自动将其包裹在一个 Future 对象里。  await 表达式会阻塞直到需要的对象返回。 异步函数是函数体由 async 关键字标记的函数。将关键字 async 添加到函数并让其返回一个 Future 对象。必须在带有 async 关键字的 异步函数 中使用 await。
同步和异步同步方法调用一旦开始，调用者必须等到方法调用返回后，才能继续后续的行为。 异步方法调用更像一个消息传递，一旦开始，方法调用就会立即返回，调用者就可以继续后续的操作。
Future<void> getOrderListData(int pageNum,String orderType) async {
debugPrint("await执行之前");
final Response response = await provider.getOrderListData(pageNum,orderType);
//这个输出语句会阻塞，直到response的结果返回，如果不想这个语句阻塞，可以将不想被阻塞的语句放到getOrderListData方法之后
debugPrint("await执行之后");
}

12.Dart有哪些特性？
在Dart中，一切皆对象，所有的对象都继承自Object。
Dart是强类型语言，可以使用var或者dynamic来声明一个变量，Dart会自动推断其数据类型。
没有赋值的变量默认值为null
Dart支持顶层方法和闭包。
Dart没有类似public的关键字，使用_下划线来声明变量或者方法是私有的。

13.添加集合尽可能使用展开运算符
//Do
var y = [4,5,6];
var x = [1,2,...y];//将y集合添加进x集合中

//Do not
var y = [4,5,6];
var x = [1,2];
x.addAll(y);
14.使用 if 代替三元运算符语法,
在如下情况:当设计一个 Flutter 应用程序时，通常情况下需要有条件地呈现不同的 widgets。您可能需要基于不同判断生成一个 widgets，例如:
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
或者
Platform.isIOS ? Text("This if From IOS") :nil
nil需要插件：nil: ^1.1.1
15.指定变量类型：当值的类型已知时，请务必指定成员的类型，尽可能避免使用 var
16.使用 for/while 代替 foreach/map，foreach/map比较耗时
17.重定向构造函数
重定向构造函数：重定向构造函数的函数体为空， 构造函数的调用在冒号 (:) 之后。
class Point {
num x, y;
// 类的主结构函数。
Point(this.x, this.y);
// 指向主结构函数
Point.alongXAxis(num x) : this(x, 0);
}
18.命名构造函数
命名构造函数：可以更清晰的表明函数目的
class Point {
num x, y;
Point(this.x, this.y);
// 命名结构函数
Point.origin() {
x = 0;
y = 0;
}
}
19.dart 扩展有了解过吗？怎样运用？
使用on作用在类上，可以为类额外的增加方法，比如为Container增加一个边距。
dynamic类型的变量能够进行扩展吗？
不能够
20.Dart中var与dynamic的差异
运用var来声明变量，dart会在编译阶段自动推导出类型。而dynamic不在编译期间做类型检查而是在运行期间做类型校验。
var如果在声明变量的时候赋值了，后面不能改变变量的类型；dynamic声明的时候赋值了后面可以改变变量的类型。
21.同一个类文件中的顶层办法，能够拜访类的私有变量和办法
void test(){//dart文件中的顶层方法
EnvironmentConfig config = EnvironmentConfig();
config._play();
debugPrint('${config._count}');
}
22.当表达式可以求值为true、false或null，并且需要将结果传递给需要一个不可空布尔值的对象时，建议使用??而不是=或者!=。
23.如何开启空安全？
在 Dart 2.12 到 2.19 中，你需要手动启用空安全。 Dart 2.12 之前的 SDK 版本不提供空安全。
想要启用健全空安全，需要将 SDK 的最低版本约束设定为 2.12 或者更高的语言版本。例如，你的 pubspec.yaml 可以设置为如下的限制：
environment:
sdk: '>=2.12.0 <3.0.0'

7..Flutter中图片的缓存
Flutter 默认在进行图片加载时，会先通过对应的 `ImageProvider` 去加载图片数据，然后通过 PaintingBinding 对数据进行编码，之后返回包含编码后图片数据和信息的 ImageInfo去实现绘制。

本身这个逻辑并没有什么问题，问题就在于 Flutter 中对于图片在内存中的 Cache 对象是一个 `ImageStream` 对象。

Flutter 中 ImageCache 缓存的是一个异步对象，缓存异步加载对象的一个问题是：在图片加载解码完成之前，你无法知道到底将要消耗多少内存，并且大量的图片加载，会导致解码任务需要产生大量的IO。

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


Flutter Inspector
使用Flutter Inspector检测性能和内存情况：AndroidStudio中打开View-Tool Windows-Flutter Inspector，或者是选择最底部的run选项-左上角的Open Flutter DevTools。
开启Performance Overlay(功能图层)
return GetMaterialApp(
//功能图层会在当时运用的最上层，以 Flutter 引擎自绘的办法展现 GPU 与 UI 线程的履行图表
showPerformanceOverlay: false,
);
功能图层会在当时运用的最上层，以 Flutter 引擎自绘的办法展现 GPU 与 UI 线程的履行图表，而其间每一张图表都代表当时线程最近 300 帧的表现，假如 UI 产生了卡顿，这些图表能够协助咱们剖析并找到原因。 下图演示了功能图层的展现款式。其间，GPU 线程的功能状况在上面，UI 线程的状况显现在下面，蓝色垂直的线条表明已履行的正常帧，绿色的线条代表的是当时帧。
图片: https://uploader.shimo.im/f/hxNu65SGoapupA4D.png!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2OTc1MzMwMDAsImZpbGVHVUlEIjoiZ1hxbWRCYXZvNWlvR1kzbyIsImlhdCI6MTY5NzUzMjcwMCwiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.V0xVIcfQHBPgbUEOWrw62iuxHXP99O2jblYGTobeQ04
假如有一帧处理时刻过长，就会导致界面卡顿，图表中就会展现出一个赤色竖条。下图演示了运用呈现烘托和制作耗时的状况下，功能图层的展现款式：
图片: https://uploader.shimo.im/f/frkggcIzcnAX46OA.png!thumbnail?accessToken=eyJhbGciOiJIUzI1NiIsImtpZCI6ImRlZmF1bHQiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjE2OTc1MzMwMDAsImZpbGVHVUlEIjoiZ1hxbWRCYXZvNWlvR1kzbyIsImlhdCI6MTY5NzUzMjcwMCwiaXNzIjoidXBsb2FkZXJfYWNjZXNzX3Jlc291cmNlIiwidXNlcklkIjo4MzQ2MzU2M30.V0xVIcfQHBPgbUEOWrw62iuxHXP99O2jblYGTobeQ04
假如赤色竖条呈现在 GPU 线程图表，意味着烘托的图形太杂乱，导致无法快速烘托；而假如是呈现在了 UI 线程图表，则表明 Dart 代码耗费了很多资源，需求优化代码。

尽可能地运用 const 结构器
使用CachedNetworkImage来对图片就行缓存
ListView相关优化
1）不要使用ListView默许结构方法，ListView默认的构造方法将会一次性的将数据都加载出来，建议使用ListView 和 GridView 的 builder方法，builder方法则是按需加载。
2）使用 builder构建列表
当你的列表元素是动态增长的时候（比如上拉加载更多），请不要直接用children 的方式，一直往children 的数组增加组件，那样会很糟糕。对于 ListView.builder 是按需构建列表元素，也就是只有那些可见得元素才会调用itemBuilder 构建元素，这样对于大列表而言性能开销自然会小很多。

3）禁用 addAutomaticKeepAlives 和 addRepaintBoundaries 特性这两个属性都是为了优化滚动过程中的用户体验的。
addAutomaticKeepAlives 特性默认是 true，意思是在列表元素不可见后可以保持元素的状态，从而在再次出现在屏幕的时候能够快速构建。这其实是一个拿空间换时间的方法，会造成一定程度得内存开销。可以设置为 false 关闭这一特性。缺点是滑动过快的时候可能会出现短暂的白屏（实际会很少发生）。
addRepaintBoundaries 是将列表元素使用一个重绘边界（Repaint Boundary）包裹，从而使得滚动的时候可以避免重绘。而如果列表很容易绘制（列表元素布局比较简单的情况下）的时候，可以关闭这个特性来提高滚动的流畅度。

4）尽可能将列表元素中不变的组件使用 const 修饰
使用 const 相当于将元素缓存起来实现共用，若列表元素某些部分一直保持不变，那么可以使用 const 修饰。
5）使用 itemExtent 确定列表元素滚动方向的尺寸
对于很多列表，我们在滚动方向上的尺寸是提前可以根据 UI设计稿知道的，如果能够知道的话，那么使用 itemExtent 属性制定列表元素在滚动方向的尺寸，可以提升性能。这是因为，如果不指定的话，在滚动过程中，会需要推算每个元素在滚动方向的尺寸从而消耗计算资源。


树的更新规则：
找到widget对应的element节点，设置element为dirty，触发drawframe, drawframe会调用element的performRebuild()进行树重建。
1 当Element=null ,newWidget=null Element的值直接返回null
2 当Element=null.newWidget!=null 就是之前这个地方没有widget，但是刷新一下之后出现了一个widget，就相当于新创建，于是走的是inflateWidget
3 当Element！=null ,newWidge==null 就是之前这个地方有一个widget，刷新之后这个Widget没有了，那么这个时候需要回收之前创建的Element，于是这里执行了 deactivateChild(child);
4 当Element！=null ,newWidge！=null 的时候，这里也可以分为两种情形 通过判断新旧widget的runtimetype和key是否一致来判断对应的element是不是可以复用，如果可以复用只需要调用 Element的update(newWidget)更新一下Widget就可以了，如果不可复用将回收旧的element(deactivateChild)然后创建一个新的element(inflateWidget).
如何触发树更新：
全局更新：调用runApp(rootWidget)，一般flutter启动时调用后不再会调用。
局部子树更新, 将该子树做StatefullWidget的一个子widget，并创建对应的State类实例，通过调用state.setState() 触发该子树的刷新。


补充：
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


20230915:
1）Navigator 跳转不同路由页面，每个页面内部就有一个 RepaintBoundary 控件，这个控件对应的 RenderRepaintBoundary 内的 isRepaintBoundary 标记位就是为 true ，从而路由页面之间形成了独立的 Layer 。
所以相关的 RenderObject 在一起组成了 Layer，而由 Layer 构成的 Layer Tree 最后会被提交到 Flutter Engine 绘制出画面。

2）RepaintBoundary 是 Flutter 中的一个小部件，用于限制重绘范围。当 Flutter 渲染器遍历布局树时，它会对每个小部件执行重绘。如果一个小部件的子树中的任何部分发生变化，则整个子树都会被重绘。

使用 RepaintBoundary 可以阻止这种情况的发生，并只重绘其子树中发生变化的部分。这可以提高性能，特别是在大型、复杂的布局中。

RepaintBoundary就是用来限制重绘范围的。当你将一个小部件包装在RepaintBoundary中时，它将成为一个新的“重绘边界”。如果该小部件的子树中有任何更改，只有那个发生变化的部分会重绘。

这是一个例子，假设有一个很大的布局树,每次点击按钮，会导致整个布局树重绘

Column(
children: <Widget>[
MyLargeWidget(),
RaisedButton(
onPressed: () {
setState(() {});
},
child: Text('update'),
),
],
)
如果我们将MyLargeWidget包装在RepaintBoundary中，可以限制重绘范围:



Column(
children: <Widget>[
RepaintBoundary(
child: MyLargeWidget(),
),
RaisedButton(
onPressed: () {
setState(() {});
},
child: Text('update'),
),
],
)
这样，每次点击按钮，只有MyLargeWidget中发生变化的部分会重绘，而不是整个布局树。

然而，在所有地方都使用RepaintBoundary并不是一个好主意，因为它会增加额外的性能开销。应该只在必要的场景中使用。

每个 RenderObject 对象都会有一个 isRepaintBoundary 的布尔属性，默认为 false ，其作用就是用于判断是否是绘制的边界。

当一个 RenderObject 对象执行 markNeedsPaint 时，如果自身 isRepaintBoundary 为 false，会向上寻找父级，直到有 isRepaintBoundary=true 为止。然后该父级节点被加入 _nodesNeedingPaint 列表中。

isRepaintBoundary为渲染的上界。

每个 RenderObject 对象都会有一个 isRepaintBoundary 的布尔属性，默认为 false ，其作用就是用于判断是否是绘制的边界。

当一个 RenderObject 对象执行 markNeedsPaint 时，如果自身 isRepaintBoundary 为 false，会向上寻找父级，直到有 isRepaintBoundary=true 为止。然后该父级节点被加入 _nodesNeedingPaint 列表中。


绘制的上限和下限：
上限：渲染对象的上界 需要是一个 isRepaintBoundary=true 的可渲染对象。
下限：在 RenderObject#paintChild 中可以发现，只有当 child.isRepaintBoundary 成立时，才不会继续绘制绘制孩子，这就是说，如果 2 被加入 _nodesNeedingPaint 列表，在 2 节点触发绘制时，会绘制孩子，如果此时 5 是 isRepaintBoundary，那么就不会向下绘制，这样 6 就不会绘制，这就是 绘制的下界。








20230917：
1）Widget
canUpdate(...)是一个静态方法，它主要用于在 widget 树重新build时复用旧的 widget ，其实具体来说应该是：是否用新的 widget 对象去更新旧UI树上所对应的Element对象的配置；通过其源码我们可以看到，只要newWidget与oldWidget的runtimeType和key同时相等时就会用new widget去更新Element对象的配置，否则就会创建新的Element。
为 widget 显式添加 key 的话可能（但不一定）会使UI在重新构建时变的高效.

Widget 只是描述一个UI元素的配置信息,根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。

Widget 和 Element 是一一对应的，但并不和 RenderObject 一一对应。比如 StatelessWidget 和 StatefulWidget 都没有对应的 RenderObject。渲染树在上屏前会生成一棵Layer树。

Context：
build方法有一个context参数，它是BuildContext类的一个实例，表示当前 widget 在 widget 树中的上下文，每一个 widget 都会对应一个 context 对象。实际上，context是当前 widget 在 widget 树中位置中执行”相关操作“的一个引用，比如它提供了从当前 widget 开始向上遍历 widget 树以及按照 widget 类型查找父级 widget 的方法。


StatefulElement 间接继承自Element类，与StatefulWidget相对应（作为其配置数据）。StatefulElement中可能会多次调用createState()来创建状态（State）对象。

createState() 用于创建和 StatefulWidget 相关的状态，它在StatefulWidget 的生命周期中可能会被多次调用。例如，当一个 StatefulWidget 同时插入到 widget 树的多个位置时，Flutter 框架就会调用该方法为每一个位置生成一个独立的State实例，其实，本质上就是一个StatefulElement对应一个State实例。



2）为了更新显示画面，显示器以固定的频率刷新（从GPU取数据），比如有一部手机屏幕的刷新频率是60Hz，当一帧（frame）图像绘制完毕后准备绘制下一帧时，显示器会发出一个垂直同步信号（如vsync）， 60Hz的屏幕就会一秒内发出 60次这样的信号。而这个信号主要是用于同步CPU、GPU和显示器的。一般地来说，计算机系统中，CPU、GPU和显示器以一种特定的方式协作：CPU将计算好的显示内容提交给 GPU，GPU渲染后放入帧缓冲区，然后视频控制器按照垂直同步信号从帧缓冲区取帧数据传递给显示器显示。
CPU和GPU的任务是各有偏重的，CPU主要用于基本数学和逻辑计算，而GPU主要执行和图形处理相关的复杂的数学，如矩阵变化和几何计算，GPU的主要作用就是确定最终输送给显示器的各个像素点的色值。


3）Element的生命周期
Framework 调用Widget.createElement 创建一个Element实例，记为element
Framework 调用 element.mount(parentElement,newSlot) ，mount方法中首先调用element所对应Widget的createRenderObject方法创建与element相关联的RenderObject对象，然后调用element.attachRenderObject方法将element.renderObject添加到渲染树中插槽指定的位置（这一步不是必须的，一般发生在Element树结构发生变化时才需要重新添加）。插入到渲染树后的element就处于“active”状态，处于“active”状态后就可以显示在屏幕上了

当有父Widget的配置数据改变时，同时其State.build返回的Widget结构与之前不同，此时就需要重新构建对应的Element树。为了进行Element复用，在Element重新构建前会先尝试是否可以复用旧树上相同位置的element，element节点在更新前都会调用其对应Widget的canUpdate方法，如果返回true，则复用旧Element，旧的Element会使用新Widget配置数据更新，反之则会创建一个新的Element。Widget.canUpdate主要是判断newWidget与oldWidget的runtimeType和key是否同时相等，如果同时相等就返回true，否则就会返回false。根据这个原理，当我们需要强制更新一个Widget时，可以通过指定不同的Key来避免复用。

当有祖先Element决定要移除element 时（比如Widget树结构发生了变化，导致element对应的Widget被移除），这时该祖先Element就会调用deactivateChild 方法来移除它，移除后element.renderObject也会被从渲染树中移除，然后Framework会调用element.deactivate 方法，这时element状态变为“inactive”状态。

“inactive”态的element将不会再显示到屏幕。为了避免在一次动画执行过程中反复创建、移除某个特定element，“inactive”态的element在当前动画最后一帧结束前都会保留，如果在动画执行结束后它还未能重新变成“active”状态，Framework就会调用其unmount方法将其彻底移除，这时element的状态为defunct,它将永远不会再被插入到树中。
如果element要重新插入到Element树的其他位置，如element或element的祖先拥有一个GlobalKey（用于全局复用元素），那么Framework会先将element从现有位置移除，然后再调用其activate方法，并将其renderObject重新attach到渲染树。


4）BuildContext
BuildContext就是widget对应的Element，所以我们可以通过context在StatelessWidget和StatefulWidget的build方法中直接访问Element对象。我们获取主题数据的代码Theme.of(context)内部正是调用了Element的dependOnInheritedWidgetOfExactType()方法。

5）Flutter的启动流程
入口是main函数，调用runApp()方法在内部通过WidgetsFlutterBinding将Widget框架和Flutter引擎连接起来。WidgetsFlutterBinding负责初始化一个WidgetsBinding的全局单例，紧接着会调用WidgetsBinding的attachRootWidget方法，该方法负责将Widget添加到RenderView上。RenderView是一个RenderObject，它是渲染树的根，RenderViewElement是RenderView对应的Element对象。

6）setState被调用到UI更新的大概过程
setState 调用后：
首先调用当前 element 的 markNeedsBuild(标记需要Build方法) 方法，将当前 element标记为 dirty 。
然后将当前 element 添加到dirtyElements 列表，最后通过监听垂直同步信号的到来重新构建Widget树。

重新构建Widget树：
如果diwtyElements列表不为空，则遍历该列表，调用每一个element的rebuild方法重新构建新的Widget，由于新的Widget使用新的状态构建，所以可能导致Widget布局信息发生变化，如果发生变化，则会调用其RenderObject的markNeedsLayout方法，这个方法会从当前节点向父级查找，直到找到一个relayoutBoundary的节点，然后会将它添加到一个全局的nodesNeedingLayout列表中；如果直到根节点也没有找到relayoutBoundary，则将根节点添加到nodesNeedingLayout列表中。

更新布局：
遍历nodesNeedingLayout数组，然后调用RenderObject的layout方法重新布局，确定新的大小和位置。layout方法中会调用markNeedsPaint()，这个方法和markNeedsLayout方法功能类似，也会从当前节点向父级查找，直到找到一个isRepaintBoundary属性为true的父节点，然后将它添加到一个全局的nodesNeedingPaint列表中；由于根节点RenderView的isRepaintBoundary为true，所以必会找到一个，最后会请求下一帧的到来。

更新绘制：
遍历nodesNeedingPaint列表，调用每一个节点的paint方法进行重绘，绘制过程会生成Layer。flutter中绘制结果是保存在Layer中的，也就是说只要Layer不释放，那么绘制的结果就会被缓存，因此，Layer可以缓存绘制结果，避免不必要的重绘开销。Flutter框架绘制过程中，遇到isRepaintBoundary 为 true 的节点时，才会生成一个新的Layer。

上屏：
绘制完成后得到的是一棵Layer树，需要将Layer树中的绘制信息提交给Flutter引擎然后在屏幕上显示。


7）安全更新
在 build 阶段不能调用 setState，实际上在组件的布局阶段和绘制阶段也都不能直接再同步请求重新布局或重绘，道理是相同的，那在这些阶段正确的更新方式是什么呢，我们以 setState 为例，可以通过如下方式：
// 在build、布局、绘制阶段安全更新
void update(VoidCallback fn) {
SchedulerBinding.instance.addPostFrameCallback((_) {
setState(fn);
});
}

8）Layout布局过程
Layout（布局）过程主要是确定每一个组件的布局信息（大小和位置），Flutter 的布局过程如下：

父节点向子节点传递约束（constraints）信息，限制子节点的最大和最小宽高。
子节点根据约束信息确定自己的大小（size）。
父节点根据特定布局规则（不同布局组件会有不同的布局算法）确定每一个子节点在父节点布局空间中的位置，用偏移 offset 表示。
递归整个过程，确定出每一个节点的大小和位置。
可以看到，组件的大小是由自身决定的，而组件的位置是由父组件决定的。

布局的逻辑是在 performLayout 方法中实现的。我们梳理一下 performLayout 中具体做的事：
如果有子组件，则对子组件进行递归布局。
确定当前组件的大小（size），通常会依赖子组件的大小。
确定子组件在当前组件中的起始偏移。

parentData：
parentData虽然属于child的属性，但它从设置（包括初始化）到使用都在父节点中，实际上Flutter框架中，parentData 这个属性主要就是为了在 layout 阶段保存组件布局信息而设计的。

布局边界（relayoutBoundary）：
每个组件的 renderObject 中都有一个 _relayoutBoundary 属性指向自身的布局边界节点，如果当前节点布局发生变化后，自身到其布局边界节点路径上的所有的节点都需要 relayout。
relayoutBoundary的原则是“组件自身的大小变化不会影响父组件”，如果一个组件满足以下四种情况之一，则它便是relayoutBoundary ：
当前组件父组件的大小不依赖当前组件大小时；这种情况下父组件在布局时会调用子组件布局函数时并会给子组件传递一个 parentUsesSize 参数，该参数为 false 时表示父组件的布局算法不会依赖子组件的大小。

组件的大小只取决于父组件传递的约束，而不会依赖后代组件的大小。这样的话后代组件的大小变化就不会影响自身的大小了，这种情况组件的 sizedByParent 属性必须为 true（具体我们后面会讲）。

父组件传递给自身的约束是一个严格约束（固定宽高，下面会讲）；这种情况下即使自身的大小依赖后代元素，但也不会影响父组件。

组件为根组件；Flutter 应用的根组件是 RenderView，它的默认大小是当前设备屏幕大小。

markNeedsLayout：
当组件布局发生变化时，它需要调用 markNeedsLayout 方法来更新布局，它的功能主要有两个：
将自身到其 relayoutBoundary 路径上的所有节点标记为 “需要布局” 。
请求新的下一帧；在新的下一帧中会对标记为“需要布局”的节点重新布局。


如果不是布局边界节点，递归调用当前节点到其布局边界节点路径上所有节点的方法 markNeedsLayout；如果是布局边界节点，将布局边界节点加入到 pipelineOwner._nodesNeedingLayout 列表中。


flushLayout()：
markNeedsLayout 执行完毕后，就会将其 relayoutBoundary 节点添加到 pipelineOwner._nodesNeedingLayout 列表中，然后请求下一帧，下一帧到来时就会执行 drawFrame 方法。
flushLayout() 中会对之前添加到 _nodesNeedingLayout 中的节点重新布局，它会按照节点在树中的深度从小到大排序后再重新layout，重新布局后，UI也是需要更新的。

如果组件有子组件，则在 performLayout 中需要调用子组件的 layout 方法先对子组件进行布局，简单来讲布局过程分以下几步：

1）确定当前组件的布局边界。

2）判断是否需要重新布局，如果没必要会直接返回，反之才需要重新布局。不需要布局时需要同时满足三个条件：

	当前组件没有被标记为需要重新布局。

	父组件传递的约束没有发生变化。

	当前组件的布局边界也没有发生变化时。

3）调用 performLayout() 进行布局，因为 performLayout() 中又会调用子组件的 layout 方法，所以这时一个递归的过程，递归结束后整个组件树的布局也就完成了。

4）请求重绘。




两种常用的约束：
宽松约束：不限制最小宽高（为0），只限制最大宽高，可以通过 BoxConstraints.loose(Size size) 来快速创建。
严格约束：限制为固定大小；即最小宽度等于最大宽度，最小高度等于最大高度，可以通过 BoxConstraints.tight(Size size) 来快速创建。


布局总结：
在进行布局的时候，Flutter 会以深度优先遍历方式遍历渲染树，并将限制以自上而下的方式 从父节点传递给子节点。子节点若要确定自己的大小，则 必须 遵循父节点传递的限制。子节点的响应方式是在父节点建立的约束内 将大小以自下而上的方式 传递给父节点。








绘制原理：
1.Flutter中和绘制相关的对象有三个，分别是Canvas、Layer 和 Scene：

Canvas：封装了Flutter Skia各种绘制指令，比如画线、画圆、画矩形等指令。
Layer：分为容器类和绘制类两种；暂时可以理解为是绘制产物的载体，比如调用 Canvas 的绘制 API 后，相应的绘制产物被保存在 PictureLayer.picture（PictureLayer 的绘制产物是 Picture） 对象中。
Scene：屏幕上将要要显示的元素。在上屏前，我们需要将Layer中保存的绘制产物关联到 Scene 上。

2.Layer作为绘制产物的持有者有什么作用？

可以在不同的帧之间复用绘制产物（如果没有发生变化）。
划分绘制边界，缩小重绘范围。

3.Layer的分类：
OffsetLayer：根 Layer，它继承自ContainerLayer，而ContainerLayer继承自 Layer 类，我们将直接继承自ContainerLayer 类的 Layer 称为容器类Layer，容器类 Layer 可以添加任意多个子Layer。
PictureLayer：保存绘制产物的 Layer，它直接继承自 Layer 类。我们将可以直接承载（或关联）绘制结果的 Layer 称为绘制类 Layer。

4.容器类Layer的作用？

1）将组件树的绘制结构组成一棵树：因为 Flutter 中的 Widget 是树状结构，那么相应的 RenderObject 对应的绘制结构也应该是树状结构，Flutter 会为组件树生成一棵 Layer 树，而容器类Layer就可以组成树状结构（父 Layer 可以包含任意多个子 Layer，子Layer又可以包含任意多个子Layer）。
2)可以对多个 layer 整体应用一些变换效果:容器类 Layer 可以对其子 Layer 整体做一些变换效果，比如剪裁效果（ClipRectLayer、ClipRRectLayer、ClipPathLayer）、过滤效果（ColorFilterLayer、ImageFilterLayer）、矩阵变换（TransformLayer）、透明变换（OpacityLayer）等。

一般不会直接创建ContainerLayer，如果我们确实不需要任何变换效果，那么就使用 OffsetLayer，不用担心会有额外性能开销，它的底层Skia中实现是非常高效的。

5.绘制类Layer
我们知道最终显示在屏幕上的是位图信息，而位图信息正是由 Canvas API 绘制的。实际上，Canvas 的绘制产物是 Picture 对象表示，Flutter 中只有 PictureLayer 才拥有 picture 对象，换句话说，Flutter 中通过Canvas 绘制自身及其子节点的组件的绘制结果最终会落在 PictureLayer 中。

6.绘制相关实现在渲染对象 RenderObject 中，RenderObject 中和绘制相关的主要属性有：
layer
isRepaintBoundary:它的功能其实就是向组件树中插入一个绘制边界节点。
needsCompositing

7.组件树绘制流程
Flutter第一次绘制时，会从上到下开始递归的绘制子节点，每当遇到一个绘制边界节点，则判断如果该绘制边界节点的 layer 属性为空（类型为ContainerLayer），就会创建一个新的 OffsetLayer 并赋值给它；如果不为空，则直接使用它。然后会将边界节点的 layer 传递给子节点，接下来有两种情况：

1)如果子节点是非边界节点，且需要绘制，则会在第一次绘制时：
1.1 创建一个Canvas 对象和一个 PictureLayer，然后将它们绑定，后续调用Canvas 绘制都会落到和其绑定的PictureLayer 上。
1.2接着将这个 PictureLayer 加入到绘制边界节点的 layer 中。
2)如果不是第一次绘制，则复用已有的 PictureLayer 和 Canvas 对象 。
3)如果子节点是绘制边界节点，则对子节点递归上述过程。当子树的递归完成后，就要将子节点的layer 添加到父级 Layer中。

整个流程执行完后就生成了一棵Layer树。下面我们通过一个例子来理解整个过程：图14-10 左边是 widget 树，右边是最终生成的Layer树，我们看一下生成过程：
这个图需要从14.6.2中获取。
1）RenderView 是 Flutter 应用的根节点，绘制会从它开始，因为他是一个绘制边界节点，在第一次绘制时，会为他创建一个 OffsetLayer，我们记为 OffsetLayer1，接下来 OffsetLayer1会传递给Row.
2）由于 Row 是一个容器类组件且不需要绘制自身，那么接下来他会绘制自己的孩子，它有两个孩子，先绘制第一个孩子Column1，将 OffsetLayer1 传给 Column1，而 Column1 也不需要绘制自身，那么它又会将 OffsetLayer1 传递给第一个子节点Text1。
3）Text1 需要绘制文本，他会使用 OffsetLayer1进行绘制，由于 OffsetLayer1 是第一次绘制，所以会新建一个PictureLayer1和一个 Canvas1 ，然后将 Canvas1 和PictureLayer1 绑定，接下来文本内容通过 Canvas1 对象绘制，Text1 绘制完成后，Column1 又会将 OffsetLayer1 传给 Text2 。
4）Text2 也需要使用 OffsetLayer1 绘制文本，但是此时 OffsetLayer1 已经不是第一次绘制，所以会复用之前的 Canvas1 和 PictureLayer1，调用 Canvas1来绘制文本。
5）Column1 的子节点绘制完成后，PictureLayer1 上承载的是Text1 和 Text2 的绘制产物。
6）接下来 Row 完成了 Column1 的绘制后，开始绘制第二个子节点 RepaintBoundary，Row 会将 OffsetLayer1 传递给 RepaintBoundary，由于它是一个绘制边界节点，且是第一次绘制，则会为它创建一个 OffsetLayer2，接下来 RepaintBoundary 会将 OffsetLayer2 传递给Column2，和 Column1 不同的是，Column2 会使用 OffsetLayer2 去绘制 Text3 和 Text4，绘制过程同Column1，在此不再赘述。
7）当 RepaintBoundary 的子节点绘制完时，要将 RepaintBoundary 的 layer（ OffsetLayer2 ）添加到父级Layer（OffsetLayer1）中。
至此，整棵组件树绘制完成，生成了一棵右图所示的 Layer 树。需要说名的是 PictureLayer1 和 OffsetLayer2 是兄弟关系，它们都是 OffsetLayer1 的孩子。通过上面的例子我们至少可以发现一点：同一个 Layer 是可以多个组件共享的，比如 Text1 和 Text2 共享 PictureLayer1。

如果共享的话，会不会导致一个问题，比如 Text1 文本发生变化需要重绘时，是不是也会连带着 Text2 也必须重绘？
答案是：是！这貌似有点不合理，既然如此那为什么要共享呢？不能每一个组件都绘制在一个单独的 Layer 上吗？这样还能避免相互干扰。原因其实还是为了节省资源，Layer 太多时 Skia 会比较耗资源，所以这其实是一个trade-off。


markNeedsRepaint发起重绘：
1.markNeedsRepaint重绘的过程：
1）会从当前节点一直往父级查找，直到找到一个绘制边界节点时终止查找，然后会将该绘制边界节点添加到其PiplineOwner的 _nodesNeedingPaint列表中（保存需要重绘的绘制边界节点）。
2）在查找的过程中，会将自己到绘制边界节点路径上所有节点的_needsPaint属性置为true，表示需要重新绘制。
3）请求新的 frame ，执行重绘重绘流程。

flushPaint流程：
请求新的 frame后，下一个 frame 到来时就会走drawFrame流程，drawFrame中和绘制相关的涉及flushCompositingBits、flushPaint 和 compositeFrame 三个函数，而重新绘制的流程在 flushPaint 中。

组件树中某个节点要更新自己时会调用markNeedsRepaint方法，而该方法会从当前节点一直往上查找，直到找到一个isRepaintBoundary为 true 的节点，然后会将该节点添加到 nodesNeedingPaint列表中。因此，nodesNeedingPaint中的节点的isRepaintBoundary 必然为 true，换句话说，能被添加到 nodesNeedingPaint列表中节点都是绘制边界节点，那么这个绘制边界节点究竟是如何起作用的？

绘制边界节点的作用？
******在绘制边界节点时会首先检查其是否有layer，如果没有就会创建一个新的 OffsetLayer 给它，通过其layer构建一个paintingContext，之后layer便和childContext绑定，这意味着通过同一个paintingContext的canvas绘制的产物属于同一个layer。然后调用绘制边界节点的paint方法绘制自身，绘制自身分为两种：如果节点为容器则绘制自身和孩子，如果非容器则绘制自身；如果layer不为空，则清空它的子绘制边界节点。
绘制孩子的方法：如果当前节点是绘制边界节点且需要重新绘制，会先走一遍******的过程，这个过程走完之后，会将当前节点的layer添加到父边界节点的Layer中；如果当前节点不是边界节点，则调用paint方法；如果遇到绘制边界节点且当其不需要重绘（_needsPaint 为 false) 时，会直接复用该边界节点的 layer，而无需重绘！这就是绘制边界节点能复用的原理。
向 Layer 树中添加Layer的标准操作：先结束当前 PictureLayer 的绘制，再添加到 layer树
可以在14.6.5上面找图加深理解。

创建好Layout之后就是上屏显示了，将Layer树中每一个layer传给Skia，最后就是将绘制数据发给GPU进行渲染。

在Flutter中一个layer可能会反复被添加到多个容器类Layer中，或从容器中移除，这样一来有些时候我们可能会搞不清楚一个layer是否还被使用，为了解决这个问题，Flutter中定义了一个LayerHandle 类来专门管理layer，内部是通过引用计数的方式来跟踪layer是否还有使用者，一旦没有使用者，会自动调用layer.dispose来释放资源。

新的一帧到来，在RendererBinding#drawFrame中调用pipelineOwner.flushPaint()（相当于监听新的一帧的到来然后绘制）







Http分块下载（断点续传）：
Http协议定义了分块传输的响应header字段，但具体是否支持取决于服务端的实现，我们可以指定请求头的"range"字段来验证服务器是否支持分块传输。例如，我们可以利用curl命令来验证：
curl -H "Range: bytes=0-10" https://image.59cdn.com/wajiucrmtestapk/wajiu_crm_test_update_481.apk -v
我们在请求头中添加"Range: bytes=0-10"的作用是，告诉服务器本次请求我们只想获取文件0-10(包括10，共11字节)这块内容。如果服务器支持分块传输，则响应状态码为206，表示“部分内容”，并且同时响应头中包含“Content-Range”字段，如果不支持则不会包含。
Content-Range: bytes 0-10/233295878
0-10表示本次返回的区块，233295878代表文件的总长度，单位都是byte, 也就是该文件大概233M多一点。


Dio发起多个并发请求：
response= await Future.wait([dio.post("/info"),dio.get("/token")]);


国际化：
默认情况下，Flutter SDK中的组件仅提供美国英语本地化资源（主要是文本）。要添加对其他语言的支持，应用程序须添加一个名为“flutter_localizations”的包依赖，然后还需要在MaterialApp中进行一些配置。 要使用flutter_localizations包，首先需要添加依赖到pubspec.yaml文件中：
dependencies:
flutter:
sdk: flutter
flutter_localizations:
sdk: flutter
接下来，下载flutter_localizations库，然后指定MaterialApp/GetMaterialApp的localizationsDelegates和supportedLocales：
MaterialApp(
localizationsDelegates: [
// 本地化的代理类
GlobalMaterialLocalizations.delegate,
GlobalWidgetsLocalizations.delegate,
],
supportedLocales: [
const Locale('en', 'US'), // 美国英语
const Locale('zh', 'CN'), // 中文简体
//其他Locales
],
// ...
)
localizationsDelegates列表中的元素是生成本地化值集合的工厂类。GlobalMaterialLocalizations.delegate 为Material 组件库提供的本地化的字符串和其他值，它可以使Material 组件支持多语言。 GlobalWidgetsLocalizations.delegate定义组件默认的文本方向，从左到右或从右到左，这是因为有些语言的阅读习惯并不是从左到右，比如如阿拉伯语就是从右向左的。
supportedLocales也接收一个Locale数组，表示我们的应用支持的语言列表。

Locale:
Locale (opens new window)类是用来标识用户的语言环境的，它包括语言和国家两个标志如：
const Locale('zh', 'CN') // 中文简体

我们始终可以通过以下方式来获取应用的当前区域Locale：
Locale myLocale = Localizations.localeOf(context);


类似showModalBottomSheet，showDialog等等的弹出对话框的实现方式内部也是以路由Navigator的方式实现的，弹出的时候内部push，dismiss的时候需要这样设置：
Navigator.of(context).pop(index);
如果使用的是Getx，dismiss的时候需要：
Get.back();


=============================================事件分发=============================================
Flutter 事件处理流程主要分两步：
命中测试：当手指按下时，触发 PointerDownEvent 事件，按照深度优先遍历当前渲染树，对每一个渲染对象进行“命中测试”（hit test），如果命中测试通过，则该渲染对象会被添加到一个 HitTestResult 列表当中。
事件分发：命中测试完毕后，会遍历 HitTestResult 列表，调用每一个渲染对象的事件处理方法handleEvent来处理PointerDownEvent事件，该过程称为事件分发。随后续事件将会分发到对应的RenderObject上面。
事件清理：当手指抬（ PointerUpEvent ）起或事件取消时（PointerCancelEvent），会先对相应的事件进行分发，分发完毕后会清空 HitTestResult 列表。

需要注意：
1）命中测试是在PointerDownEvent事件触发时进行的，一个完成的事件流是 down > move > up (cancle)。
2）如果父子组件都监听了同一个事件，则子组件会比父组件先响应事件。这是因为命中测试过程是按照深度优先规则遍历的，所以子渲染对象会比父渲染对象先加入 HitTestResult 列表，又因为在事件分发时是从前到后遍历HitTestResult数组的，所以子组件比父组件会更先被调用handleEvent。


#8.3.2 命中测试详解
#1. 命中测试的起点
一个对象是否可以响应事件，取决于在其对命中测试过程中是否被添加到了HitTestResult列表 ，如果没有被添加进去，则后续的事件分发将不会分发给自己。当发生用户事件时，Flutter会从根节点RenderView开始调用它hitTest() 。

整体命中测试分两步：
第一步： 命中测试的逻辑都在RenderObject中，而并非在Widget或Element中，它的具体实现逻辑是RenderView来处理的，RenderView是渲染树的顶点。RenderObject对象的hitTest方法主要功能是：从该节点出发，按照深度优先的顺序递归遍历子渲染树上的每一个节点并对它们进行命中测试。这个过程称为“渲染树命中测试”。
第二步：渲染树命中测试完毕后，会调用 GestureBinding 的hitTest方法，该方法主要用于处理手势。

#2. 渲染树命中测试过程
渲染树的命中测试流程就是父节点 hitTest 方法中不断调用子节点 hitTest 方法的递归过程。

// 发起命中测试，position 为事件触发的坐标（如果有的话）。
bool hitTest(HitTestResult result, { Offset position }) {
if (child != null)
child.hitTest(result, position: position); //递归对子树进行命中测试
//根节点会始终被添加到HitTestResult列表中
result.add(HitTestEntry(this));
return true;
}
因为 RenderView 只有一个孩子，所以直接调用child.hitTest 即可。如果一个渲染对象有多个子节点，则命中测试逻辑为：如果任意一个子节点通过了命中测试或者当前节点“强行声明”自己通过了命中测试，则当前节点会通过命中测试。我们以RenderBox为例，看看它的hitTest()实现：

bool hitTest(HitTestResult result, { @required Offset position }) {
...  
if (_size.contains(position)) { // 判断事件的触发位置是否位于组件范围内
if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
result.add(BoxHitTestEntry(this, position));
return true;
}
}
return false;
}
上面代码中:

hitTestChildren() 功能是判断是否有子节点通过了命中测试，如果有，则会将子组件添加到 HitTestResult 中同时返回 true；如果没有则直接返回false。该方法中会递归调用子组件的 hitTest 方法。
hitTestSelf() 决定自身是否通过命中测试，如果节点需要确保自身一定能响应事件可以重写此函数并返回true ，相当于“强行声明”自己通过了命中测试。
需要注意，节点通过命中测试的标志是它被添加到 HitTestResult 列表中，而不是它 hitTest 的返回值，虽然大所数情况下节点通过命中测试就会返回 true，但是由于开发者在自定义组件时是可以重写 hitTest 的，所以有可能会在在通过命中测试时返回 false，或者未通过命中测试时返回 true，当然这样做并不好，我们在自定义组件时应该尽可能避免，但是在有些需要自定义命中测试流程的场景下可能就需要打破这种默契，比如我们将在本节后面实现的 HitTestBlocker 组件。

所以整体逻辑就是：

先判断事件的触发位置是否位于组件范围内，如果不是则不会通过命中测试，此时 hitTest 返回 false，如果是则到第二步。
会先调用 hitTestChildren() 判断是否有子节点通过命中测试，如果是，则将当前节点添加到 HitTestResult 列表，此时 hitTest 返回 true。即只要有子节点通过了命中测试，那么它的父节点（当前节点）也会通过命中测试。
如果没有子节点通过命中测试，则会取 hitTestSelf 方法的返回值，如果返回值为 true，则当前节点通过命中测试，反之则否。
如果当前节点有子节点通过了命中测试或者当前节点自己通过了命中测试，则将当前节点添加到 HitTestResult 中。又因为 hitTestChildren()中会递归调用子组件的 hitTest 方法，所以组件树的命中测试顺序深度优先的，即如果通过命中测试，子组件会比父组件会先被加入HitTestResult 中。

我们可以看到上面代码的主要逻辑是遍历调用子组件的 hitTest() 方法，同时提供了一种中断机制：即遍历过程中只要有子节点的 hitTest() 返回了 true 时：

会终止子节点遍历，这意味着该子节点前面的兄弟节点将没有机会通过命中测试。注意，兄弟节点的遍历倒序的。
父节点也会通过命中测试。因为子节点 hitTest() 返回了 true 导父节点 hitTestChildren 也会返回 true，最终会导致 父节点的 hitTest 返回 true，父节点被添加到 HitTestResult 中。
当子节点的 hitTest() 返回了 false 时，继续遍历该子节点前面的兄弟节点，对它们进行命中测试，如果所有子节点都返回 false 时，则父节点会调用自身的 hitTestSelf 方法，如果该方法也返回 false，则父节点就会被认为没有通过命中测试。

下面思考两个问题：

为什么要制定这个中断呢？因为一般情况下兄弟节点占用的布局空间是不重合的，因此当用户点击的坐标位置只会有一个节点，所以一旦找到它后（通过了命中测试，hitTest 返回true），就没有必要再判断其他兄弟节点了。但是也有例外情况，比如在 Stack 布局中，兄弟组件的布局空间会重叠，如果我们想让位于底部的组件也能响应事件，就得有一种机制，能让我们确保：即使找到了一个节点，也不应该终止遍历，也就是说所有的子组件的 hitTest 方法都必须返回 false！为此，Flutter 中通过 HitTestBehavior 来定制这个过程，这个我们会在本节后面介绍。
为什么兄弟节点的遍历要倒序？同 1 中所述，兄弟节点一般不会重叠，而一旦发生重叠的话，往往是后面的组件会在前面组件之上，点击时应该是后面的组件会响应事件，而前面被遮住的组件不能响应，所以命中测试应该优先对后面的节点进行测试，因为一旦通过测试，就不会再继续遍历了。如果我们按照正向遍历，则会出现被遮住的组件能响应事件，而位于上面的组件反而不能，这明显不符合预期。
我们回到 hitTestChildren 上，如果不重写 hitTestChildren，则默认直接返回 false，这也就意味着后代节点将无法参与命中测试，相当于事件被拦截了，这也正是 IgnorePointer 和 AbsorbPointer 可以拦截事件下发的原理。

如果 hitTestSelf 返回 true，则无论子节点中是否有通过命中测试的节点，当前节点自身都会被添加到 HitTestResult 中。而 IgnorePointer 和 AbsorbPointer 的区别就是，前者的 hitTestSelf 返回了 false，而后者返回了 true。

命中测试完成后，所有通过命中测试的节点都被添加到了 HitTestResult 中。

#8.3.6 总结
组件只有通过命中测试才能响应事件。
一个组件是否通过命中测试取决于 hitTestChildren(...) || hitTestSelf(...) 的值。
组件树中组件的命中测试顺序是深度优先的。
组件子节点命中测试的循序是倒序的，并且一旦有一个子节点的 hitTest 返回了 true，就会终止遍历，后续子节点将没有机会参与命中测试。这个原则可以结合 Stack 组件来理解。
大多数情况下 Listener 的 HitTestBehavior 为 opaque 或 translucent 效果是相同的，只有当其子节点的 hitTest 返回为 false 时才会有区别。
HitTestBlocker 是一个很灵活的组件，我们可以通过它干涉命中测试的各个阶段。
