class PaymentMethodModel {
  final String id;
  final String name;
  final String image;
  final bool isSelected;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isSelected,
  });

  static List<PaymentMethodModel> listPayment = [
    PaymentMethodModel(
      id: 'simple',
      name: 'Thanh toán khi nhận hàng',
      image: '',
      isSelected: true,
    ),
    PaymentMethodModel(
      id: 'zalo',
      name: 'Thanh toán qua ',
      image: 'images/ZaloPay_Cropped.png',
      isSelected: false,
    ),
  ];
}
