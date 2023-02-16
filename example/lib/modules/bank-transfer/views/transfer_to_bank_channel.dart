import 'package:animate_do/animate_do.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/bank-transfer/widgets/bank_transfer_confirmation.dart';
import 'package:example/modules/bank-transfer/widgets/bank_transfer_info.dart';
import 'package:example/modules/bank-transfer/widgets/bank_transfer_loading.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/error_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankTransferChannel extends StatelessWidget {
  const BankTransferChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UssdNotifier un = Provider.of<UssdNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return FadeIn(
      // key: Key(bn.currentCardView.toString()),
      child: Builder(builder: (context) {
        switch (bn.currentCardView) {
          case CurrentCardView.loading:
            return const BankTransferLoading();
          case CurrentCardView.info:
            return const BankTransferInfo();
          case CurrentCardView.progress:
            return const BankTransferLoading();
          case CurrentCardView.confirmPayment:
            return const BankTransferConfirmation();
          case CurrentCardView.error:
            return const ErrorCard();
          default:
            return Container();
        }
      }),
    );
  }
}
