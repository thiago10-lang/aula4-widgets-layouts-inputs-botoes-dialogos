import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  final IconData iconData;
  final String text;

  const FABBottomAppBarItem({required this.iconData, required this.text});
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  const FABBottomAppBar({
    super.key,
    required this.items,
    required this.onTabSelected,
    this.centerItemText = '',
    this.height = 60,
    this.iconSize = 24,
    this.backgroundColor,
    this.color = Colors.grey,
    this.selectedColor = Colors.red,
    this.notchedShape = const CircularNotchedRectangle(),
  }) : assert(items.length == 2 || items.length == 4);

  @override
  State<FABBottomAppBar> createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final items = List<Widget>.generate(
      widget.items.length,
      (index) => _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      ),
    );
    items.insert(items.length ~/ 2, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      height: widget.height,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: widget.iconSize),
            Text(widget.centerItemText, style: TextStyle(color: widget.color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    final color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(item.text, style: TextStyle(color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
