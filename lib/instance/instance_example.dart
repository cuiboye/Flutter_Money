/**
 * 单例模式
 */
class Singleton {
  static Singleton _instance;

  Singleton._internal() {
    _instance = this;
  }
  //factory关键字提供了返回自身的功能
  factory Singleton() => _instance ?? Singleton._internal();
}