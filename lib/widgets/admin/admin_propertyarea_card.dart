import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/propertyarea_model.dart';

class AdminPropertyAreaCard extends StatelessWidget {
  final PropertyAreaModel area;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;

  const AdminPropertyAreaCard({
    Key? key,
    required this.area,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(area.nameAr),
              Text(area.nameEn),
            ],
          ),
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
