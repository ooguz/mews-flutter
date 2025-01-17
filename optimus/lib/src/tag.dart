import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Tags are used to highlight an item’s status or make it easier to recognize
/// certain items in data-dense content.
/// For system-specific feedback with semantic significance use OptimusTag.
/// For data-dense content, where representation isn't carrying semantic
/// significance use OptimusCategoricalTag.
///
/// Be wary of using multiple tags on one item, as it could cause visual noise.
/// Non-interactive tags are used to highlight an item’s status or make it
/// easier to recognize certain items in data-dense content. You can use tags
/// in tables, forms, and cards.
class OptimusTag extends StatelessWidget {
  const OptimusTag({
    super.key,
    required this.text,
    this.colorOption = OptimusColorOption.basic,
    this.leadingIcon,
    this.trailingIcon,
    this.outline = false,
  });

  /// The text to display in the tag.
  final String text;

  /// Controls color of the tag. Use-cases:
  /// - [OptimusColorOption.basic] – highlight general status or state of item;
  /// - [OptimusColorOption.plain] - highlight general status or state of item;
  /// - [OptimusColorOption.primary] – highlight primary item, in progress, or
  ///   current item;
  /// - [OptimusColorOption.success] – highlight success state of item;
  /// - [OptimusColorOption.info] - highlighting informational/helpful item;
  /// - [OptimusColorOption.warning] – highlight item that requires attention.
  /// - [OptimusColorOption.danger] – highlight problematic or error item;
  final OptimusColorOption colorOption;

  /// Whether the tag should use the outlined style.
  final bool outline;

  /// Optional leading icon of the tag.
  final IconData? leadingIcon;

  /// Optional trailing icon of the tag.
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;

    return _Tag(
      text: text,
      backgroundColor: colorOption.backgroundColor(tokens),
      foregroundColor: colorOption.foregroundColor(tokens),
      borderColor: colorOption.borderColor(tokens),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      outline: outline,
    );
  }
}

/// Color options are designed so they won't carry any semantic meaning. Could
/// be used in any case when displaying categorical data.
///
/// [OptimusCategoricalColorOption.denim] - Denim Blue
/// [OptimusCategoricalColorOption.lavender] - Lavender Purple
/// [OptimusCategoricalColorOption.lime] - Lime Green
/// [OptimusCategoricalColorOption.mustard] - Mustard Yellow
/// [OptimusCategoricalColorOption.ruby] - Ruby Red
/// [OptimusCategoricalColorOption.tangerine] - Tangerine Orange
enum OptimusCategoricalColorOption {
  denim,
  lavender,
  lime,
  mustard,
  ruby,
  tangerine
}

/// Tags that are meant to help arrange information into distinct categories.
/// Color option does not carry any semantic meaning. Color could be swapped
/// without causing any effect on the tag's meaning.
class OptimusCategoricalTag extends StatelessWidget {
  const OptimusCategoricalTag({
    super.key,
    required this.text,
    required this.colorOption,
    this.leadingIcon,
    this.trailingIcon,
    this.outline = false,
  });

  /// Text of the tag.
  final String text;

  /// Categorical color option.
  final OptimusCategoricalColorOption colorOption;

  /// Optional leading icon.
  final IconData? leadingIcon;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Whether to use outlined tag style.
  final bool outline;

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;

    return _Tag(
      text: text,
      backgroundColor: colorOption.backgroundColor(tokens),
      foregroundColor: colorOption.foregroundColor(tokens),
      borderColor: colorOption.borderColor(tokens),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      outline: outline,
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.leadingIcon,
    this.trailingIcon,
    this.outline = false,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool outline;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: outline ? null : backgroundColor,
          border: outline
              ? Border.all(
                  color: borderColor,
                  width: 1.5,
                  style: BorderStyle.solid,
                )
              : null,
          borderRadius: const BorderRadius.all(borderRadius50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: spacing100),
        height: 24,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: spacing50),
                child: Icon(leadingIcon, color: foregroundColor, size: 16),
              ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text(
                text,
                style: preset200r.copyWith(color: foregroundColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: spacing50),
                child: Icon(trailingIcon, color: foregroundColor, size: 16),
              ),
          ],
        ),
      );
}

extension on OptimusColorOption {
  Color backgroundColor(OptimusTokens tokens) => switch (this) {
        OptimusColorOption.basic => tokens.legacySupportTagBackgroundBasicBold,
        OptimusColorOption.plain => tokens.backgroundAlertBasicSecondary,
        OptimusColorOption.primary => tokens.legacySupportTagBackgroundPrimary,
        OptimusColorOption.success => tokens.backgroundAlertSuccessSecondary,
        OptimusColorOption.info => tokens.backgroundAlertInfoSecondary,
        OptimusColorOption.warning => tokens.backgroundAlertWarningSecondary,
        OptimusColorOption.danger => tokens.backgroundAlertDangerSecondary,
      };

  Color borderColor(OptimusTokens tokens) => switch (this) {
        OptimusColorOption.basic => tokens.legacySupportTagBorderBasicBold,
        OptimusColorOption.plain => tokens.borderAlertBasic,
        OptimusColorOption.primary => tokens.legacySupportTagBorderPrimary,
        OptimusColorOption.success => tokens.borderAlertSuccess,
        OptimusColorOption.info => tokens.borderAlertInfo,
        OptimusColorOption.warning => tokens.borderAlertWarning,
        OptimusColorOption.danger => tokens.borderAlertDanger,
      };

  Color foregroundColor(OptimusTokens tokens) => switch (this) {
        OptimusColorOption.primary => tokens.legacySupportTagTextPrimary,
        OptimusColorOption.success => tokens.textAlertSuccess,
        OptimusColorOption.info => tokens.textAlertInfo,
        OptimusColorOption.danger => tokens.textAlertDanger,
        OptimusColorOption.basic => tokens.legacySupportTagTextBasicBold,
        OptimusColorOption.plain => tokens.textAlertBasic,
        OptimusColorOption.warning => tokens.textAlertWarning,
      };
}

extension on OptimusCategoricalColorOption {
  Color borderColor(OptimusTokens tokens) => switch (this) {
        OptimusCategoricalColorOption.denim =>
          tokens.legacySupportTagBorderDenim,
        OptimusCategoricalColorOption.lavender =>
          tokens.legacySupportTagBorderLavender,
        OptimusCategoricalColorOption.lime => tokens.legacySupportTagBorderLime,
        OptimusCategoricalColorOption.mustard =>
          tokens.legacySupportTagBorderMustard,
        OptimusCategoricalColorOption.ruby => tokens.legacySupportTagBorderRuby,
        OptimusCategoricalColorOption.tangerine =>
          tokens.legacySupportTagBorderTangerine,
      };

  Color backgroundColor(OptimusTokens tokens) => switch (this) {
        OptimusCategoricalColorOption.denim =>
          tokens.legacySupportTagBackgroundDenim,
        OptimusCategoricalColorOption.lavender =>
          tokens.legacySupportTagBackgroundLavender,
        OptimusCategoricalColorOption.lime =>
          tokens.legacySupportTagBackgroundLime,
        OptimusCategoricalColorOption.mustard =>
          tokens.legacySupportTagBackgroundMustard,
        OptimusCategoricalColorOption.ruby =>
          tokens.legacySupportTagBackgroundRuby,
        OptimusCategoricalColorOption.tangerine =>
          tokens.legacySupportTagBackgroundTangerine,
      };

  Color foregroundColor(OptimusTokens tokens) => switch (this) {
        OptimusCategoricalColorOption.denim => tokens.legacySupportTagTextDenim,
        OptimusCategoricalColorOption.lavender =>
          tokens.legacySupportTagTextLavender,
        OptimusCategoricalColorOption.lime => tokens.legacySupportTagTextLime,
        OptimusCategoricalColorOption.ruby => tokens.legacySupportTagTextRuby,
        OptimusCategoricalColorOption.mustard =>
          tokens.legacySupportTagTextMustard,
        OptimusCategoricalColorOption.tangerine =>
          tokens.legacySupportTagTextTangerine,
      };
}
