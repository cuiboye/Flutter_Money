/**
 * 接口地址
 */
class ApiService{
  //登录
  static const String login = "/api/login/appLogin";
  //获取首页数据
  static const String indexApp = "/api/index/indexApp";
  //分类-一级数据
  static const String categoryTypeList = "/api/product/category/type_list";
  //分类-二级数据
  static const String secondCategoryTypeList = "/api/product/category/param_list";
  static const String productListScrenn = "api/product/list/screen";
  //名庄现货列表
  static const String appGaoduan = "/api/shop/appGaoduan/5/9";
  //全球热卖 加载更多
  static const String indexAppProduct = "/api/index/indexAppProduct";
  static const String findAllProduct = "/shopcarproduct/getDataWithPage";
  //加入采购车
  static const String addGoodToShopCar = "/shopcarproduct/addGoodsToShopcar";
  //获取采购车数据
  static const String getShopCarData = "/shopcar/getShopCarData";
  //采购车更改商品勾选状态
  static const String changeProductSelectStatus = "/shopcar/changeProductSelectStatus";
  //订单列表
  static const String getOrderList = "/danyuan/getOrderList";
  //余额,这个用的不是挖酒的，是自己写的
  static const String getBalanceData = "/mine/getBalancedata";
  //我的订单
  static const String getMyDelivery = "/api/buyCenter/myDelivery";
}