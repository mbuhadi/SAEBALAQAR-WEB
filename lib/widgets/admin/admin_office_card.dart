import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/office_model.dart';

class AdminOfficeCard extends StatelessWidget {
  final OfficeModel office;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;

  const AdminOfficeCard({
    Key? key,
    required this.office,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
                child: Image.network(
              office.image,
            )),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(office.name),
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
          ],
        ),
      ),
    );
  }
}
