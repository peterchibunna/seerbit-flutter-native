import 'package:animate_do/animate_do.dart';
import 'package:example/models/merchant_model.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/views/bank_account_channel.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/bank-transfer/views/transfer_to_bank_channel.dart';
import 'package:example/modules/debit-card/views/debit_card_channel.dart';
import 'package:example/modules/ussd/views/ussd_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'view-notifiers/view_notifier.dart';

class ChannelSelection extends StatelessWidget {
  const ChannelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return SingleChildScrollView(
        child: AnimatedContainer(
          // height: 600.h,
          duration: const Duration(seconds: 1),
          width: 270.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(mdm.payload.logo!, height: 50.h, width: 50.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      CustomText("Ollie Ollie",
                          size: 12, weight: FontWeight.bold),
                      YSpace(6),
                      CustomText("olaz@gmail.com", size: 12)
                    ],
                  )
                ],
              ),
              FadeInUp(
                key: Key(vn.paymentChannel.toString()),
                child: SizedBox(
                  width: double.infinity,
                  child: Builder(builder: (context) {
                    switch (vn.paymentChannel) {
                      case PaymentChannel.debitCard:
                        return const DebitCardChannel();
                      case PaymentChannel.bankAccount:
                        return const BankAccountChannel();
                      case PaymentChannel.transfer:
                        return const BankTransferChannel();
                      case PaymentChannel.ussd:
                        return const UssdChannel();
                      default:
                        return const DebitCardChannel();
                    }
                  }),
                ),
              ),
              const YSpace(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1, width: 60, color: Colors.grey.shade300),
                  const XSpace(10),
                  const Text("or pay via"),
                  const XSpace(10),
                  Container(height: 1, width: 60, color: Colors.grey.shade300),
                ],
              ),
              const YSpace(12),
              Column(
                children: [
                  Visibility(
                    visible: vn.isChannelActive(PaymentChannel.transfer),
                    child: CustomFlatButton(
                        prefix: const CustomText("Transfer",
                            size: 14, weight: FontWeight.bold),
                        alignment: MainAxisAlignment.start,
                        onTap: () async => {
                              vn.changePaymentChannel(PaymentChannel.transfer),
                            },
                        expand: true,
                        color: Colors.black,
                        bgColor: Colors.grey.shade200),
                  ),
                  const YSpace(4),
                  Visibility(
                    visible: vn.isChannelActive(PaymentChannel.ussd),
                    child: CustomFlatButton(
                        prefix: const CustomText("USSD",
                            size: 14, weight: FontWeight.bold),
                        suffix: const CustomText("*bank ussd code#",
                            size: 14, weight: FontWeight.bold),
                        alignment: MainAxisAlignment.spaceBetween,
                        onTap: () =>
                            vn.changePaymentChannel(PaymentChannel.ussd),
                        expand: true,
                        color: Colors.black,
                        bgColor: Colors.grey.shade200),
                  ),
                  const YSpace(4),
                  Visibility(
                    visible: vn.isChannelActive(PaymentChannel.bankAccount),
                    child: CustomFlatButton(
                        alignment: MainAxisAlignment.start,
                        label: "Bank Account",
                        onTap: () =>
                            vn.changePaymentChannel(PaymentChannel.bankAccount),
                        expand: true,
                        color: Colors.black,
                        bgColor: Colors.grey.shade200),
                  ),
                  Visibility(
                    visible: vn.isChannelActive(PaymentChannel.debitCard),
                    child: CustomFlatButton(
                        prefix: const CustomText("Debit Card",
                            size: 14, weight: FontWeight.bold),
                        alignment: MainAxisAlignment.start,
                        onTap: () =>
                            vn.changePaymentChannel(PaymentChannel.debitCard),
                        expand: true,
                        color: Colors.black,
                        bgColor: Colors.grey.shade200),
                  ),
                  const YSpace(4),
                ],
              ),
              const YSpace(25),
              const SecuredByMarker(),
              const YSpace(25),
            ],
          ),
        ),
      );
    });
  }
}
