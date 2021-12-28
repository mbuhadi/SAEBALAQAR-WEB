import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'models/deal_model.dart';
import 'services/saeb_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';

class DealCard extends StatelessWidget {
  const DealCard({
    Key? key,
    required this.deal,
    this.isOwner = false,
  }) : super(key: key);
  final DealModel deal;
  final bool isOwner;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(deal.property_type.toString(),
                            style: Get.textTheme.headline5),
                        const SizedBox(width: 6),
                        Text("•",
                            style: TextStyle(
                                fontSize: 30, color: Colors.teal[600])),
                        const SizedBox(width: 6),
                        Text(deal.property_area.toString(),
                            style: Get.textTheme.headline5),
                        const SizedBox(width: 6),
                        Text("•",
                            style: TextStyle(
                                fontSize: 30, color: Colors.teal[600])),
                        const SizedBox(width: 6),
                        Text(deal.property_outlook.toString(),
                            style: Get.textTheme.headline5),
                      ],
                    ),
                    Text(timeago.format(deal.created, locale: 'ar'),
                        style: TextStyle(color: Colors.teal[600])),
                  ],
                ),
                const SizedBox(height: 12),
                Flexible(
                    child: Text(
                  deal.description,
                )),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              primary: const Color(0xFF23B33A),
                              side: const BorderSide(
                                  width: 2, color: Color(0xFF23B33A)),
                            ),
                            onPressed: () async {
                              final link = WhatsAppUnilink(
                                phoneNumber: "+965 " + deal.dealer.phone,
                                text:
                                    "السلام عليكم والرحمه، حاب تفاصيل اعلانكم الي في سيب العقار",
                              );
                              await launch('$link');
                            },
                            icon: const Icon(Icons.whatshot),
                            label: const Text("WhatsApp")),
                        const SizedBox(width: 4),
                        OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                            onPressed: () async {
                              await launch("tel://${deal.dealer.phone}");
                            },
                            icon: const Icon(Icons.phone),
                            label: const Text("اتصل")),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CachedNetworkImage(
                            imageUrl: MyApp.config.isDev
                                ? "https://i.imgur.com/KbwPb6Y.jpeg"
                                : deal.office.image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("المكتب",
                                style: TextStyle(color: Colors.grey)),
                            Text("الدلال",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(width: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(deal.office.name,
                                style: TextStyle(color: Colors.teal[600])),
                            Text(deal.dealer.name,
                                style: TextStyle(color: Colors.teal[600])),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
      );
  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: Container(
  //         height: 120,
  //         padding: const EdgeInsets.all(6),
  //         constraints: BoxConstraints(maxWidth: 600),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Expanded(
  //                   child: Image.network(
  //                     deal.office.image,
  //                     fit: BoxFit.contain,
  //                     width: 120,
  //                     height: 120,
  //                   ),
  //                 ),
  //                 Text(deal.office.name),
  //               ],
  //             ),
  //             SizedBox(
  //               width: 12,
  //             ),
  //             Expanded(
  //                 child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Text(
  //                     "${deal.property_outlook.name_en} - ${deal.property_area.name_en}",
  //                     style: Theme.of(context).textTheme.headline6),
  //                 (
  //                     child: Container(
  //                   decoration: BoxDecoration(
  //                       color: Colors.blue[50],
  //                       borderRadius: BorderRadius.circular(5)),
  //                   child: Align(
  //                     alignment: AlignmentDirectional.topStart,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Row(
  //                         children: [
  //                           Text("${deal.description}"),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )),
  //                 SizedBox(
  //                   height: 4,
  //                 ),
  //                 Row(
  //                   children: [
  //                     ElevatedButton(
  //                         onPressed: () async {
  //                           final link = WhatsAppUnilink(
  //                             phoneNumber: "+965 " + deal.dealer.phone,
  //
  //                             text:
  //                                 "I'm interested in deal you have posted on Saeb ",
  //                           );
  //                           await launch('$link');
  //                         },
  //                         child: Icon(Icons.phone_forwarded)),
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         await launch("tel://${deal.dealer.phone}");
  //                       },
  //                       child: Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Icon(Icons.phone, size: 16),
  //                           SizedBox(width: 4),
  //                           Text(deal.dealer.phone)
  //                         ],
  //                       ),
  //                     ),
  //                     if (isOwner)
  //                       ElevatedButton(
  //                           onPressed: relistPrompt,
  //                           style:
  //                               ElevatedButton.styleFrom(primary: Colors.red),
  //                           child: Icon(Icons.delete_forever_outlined)),
  //                     if (isOwner)
  //                       ElevatedButton(
  //                           onPressed: () {},
  //                           style:
  //                               ElevatedButton.styleFrom(primary: Colors.green),
  //                           child: Icon(Icons.loop)),
  //                     Expanded(
  //                         child: Text(
  //                       '${deal.dealer.name} - ${Moment.now().from(deal.created)}',
  //                       textAlign: TextAlign.end,
  //                     ))
  //                   ],
  //                 )
  //               ],
  //             ))
  //           ],
  //         )),
  //   );
  // }

  void relistPrompt() {
    showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              title: const Text("Attention"),
              content:
                  const Text("You are about to relist this deal, proceed?"),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await SaebAPI.relistDeal(deal.id);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: const Text("Relist")),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"))
              ],
            ));
  }
}
