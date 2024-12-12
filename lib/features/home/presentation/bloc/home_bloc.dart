// features/home/presentation/bloc/home_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bookia/features/cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/features/cart/data/model/repo/cart_repo.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/product.dart';
import 'package:bookia/features/home/data/model/response/get_sliders_response/slider.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetNewArrivalsBooksEvent>(getNewArrivals);
    on<GetSlidersEvent>(getSliders);
    on<GetWhishListEvent>(getWhistList);
    on<AddToWhishListEvent>(addToWhistList);
    on<RemoveFromWhishListEvent>(removeFromWhistList);
    on<GetCartEvent>(getCartList);
    on<AddToCartEvent>(addToCartList);
    on<RemoveFromCartEvent>(removeFromCartList);
    on<PlaceOrderEvent>(placeOrder);
  }

//getNewArrivals bloc
  List<Product> newArrivalBooks = [];
  Future<void> getNewArrivals(
      GetNewArrivalsBooksEvent event, Emitter<HomeState> emit) async {
    emit(NewArrivalsBooksLoadingState());

    try {
      await HomeRepo.getNewArrivalsBooks().then((value) {
        if (value != null) {
          newArrivalBooks = value.data?.products ?? [];
          emit(NewArrivalsBooksLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //sliders bloc
  List<Slider> sliders = [];
  Future<void> getSliders(
      GetSlidersEvent event, Emitter<HomeState> emit) async {
    emit(GetSlidersLoadingState());

    try {
      await HomeRepo.getSliders().then((value) {
        if (value != null) {
          sliders = value.data?.sliders ?? [];
          emit(GetSlidersLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //get whistlist bloc
  List<Product> whishlist = [];
  Future<void> getWhistList(
      GetWhishListEvent event, Emitter<HomeState> emit) async {
    emit(GetWishListLoadingState());

    try {
      await WishlistRepo.getWhishList().then((value) {
        if (value != null) {
          whishlist = value.data?.data ?? [];
          print(whishlist);
          emit(GetWishListLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //add to whistlist bloc
  Future<void> addToWhistList(
      AddToWhishListEvent event, Emitter<HomeState> emit) async {
    emit(AddToWishListLoadingState());
    try {
      await WishlistRepo.addToWhishlist(productId: event.productId)
          .then((value) {
        if (value) {
          emit(AddToWishListLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //remove from whistlist bloc
  Future<void> removeFromWhistList(
      RemoveFromWhishListEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromWishListLoadingState());

    try {
      await WishlistRepo.removeFromWhishlist(productId: event.productId)
          .then((value) {
        if (value) {
          emit(RemoveFromWishListLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //get cart bloc
  GetCartResponse? cartResponse;
  Future<void> getCartList(GetCartEvent event, Emitter<HomeState> emit) async {
    emit(GetCartLoadingState());

    try {
      await CartRepo.getCartList().then((value) {
        if (value != null) {
          cartResponse = value;
          emit(GetCartLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //add to cart bloc
  Future<void> addToCartList(
      AddToCartEvent event, Emitter<HomeState> emit) async {
    emit(AddToCartLoadingState());
    try {
      await CartRepo.addToCartlist(productId: event.productId).then((value) {
        if (value) {
          emit(AddToCartLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  //remove from cart bloc
  Future<void> removeFromCartList(
      RemoveFromCartEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromCartLoadingState());
    try {
      await CartRepo.removeFromCartlist(productId: event.productId)
          .then((value) {
        if (value) {
          emit(RemoveFromCartLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  ///checkout bloc
  Future<void> placeOrder(
      PlaceOrderEvent event, Emitter<HomeState> emit) async {
    emit(CheckoutLoadingState());

    try {
      await HomeRepo.placeOrder(
        name: event.name,
        email: event.email,
        phone: event.phone,
        governorateId: event.governorateId,
        address: event.address,
      ).then((value) {
        if (value) {
          emit(GetCartLoadedState());
        } else {
          emit(HomeErrorState(message: "unknown error"));
        }
      });
    } on Exception catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }
}
