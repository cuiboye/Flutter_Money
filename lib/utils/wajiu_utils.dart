/**
 * 工具类
 */
class WajiuUtils {
  /**
   * 判断集合是否为空
   */
  static bool? collectionIsEmpty(List? data) {
    return data?.isEmpty==true || null==data;
  }

  /**
   * 判断集合是否越界
   */
  static bool collectionIsSafe(List data, int pos) {
    if (data.isEmpty) {
      return false;
    }
    if (pos < 0 || pos > data.length - 1) {
      return false;
    }
    return true;
  }
}
