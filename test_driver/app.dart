import 'package:epigo_project/main.dart'as app;
import 'package:flutter_driver/driver_extension.dart';
void main(){
  //this line enable the extension
enableFlutterDriverExtension();
//call the main() function of the app, or call runApp with
//any widget you are interested in testing
app.main();

}