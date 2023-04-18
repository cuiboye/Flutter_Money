/**
 * 接口地址
 */
class ApiService{
  //登录
  static const String login = "/api/login/appLogin";
  //获取首页数据
  static const String indexApp = "/api/index/indexApp";
  static const String findAllProduct = "/shopcarproduct/getDataWithPage";
  //加入采购车
  static const String addGoodToShopCar = "/shopcarproduct/addGoodsToShopcar";
  //获取采购车数据
  static const String getShopCarData = "/shopcar/getShopCarData";
  //采购车更改商品勾选状态
  static const String changeProductSelectStatus = "/shopcar/changeProductSelectStatus";
  //订单列表
  static const String getOrderList = "/danyuan/getOrderList";
  //余额
  static const String getBalanceData = "/mine/getBalancedata";

}