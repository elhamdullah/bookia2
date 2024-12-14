// core/services/endpoints.dart
class AppEndPoints {
  //auth
  static const String baseUrl = 'https://codingarabic.online/api';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String verifyCode = '/check-forget-password';
  static const String newPassword = '/reset-password';

  // home
  static const String newArrivalsBooks = '/products-new-arrivals';
  static const String sliders = '/sliders';

  //whistList
  static const String addToWhistList = '/add-to-wishlist';
  static const String getWhistList = '/wishlist';
  static const String removeFromWhistList = '/remove-from-wishlist';

  //cart
  static const String addToCartList = '/add-to-cart';
  static const String getCartList = '/cart';
  static const String removeFromCartList = '/update-cart';

  //place order checkout
  static const String placeOrder = '/place-order';

  //profile
  static const String getProfile = '/profile';
  static const String updateProfile = '/update-profile';

  //order history
  static const String orderHistory = '/order-history';

  //search
  static const String search = '/products-search';
}
