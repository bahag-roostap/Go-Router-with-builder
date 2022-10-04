import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../corporate_design/bahag_icons.dart';
import '../corporate_design/color.dart';
import 'dart:math';

class BahagButtonPrimary extends BahagButton {
  const BahagButtonPrimary({
    required super.onPressed,
    required super.text,
    super.onLongPress,
    super.iconData,
    super.key,
  });
}

class BahagButtonSecondary extends BahagButton {
  const BahagButtonSecondary({
    required super.onPressed,
    required super.text,
    super.iconData,
    super.key,
    super.color = BahagColor.darkGrey,
  });
}

class BahagButton extends StatelessWidget {
  const BahagButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.onLongPress,
    this.iconData,
    this.iconSize,
    this.fontSize,
    this.color = BahagColor.bauhausRed,
    this.padding = const EdgeInsets.symmetric(horizontal: 17.0),
    this.minimumSize = const Size(56, 56),
  });
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String text;
  final IconData? iconData;
  final double? iconSize;
  final double? fontSize;
  final Color color;
  final EdgeInsets? padding;
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: padding,
      ),
      child: Row(
        children: [
          if (text.isNotEmpty)
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign:
                      iconData != null ? TextAlign.start : TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(fontSize: fontSize),
                ),
              ),
            ),
          if (iconData != null)
            Icon(
              iconData,
              size: iconSize ?? 27.0,
            ),
        ],
      ),
    );
  }
}

class BahagButtonAddToCart extends StatelessWidget {
  const BahagButtonAddToCart({
    super.key,
    required this.onPressed,
    required this.text,
    this.iconData,
    this.textAlign,
    this.color = BahagColor.bauhausRed,
  });

  final VoidCallback? onPressed;
  final TextAlign? textAlign;
  final String text;
  final IconData? iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(50, double.minPositive),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                text,
                maxLines: 1,
                maxFontSize: 20,
                minFontSize: 13,
                textAlign: textAlign,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.13,
                  fontWeight: FontWeight.bold,
                  color: BahagColor.nearlyWhite,
                ),
              ),
            ),
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(
                  iconData,
                  size: 24.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BahagQuantitySelector extends StatefulWidget {
  final int quantity;
  final void Function(int) quantityChanged;
  final String? unit;
  final FocusNode? focusNode;
  final bool withControllers;
  final int maxValue;
  late final int _numberOfDigits = maxValue.toString().length;

  BahagQuantitySelector({
    super.key,
    required this.quantity,
    required this.quantityChanged,
    this.unit,
    this.focusNode,
    this.withControllers = true,
    this.maxValue = 9999,
  });

  @override
  State<BahagQuantitySelector> createState() => _BahagQuantitySelectorState();
}

class _BahagQuantitySelectorState extends State<BahagQuantitySelector> {
  late final TextEditingController _quantityController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleUnfocus);

    _quantityController = TextEditingController();
    _quantityController.text = widget.quantity.toString();
    _quantityController.addListener(_textFieldChanged);
  }

  void _textFieldChanged() {
    final int newQuantity = _getNewQuantity(_quantityController.text);
    _changeQuantity(newQuantity);
  }

  void _changeQuantity(int newValue) {
    if (newValue < (_focusNode.hasFocus ? 0 : 1) ||
        newValue > widget.maxValue) {
      return;
    }

    if (widget.quantity != newValue) {
      widget.quantityChanged(newValue);
    }
  }

  int _getNewQuantity(String text) => int.tryParse(text) ?? 0;

  void _handleUnfocus() {
    if (_getNewQuantity(_quantityController.text) < 1 && !_focusNode.hasFocus) {
      _quantityController.text = '1';
    }
  }

  @override
  void didUpdateWidget(covariant BahagQuantitySelector oldWidget) {
    if (widget.quantity != _getNewQuantity(_quantityController.text)) {
      _quantityController.value = TextEditingValue(
        text: widget.quantity.toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.quantity.toString().length),
        ),
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _quantityController.removeListener(_textFieldChanged);
    _quantityController.dispose();

    _focusNode.removeListener(_handleUnfocus);

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countTheme = Theme.of(context).textTheme.headline3;
    final unitTheme =
        Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 13);

    return Row(
      children: [
        Container(
          height: 46,
          width: widget.withControllers
              ? (max(widget._numberOfDigits, 4) * 13) + 58
              : (max(widget._numberOfDigits, 4) * 13) + 2,
          decoration: BoxDecoration(
            border: Border.all(color: BahagColor.nearlyBlack, width: 1),
            borderRadius: BorderRadius.circular(widget.withControllers ? 0 : 5),
          ),
          child: IntrinsicWidth(
            child: TextField(
              focusNode: _focusNode,
              controller: _quantityController,
              textInputAction: TextInputAction.done,
              style: countTheme,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget._numberOfDigits),
              ],
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(),
                // Remove constraints
                suffixIconConstraints: const BoxConstraints(),
                // Remove constraints
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                suffixStyle: unitTheme,
                contentPadding: widget.withControllers
                    ? const EdgeInsets.only(top: 4)
                    : const EdgeInsets.only(bottom: 4),
                prefixIcon: widget.withControllers
                    ? _QuantityControlButton(
                        key: const Key('quantity_minus'),
                        icon: BahagIcons.minusProductDetail,
                        onPressed: () => _changeQuantity(
                            _getNewQuantity(_quantityController.text) - 1),
                      )
                    : null,
                suffixIcon: widget.withControllers
                    ? _QuantityControlButton(
                        key: const Key('quantity_plus'),
                        icon: BahagIcons.plusProductDetail,
                        onPressed: () => _changeQuantity(
                            _getNewQuantity(_quantityController.text) + 1),
                      )
                    : null,
              ),
              autocorrect: false,
            ),
          ),
        ),
        if (widget.unit != null && widget.unit!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.unit!),
          ),
      ],
    );
  }
}

class _QuantityControlButton extends StatelessWidget {
  final _iconSize = 16.0;
  final _iconAspectRatio = 0.7;
  final VoidCallback onPressed;
  final IconData icon;

  const _QuantityControlButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _iconAspectRatio,
      child: IconButton(
        key: key,
        iconSize: _iconSize,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        icon: Icon(icon),
        color: BahagColor.nearlyBlack,
      ),
    );
  }
}
