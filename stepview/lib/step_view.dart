import 'package:flutter/material.dart';
import 'package:stepview/tools/list.dart';

class StepView extends StatelessWidget {
  final List<StepData> steps;
  final int currentStep;
  final IconData stepIcon;
  final double? stepIconsSize;
  final Color stepIconColor;
  final TextStyle? titleTextStyle;
  final double lineWidth;
  final double lineHeight;
  final Color disabledLineColor;
  final Color enabledLineColor;
  final bool animate;
  final Function? onSelectedStep;
  final IconData? passedIcon;
  final Color? passedIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...steps.mapIndexed((e, index) {
          return Row(
            children: [
              StepItem(
                stepData: passedIcon != null && currentStep >= index + 2
                    ? e.copyWith(icon: passedIcon, iconColor: passedIconColor ?? stepIconColor)
                    : e,
                stepIcon: stepIcon,
                stepIconsSize: stepIconsSize,
                stepIconColor: stepIconColor,
                onSelectedStep: () {
                  onSelectedStep?.call(index + 1);
                },
                isCurrent: currentStep >= index + 1,
                isSelected: index + 1 == currentStep,
                animate: animate,
              ),
              Container(
                decoration: BoxDecoration(
                  color: currentStep < (index) + 2 ? disabledLineColor : enabledLineColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                width: index != steps.length - 1 ? lineWidth : 0,
                height: lineHeight,
              ),
            ],
          );
        }),
      ],
    );
  }

  const StepView({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.lineWidth,
    required this.lineHeight,
    required this.stepIcon,
    required this.stepIconColor,
    this.titleTextStyle,
    this.passedIcon,
    this.animate = true,
    this.onSelectedStep,
    this.stepIconsSize = 24,
    this.disabledLineColor = Colors.black12,
    this.enabledLineColor = Colors.blue,
    this.passedIconColor,
  });
}

class StepItem extends StatefulWidget {
  final StepData stepData;
  final IconData stepIcon;
  final double? stepIconsSize;
  final Color stepIconColor;
  final Function? onSelectedStep;
  final bool isCurrent;
  final bool animate;
  final bool isSelected;

  @override
  State<StepItem> createState() => _StepItemState();

  const StepItem({
    super.key,
    required this.stepIcon,
    required this.isCurrent,
    required this.stepData,
    required this.isSelected,
    this.stepIconsSize,
    required this.animate,
    required this.stepIconColor,
    this.onSelectedStep,
  });
}

class _StepItemState extends State<StepItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.white,
      duration: const Duration(milliseconds: 350),
      height: widget.animate
          ? widget.isSelected
              ? (widget.stepIconsSize ?? 24) + 18
              : (widget.stepIconsSize ?? 24)
          : widget.stepIconsSize ?? 24,
      width: widget.animate
          ? widget.isSelected
              ? (widget.stepIconsSize ?? 24) + 18
              : (widget.stepIconsSize ?? 24)
          : widget.stepIconsSize ?? 24,
      child: InkWell(
        child: Icon(
          widget.isSelected != true
              ? widget.stepData.icon ?? widget.stepIcon
              : widget.stepData.selectedIcon ?? widget.stepData.icon ?? widget.stepIcon,
          size: widget.animate
              ? widget.isSelected
                  ? (widget.stepIconsSize ?? 24) + 18
                  : (widget.stepIconsSize ?? 24)
              : widget.stepIconsSize ?? 24,
          color: widget.isSelected != true
              ? widget.isCurrent
                  ? widget.stepData.iconColor ?? widget.stepIconColor
                  : Colors.black12
              : widget.stepData.selectedIconColor ??
                  widget.stepData.iconColor ??
                  widget.stepIconColor,
        ),
        onTap: () {
          widget.onSelectedStep?.call();
        },
      ),
    );
  }
}

class StepData {
  IconData? icon;
  IconData? selectedIcon;
  Color? selectedIconColor;
  Color? iconColor;

  StepData({
    this.icon,
    this.iconColor,
    this.selectedIcon,
    this.selectedIconColor,
  });

  StepData copyWith({
    IconData? icon,
    IconData? selectedIcon,
    Color? selectedIconColor,
    Color? iconColor,
  }) {
    return StepData(
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}
