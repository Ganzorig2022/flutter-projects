import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashapp/components/loading_widget.dart';
import 'package:cashapp/model/reference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({Key? key, required this.items, this.label, this.selectedValue}) : super(key: key);
  final List<Reference?> items;
  final String? label;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.clear)),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        label?.capitalizeFirst ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 0.24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(onPressed: () => null, icon: Icon(Icons.clear), color: Colors.transparent),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              controller: ModalScrollController.of(context),
              children: ListTile.divideTiles(
                context: context,
                tiles: items.map(
                  (item) => ListTile(
                    dense: false,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    leading: (item?.img?.isNotEmpty ?? false)
                        ? CachedNetworkImage(
                            imageUrl: item!.img!,
                            height: 36,
                            width: 36,
                            placeholder: (c, v) => LoadingWidget(),
                            fit: BoxFit.cover,
                          )
                        : null,
                    title: Text(
                      item?.name?.capitalizeFirst ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    trailing: item?.id == selectedValue
                        ? const Icon(
                            Icons.check_circle,
                            color: const Color(0xFF4CA92E),
                          )
                        : const SizedBox.shrink(),
                    onTap: () {
                      Navigator.of(context).pop(item?.id);
                    },
                  ),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
