import 'package:flutter/material.dart';

class FabWithIcons extends StatefulWidget {
  final List<IconData> icons;
  final ValueChanged<int> onIconTapped;

  const FabWithIcons({
    super.key,
    required this.icons,
    required this.onIconTapped,
  });

  @override
  State<FabWithIcons> createState() => _FabWithIconsState();
}

class _FabWithIconsState extends State<FabWithIcons>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_controller.isDismissed) {
      _overlayController.show();
      _controller.forward();
    } else {
      _controller.reverse().whenComplete(_overlayController.hide);
    }
  }

  void _onTapped(int index) {
    _toggle();
    widget.onIconTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => Align(
          alignment: Alignment.topLeft,
          child: CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            offset: const Offset(0, -8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.icons.length, _buildChild),
            ),
          ),
        ),
        child: FloatingActionButton(
          onPressed: _toggle,
          tooltip: 'Opções',
          shape: const CircleBorder(),
          elevation: 2,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildChild(int index) {
    final backgroundColor = Theme.of(context).cardColor;
    final foregroundColor = Theme.of(context).colorScheme.secondary;
    return Container(
      height: 70,
      width: 56,
      alignment: FractionalOffset.topCenter,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0,
            1 - index / widget.icons.length / 2,
            curve: Curves.easeOut,
          ),
        ),
        child: FloatingActionButton(
          heroTag: 'fab_option_$index',
          backgroundColor: backgroundColor,
          mini: true,
          shape: const CircleBorder(),
          onPressed: () => _onTapped(index),
          child: Icon(widget.icons[index], color: foregroundColor),
        ),
      ),
    );
  }
}
