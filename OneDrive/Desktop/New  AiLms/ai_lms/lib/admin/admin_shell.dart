import 'package:flutter/material.dart';
import 'admin_theme.dart';
import 'admin_widgets.dart';

enum AdminSection { analytics, tenants, infra, cms, portalCodes }

class AdminShell extends StatelessWidget {
  final AdminSection activeSection;
  final String userName;
  final bool isDarkMode;
  final ValueChanged<AdminSection> onSectionSelected;
  final VoidCallback onToggleDarkMode;
  final VoidCallback? onSignOut;
  final Widget child;
  final bool sidebarCollapsed;
  final VoidCallback? onToggleSidebar;

  const AdminShell({
    super.key,
    required this.activeSection,
    required this.userName,
    required this.isDarkMode,
    required this.onSectionSelected,
    required this.onToggleDarkMode,
    required this.child,
    this.onSignOut,
    this.sidebarCollapsed = false,
    this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 760;
    final collapsed = mobile || sidebarCollapsed;
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: AdminTheme.background(isDarkMode),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AdminTheme.primary,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
      child: Scaffold(
        backgroundColor: AdminTheme.background(isDarkMode),
        body: Row(
          children: [
            if (!mobile)
              _Sidebar(
                active: activeSection,
                dark: isDarkMode,
                collapsed: collapsed,
                onSelected: onSectionSelected,
                onSignOut: onSignOut,
                onToggle: onToggleSidebar,
              ),
            Expanded(
              child: Column(
                children: [
                  _TopBar(
                    userName: userName,
                    dark: isDarkMode,
                    collapsed: collapsed,
                    onToggleDark: onToggleDarkMode,
                    onToggleSidebar: mobile ? onToggleSidebar : null,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 460),
                            reverseDuration: const Duration(milliseconds: 360),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            layoutBuilder: (currentChild, previousChildren) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                                child: ClipRect(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: animation.value,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: child,
                          ),
                        ),
                        const AdminFloatingSophia(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final AdminSection active;
  final bool dark;
  final bool collapsed;
  final ValueChanged<AdminSection> onSelected;
  final VoidCallback? onSignOut;
  final VoidCallback? onToggle;

  const _Sidebar({
    required this.active,
    required this.dark,
    required this.collapsed,
    required this.onSelected,
    required this.onSignOut,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final items = <(AdminSection, String, IconData)>[
      (AdminSection.analytics, 'Global Analytics', Icons.monitor_heart_outlined),
      (AdminSection.tenants, 'Tenant & Client Hub', Icons.apartment_outlined),
      (AdminSection.infra, 'Infra & Compiler', Icons.tune_outlined),
      (AdminSection.cms, 'Master CMS Bank', Icons.menu_book_outlined),
      (AdminSection.portalCodes, 'Portal Code Gen', Icons.key_outlined),
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: collapsed ? 82 : 268,
      color: AdminTheme.card(dark),
      child: Column(
        children: [
          Container(
            height: 85,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AdminTheme.outline(dark))),
            ),
            padding: EdgeInsets.symmetric(horizontal: collapsed ? 16 : 17),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AdminTheme.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'N',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                if (!collapsed) ...[
                  const SizedBox(width: 10),
                  const Expanded(child: _LogoText()),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: onToggle,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: AdminTheme.outline(dark)),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 18,
                        color: AdminTheme.secondary(dark),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [for (final item in items) _item(item.$1, item.$2, item.$3)],
            ),
          ),
          Container(height: 1, color: AdminTheme.outline(dark)),
          _bottom(Icons.person_outline, 'My Profile', () {}),
          _bottom(Icons.settings_outlined, 'Settings', () {}),
          _bottom(Icons.logout_rounded, 'Sign Out', onSignOut, color: AdminTheme.red),
          const SizedBox(height: 9),
        ],
      ),
    );
  }

  Widget _item(AdminSection section, String label, IconData icon) {
    final selected = section == active;
    final inactive = AdminTheme.secondary(dark);
    return SizedBox(
      height: 54,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelected(section),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 3,
                height: 45,
                color: selected ? AdminTheme.blue : Colors.transparent,
              ),
              Expanded(
                child: Container(
                  color: selected
                      ? (dark ? const Color(0xFF1B2230) : const Color(0xFFFAFBFD))
                      : Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: collapsed ? 0 : 25),
                  child: Row(
                    mainAxisAlignment: collapsed
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: selected ? AdminTheme.red : inactive,
                      ),
                      if (!collapsed) ...[
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(
                              color: selected ? AdminTheme.red : inactive,
                              fontSize: 13.5,
                              fontWeight: selected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottom(IconData icon, String label, VoidCallback? onTap, {Color? color}) {
    final c = color ?? AdminTheme.secondary(dark);
    return SizedBox(
      height: 48,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: 62, child: Icon(icon, size: 21, color: c)),
            if (!collapsed)
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: c,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LogoText extends StatelessWidget {
  const _LogoText();
  @override
  Widget build(BuildContext context) => const Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
          children: [
            TextSpan(text: 'Next Gen ', style: TextStyle(color: AdminTheme.green)),
            TextSpan(text: 'LMS', style: TextStyle(color: AdminTheme.red)),
          ],
        ),
      );
}

class _TopBar extends StatelessWidget {
  final String userName;
  final bool dark;
  final bool collapsed;
  final VoidCallback onToggleDark;
  final VoidCallback? onToggleSidebar;

  const _TopBar({
    required this.userName,
    required this.dark,
    required this.collapsed,
    required this.onToggleDark,
    required this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    final surface = AdminTheme.card(dark);
    final secondary = AdminTheme.secondary(dark);
    final field = dark ? const Color(0xFF151C2B) : const Color(0xFFF7F8FB);

    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      decoration: BoxDecoration(
        color: surface,
        border: Border(bottom: BorderSide(color: AdminTheme.outline(dark))),
      ),
      child: Row(
        children: [
          if (onToggleSidebar != null)
            IconButton(
              onPressed: onToggleSidebar,
              icon: Icon(Icons.menu_rounded, color: secondary),
            ),
          if (onToggleSidebar != null) const SizedBox(width: 5),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: TextField(
                  style: TextStyle(color: AdminTheme.foreground(dark)),
                  decoration: InputDecoration(
                    hintText: 'Search courses, projects, concepts...',
                    hintStyle: TextStyle(color: secondary, fontSize: 15),
                    prefixIcon: Icon(Icons.search_rounded, color: secondary),
                    filled: true,
                    fillColor: field,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: onToggleDark,
            style: IconButton.styleFrom(
              backgroundColor: field,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: Icon(
              dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: secondary,
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: field,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(Icons.notifications_none_rounded, color: secondary),
              ),
              Positioned(
                right: 9,
                top: 8,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8895),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          const CircleAvatar(
            radius: 21,
            backgroundColor: AdminTheme.red,
            child: Text(
              'AB',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
          if (!collapsed) ...[
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isEmpty ? 'Platform Admin' : userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AdminTheme.foreground(dark),
                  ),
                ),
                const Text(
                  'System Admin',
                  style: TextStyle(
                    fontSize: 10,
                    color: AdminTheme.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: secondary),
          ],
        ],
      ),
    );
  }
}
