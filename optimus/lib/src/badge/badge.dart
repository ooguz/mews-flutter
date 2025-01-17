import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/badge/base_badge.dart';

/// Badges are meant to give a subtle feedback about some state change.
/// Typically used with buttons, tabs and icons.
class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    super.key,
    this.text = '',
    this.outline = true,
    this.overflow = TextOverflow.ellipsis,
  });

  /// Text of the badge. If empty, badge will be represented as a simple dot.
  final String text;

  /// Whether to use the outline. Intended to be enabled when the badge is used
  /// for example on top of the [OptimusButtonVariant.ghost]. Outlined version
  /// could be more accessible, depending on the underlying component.
  final bool outline;

  /// Define how to display the overflowing text. Defaults to
  /// [TextOverflow.ellipsis]. Due to small height of the badge, the
  /// [TextOverflow.fade] is not recommended, as it makes the badge unreadable.
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) => BaseBadge(text: text, outline: outline);
}
