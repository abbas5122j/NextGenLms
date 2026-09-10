import 'package:flutter/material.dart';
import 'admin_theme.dart';

class AdminBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  const AdminBadge({super.key, required this.text, required this.color, this.icon});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(99)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[Icon(icon, size: 11, color: color), const SizedBox(width: 5)],
          Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: .7)),
        ]),
      );
}

class AdminPageHeader extends StatelessWidget {
  final bool dark;
  final String title;
  final String subtitle;
  final String? badge;
  final Color badgeColor;
  final Widget? trailing;
  const AdminPageHeader({super.key, required this.dark, required this.title, required this.subtitle, this.badge, this.badgeColor = AdminTheme.red, this.trailing});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (badge != null) ...[AdminBadge(text: badge!, color: badgeColor, icon: Icons.shield_outlined), const SizedBox(height: 11)],
          Text(title, style: AdminText.title(dark)),
          const SizedBox(height: 7),
          Text(subtitle, style: AdminText.body(dark)),
        ])),
        if (trailing != null) ...[const SizedBox(width: 20), trailing!],
      ]);
}

class AdminStatusPill extends StatelessWidget {
  final String text;
  final Color color;
  const AdminStatusPill({super.key, required this.text, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(99)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontSize: 9.5, fontWeight: FontWeight.w900)),
        ]),
      );
}

class AdminInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool dark;
  final Widget? suffix;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  const AdminInput({super.key, required this.label, this.hint = '', this.controller, required this.dark, this.suffix, this.maxLines = 1, this.onChanged});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: AdminText.label(dark)),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          style: TextStyle(color: AdminTheme.foreground(dark), fontSize: 12, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AdminTheme.lightMuted, fontSize: 12),
            filled: true,
            fillColor: dark ? const Color(0xFF0F1522) : const Color(0xFFF8F9FB),
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide(color: AdminTheme.outline(dark))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide(color: AdminTheme.outline(dark))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: AdminTheme.primary, width: 1.2)),
          ),
        ),
      ]);
}

class AdminActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;
  final bool outlined;
  const AdminActionButton({super.key, required this.label, this.onPressed, this.color = AdminTheme.primary, this.icon, this.outlined = false});
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 44,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon ?? Icons.check_rounded, size: 16),
          label: Text(label, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900)),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: outlined ? Colors.transparent : color,
            foregroundColor: outlined ? color : Colors.white,
            side: outlined ? BorderSide(color: color.withOpacity(.35)) : BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
}

class AdminFloatingSophia extends StatelessWidget {
  const AdminFloatingSophia({super.key});
  @override
  Widget build(BuildContext context) => Positioned(
        right: 20,
        bottom: 18,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AdminTheme.red, borderRadius: BorderRadius.circular(9)),
            child: const Text('Sophia', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 3),
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AdminTheme.purple,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: const [BoxShadow(color: Color(0x30000000), blurRadius: 14, offset: Offset(0, 5))],
            ),
            child: const Center(child: Text('🤖', style: TextStyle(fontSize: 27))),
          ),
        ]),
      );
}
