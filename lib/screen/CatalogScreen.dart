import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

import '../Item.dart';
import '../manager/CartManager.dart';
import '../manager/CatalogManager.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index > 14) return null;
              return _MyListItem(index);
            }),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.use<CartManager>();

    return Observer<List<Item>>(
      stream: cart.items,
      builder: (BuildContext context, items) {
        return FlatButton(
          onPressed: () => cart.add(item),
          child: items.contains(item)
              ? Icon(Icons.check, semanticLabel: 'ADDED')
              : Text('ADD'),
        );
      },
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.use<CartManager>();

    return SliverAppBar(
      title: Text('Catalog'),
      floating: true,
      actions: [
        Observer(
            stream: cart.items,
            builder: (context, data) => Chip(
                  label: Text(
                    data.length.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  backgroundColor: Colors.grey,
                )),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var manager = context.use<CatalogManager>();
    var item = Item(index, manager.names[index]);

    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(aspectRatio: 1, child: Container(color: item.color)),
            SizedBox(width: 24),
            Expanded(child: Text(item.name, style: textTheme)),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
