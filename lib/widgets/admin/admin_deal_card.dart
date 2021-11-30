import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../deal_card.dart';
import '../../models/deal_model.dart';

class AdminDealCard extends StatelessWidget {
  final DealModel deal;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;

  const AdminDealCard({
    Key? key,
    required this.deal,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DealCard(deal: deal),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  splashRadius: 20,
                ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  splashRadius: 20,
                ),
            ],
          )
        ],
      ),
    );
  }
}
