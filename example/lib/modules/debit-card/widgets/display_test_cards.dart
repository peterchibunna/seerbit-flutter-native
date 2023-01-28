import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayTestCards extends StatelessWidget {
  const DisplayTestCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      PaymentPayloadModel ppm = vn.paymentPayload!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(48),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText("Select test card", size: 14),
                const YSpace(12),
                CustomFlatButton(
                  onTap: () {
                    vn.setPaymentPayload(vn.paymentPayload!.copyWith(
                        cardNumber: "5123450000000008",
                        cvv: "100",
                        expiryMonth: "12",
                        expiryYear: "24",
                        paymentType: "CARD",
                        isCardInternational: "LOCAL",
                        channelType: "MASTERCARD"));

                    dcn.changeView(CurrentCardView.info);
                  },
                  alignment: MainAxisAlignment.spaceBetween,
                  prefix: const CustomText("MC", size: 14),
                  suffix: const CustomText("5123 4500 0000 0008",
                      size: 14, weight: FontWeight.bold),
                  hasBorder: true,
                  expand: true,
                ),
                const YSpace(6),
                CustomFlatButton(
                  onTap: () {
                    vn.setPaymentPayload(vn.paymentPayload!.copyWith(
                        cardNumber: "4485275742308327",
                        cvv: "100",
                        expiryMonth: "12",
                        expiryYear: "24",
                        paymentType: "CARD",
                        isCardInternational: "LOCAL",
                        channelType: "VISA"));

                    dcn.changeView(CurrentCardView.info);
                  },
                  alignment: MainAxisAlignment.spaceBetween,
                  prefix: const CustomText("MC", size: 14),
                  suffix: const CustomText("4485 2757 4230 8327",
                      size: 14, weight: FontWeight.bold),
                  hasBorder: true,
                  expand: true,
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              child: const CustomText("Use another card", size: 16),
              onPressed: () => dcn.changeView(CurrentCardView.info),
            ),
          ),
          const YSpace(20),
        ],
      );
    });
  }
}
