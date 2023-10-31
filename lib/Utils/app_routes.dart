
import 'package:epigo_project/screens/User/Cart/cart_screen.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';

import 'package:epigo_project/screens/User/Profile/profile_screen.dart';
import 'package:epigo_project/screens/User/Wishlist/favorite_screen.dart';
import 'package:get/get.dart';
appRoutes() => [
      GetPage(
        name: '/homeScreen',
        page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
         GetPage(
        name: '/cartScreen',
        page: () => CartScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
        /* GetPage(
        name: '/favoriteScreen',
        page: () =>FavoritesScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),*/
         GetPage(
        name: '/profileScreen',
        page: () => ProfileScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    

    /*  GetPage(
        name: '/uploadProductScreen',
        page: () => UploadProductScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/settings',
        page: () => Settings(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/userDetails',
        page: () => UserDetails(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/helpSupport',
        page: () => HelpSupport(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),*/
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}