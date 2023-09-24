import '../core/models/address_model.dart';

class AddressUtils {
  static String convertAddressModel(AddressModel? addressModel) {
    if (addressModel == null) {
      return 'Bạn chưa có địa chỉ giao hàng mặc định, vui lòng cập nhật ngay';
    } else {
      return '${addressModel.name} | ${addressModel.phone}\n${addressModel.address}';
    }
  }
}
