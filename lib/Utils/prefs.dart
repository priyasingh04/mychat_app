
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

Future init() async{
  return preferences = await SharedPreferences.getInstance();


}