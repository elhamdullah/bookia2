// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

//new arrivals
class NewArrivalsBooksLoadingState extends HomeState {}

class NewArrivalsBooksLoadedState extends HomeState {}

//new arrivals
class GetSlidersLoadingState extends HomeState {}

class GetSlidersLoadedState extends HomeState {}

//////////////////////////////////////////////////////////////////////whishlist page

//whishlist
class GetWishListLoadingState extends HomeState {}

class GetWishListLoadedState extends HomeState {}

//add to whishlist
class AddToWishListLoadingState extends HomeState {}

class AddToWishListLoadedState extends HomeState {}

//Remove from whishlist
class RemoveFromWishListLoadingState extends HomeState {}

class RemoveFromWishListLoadedState extends HomeState {}

//////////////////////////////////////////////////////////////////////cart page

//get cart
class GetCartLoadingState extends HomeState {}

class GetCartLoadedState extends HomeState {}

//add to cart
class AddToCartLoadingState extends HomeState {}

class AddToCartLoadedState extends HomeState {}

//remove from cart
class RemoveFromCartLoadingState extends HomeState {}

class RemoveFromCartLoadedState extends HomeState {}


//checkout
class CheckoutLoadingState extends HomeState {}

class CheckoutLoadedState extends HomeState {}

//////////////////////////////////////////////////////////////////////generalerror
class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}
