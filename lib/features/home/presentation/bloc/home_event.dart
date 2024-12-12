// features/home/presentation/bloc/home_event.dart
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

//new arrivals event
class GetNewArrivalsBooksEvent extends HomeEvent {}

//sliders event
class GetSlidersEvent extends HomeEvent {}

///////////////////////////////////////////////////////////////////whishlist page
//get whishlist
class GetWhishListEvent extends HomeEvent {}

//add to whishlist
class AddToWhishListEvent extends HomeEvent {
  final int productId;
  AddToWhishListEvent({required this.productId});
}

//Remove from whishlist
class RemoveFromWhishListEvent extends HomeEvent {
  final int productId;
  RemoveFromWhishListEvent({required this.productId});
}

///////////////////////////////////////////////////////////////////cart page
///get cart
class GetCartEvent extends HomeEvent {}

///add to cart
class AddToCartEvent extends HomeEvent {
  final int productId;
  AddToCartEvent({required this.productId});
}

//Remove from cart
class RemoveFromCartEvent extends HomeEvent {
  final int productId;
  RemoveFromCartEvent({required this.productId});
}

class PlaceOrderEvent extends HomeEvent {
  String? name;
  String? phone;
  String? email;
  String? governorateId;
  String? address;

  PlaceOrderEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.governorateId,
    required this.address,
  });
}
