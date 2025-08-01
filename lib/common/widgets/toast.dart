
import 'package:toast/toast.dart';

toastInfo({required String msg})  {
  Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.center);
}
