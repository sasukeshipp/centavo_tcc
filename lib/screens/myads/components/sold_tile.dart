import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:centavo_tcc/helpers/extensions.dart';
import 'package:centavo_tcc/models/ad.dart';
import 'package:centavo_tcc/stores/myads_store.dart';

class SoldTile extends StatelessWidget {
  SoldTile(this.ad, this.store);

  final Ad ad;
  final MyAdsStore store;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Container(
        height: 80,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: ad.images.isEmpty
                    ? 'https://static.thenounproject.com/png/194055-200.png'
                    : ad.images.first,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 20,
                  color: Colors.amberAccent,
                  onPressed: () {
                    store.deleteAd(ad);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
