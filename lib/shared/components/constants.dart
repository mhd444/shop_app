
import '../../modules/shop_app/login/login_screen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';


void signOut(context)
{
  CashHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String token = '';