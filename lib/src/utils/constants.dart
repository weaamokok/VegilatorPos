import '../manage purchases/presentation/view/home_screen.dart';

class AppConst {
  ///table names
  static const String vegetable = 'vegetable';
  static const String user = 'user';
  static const String position = 'position';
  static const String invoice = 'invoice';
  static const String sale = 'sale';
  static const String catagory = 'catagory';

//veges
  static const String id = 'id';
  static const String name = 'name';
  static const String code = 'code';
  static const String salePrice = 'sale_price';
  static const String buyPrice = 'buy_price';
  static const String catagoryId = 'catagory_id';
  static const String image = 'image';
  static const String userId = 'user_id';

  //user
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String password = 'password';
  static const String phoneNumber = 'phone_number';
  static const String positionId = 'position_id';
  static const String email = 'email';
  static const String accountState = 'account_state';
  //invoice
  static const String totalAmount = 'total_amount';
  static const String dateRecorded = 'date_record';
  static const String paymentType = 'payment_type';
  //sale
  static const String subTotal = 'sub_total';
  static const String unitPrice = 'unit_price';
  static const String vegeId = 'vege_id';
  static const String invoiceId = 'invoice_id';
  static const String quantity = 'quantity';
  //position
    static const String title = 'title';

    ///appConstans
    //>> storage
    static const String isFirstLunch='isFirstLunch';
//bottom navigation pages 
static const navPages=[
              HomePage(),
              
            
            ];
}
