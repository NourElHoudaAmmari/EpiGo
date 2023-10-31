
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/category_controller.dart';
import 'package:epigo_project/controllers/image_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:get/get.dart';
class HomeBindings implements Bindings {
  @override
  void dependencies() {
      
    Get.lazyPut(() => AuthentificationRepository(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => ImageController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
   // Get.lazyPut(() => OrderController(), fenix: true);
   Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SearchController(), fenix: true);
       Get.lazyPut(() => ProfileController(), fenix: true);
  }
}