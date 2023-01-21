import 'package:flutter/material.dart';

class ViewsNotifier extends ChangeNotifier {
  PaymentChannel _paymentChannel = PaymentChannel.bankAccount;

  get paymentChannel => _paymentChannel;

  ///Select the payment channel to be used
  ///on the checkout view
  changePaymentChannel(PaymentChannel pc) {
    _paymentChannel = pc;
    notifyListeners();
  }
}

enum PaymentChannel { debitCard, bankAccount, ussd, transfer }
