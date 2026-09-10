
import 'package:flutter/material.dart';

/// Next Gen LMS — Student Announcement Section.
///
/// Content-only screen. The global sidebar and top bar remain owned by
/// StudentLmsShell / StudentHomeHubScreen.
class AnnouncementScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const AnnouncementScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  String _search = '';
  AnnouncementItem? _selected;

  static const List<AnnouncementItem> _announcements = [
    AnnouncementItem(
      id: 'hackathon-2026',
      type: 'EVENT',
      title: 'Official Campus Hackathon 2026 & Innovation Challenge',
      date: 'July 24, 2026',
      issuer: 'College Dean & Academic Office',
      audience: 'All',
      pinned: true,
      description:
          'Team up across branches to build real-world AI & Full-Stack solutions. Cash prizes of up to \$10,000, cloud infrastructure credits, and direct placement interview passes to be awarded. All students and instructors are invited to register.',
    ),
    AnnouncementItem(
      id: 'midterm-rules',
      type: 'ACADEMIC',
      title: 'Mid-Term Examination Schedule & Proctoring Rules',
      date: 'July 20, 2026',
      issuer: 'Examination Controller - MIT Campus',
      audience: 'All',
      pinned: true,
      description:
          'Mid-term examination gates open next Monday. Please ensure webcam feed permissions and single-browser tabs during Sophia AI assessment sessions. Instructors must submit question banks by Friday 5:00 PM.',
    ),
    AnnouncementItem(
      id: 'gpu-maintenance',
      type: 'SYSTEM',
      title: 'Campus High-Speed GPU Server Maintenance Notice',
      date: 'July 16, 2026',
      issuer: 'IT Infrastructure & Cloud Ops',
      audience: 'Students',
      pinned: false,
      description:
          'The institutional AI model training GPU clusters will undergo scheduled maintenance this Sunday between 2:00 AM and 5:00 AM IST. Compiler sandboxes will run in offline lightweight mode.',
    ),
    AnnouncementItem(
      id: 'placement-drive',
      type: 'PLACEMENT',
      title: 'Placement Drive: Google & Microsoft On-Campus Interviews',
      date: 'July 12, 2026',
      issuer: 'Training & Placement Cell (T&P)',
      audience: 'Students',
      pinned: false,
      description:
          'Shortlisted candidates from Computer Science and IT with Level 03+ milestone verifications must submit updated resumes before the portal deadline.',
    ),
  ];

  List<AnnouncementItem> get _filtered {
    final q = _search.trim().toLowerCase();
    if (q.isEmpty) return _announcements;
    return _announcements.where((item) {
      return item.title.toLowerCase().contains(q) ||
          item.type.toLowerCase().contains(q) ||
          item.issuer.toLowerCase().contains(q) ||
          item.description.toLowerCase().contains(q);
    }).toList();
  }

  Color get _text =>
      widget.isDarkMode ? Colors.white : const Color(0xFF101522);
  Color get _muted =>
      widget.isDarkMode ? const Color(0xFF9299A9) : const Color(0xFF687287);
  Color get _surface =>
      widget.isDarkMode ? const Color(0xFF1B1E27) : Colors.white;
  Color get _border =>
      widget.isDarkMode ? const Color(0xFF2A303C) : const Color(0xFFE4E8F0);
  Color get _page =>
      widget.isDarkMode ? const Color(0xFF10131A) : const Color(0xFFF4F6FB);

  @override
  Widget build(BuildContext context) {
    if (_selected != null) return _detailPage(_selected!);
    return _listPage();
  }

  Widget _listPage() {
    return Container(
      color: _page,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(38, 36, 38, 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'OFFICIAL INSTITUTIONAL NOTICES',
                        style: TextStyle(
                          color: Color(0xFFFF6D25),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Campus Announcements & Directives',
                        style: TextStyle(
                          color: _text,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -.6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Direct notices published by College Administration and Department Deans.',
                        style: TextStyle(color: _muted, fontSize: 13.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 22),
                _searchBox(),
                const SizedBox(width: 16),
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? const Color(0xFF1B202A)
                        : const Color(0xFFF0F2F7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    '${_announcements.length} Active Directives',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Divider(height: 1, color: _border),
            const SizedBox(height: 26),
            if (_filtered.isEmpty)
              _empty()
            else
              ..._filtered.map(_announcementCard),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return SizedBox(
      width: 320,
      height: 42,
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        style: TextStyle(color: _text, fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Search announcements...',
          hintStyle: TextStyle(color: _muted, fontSize: 12),
          prefixIcon: Icon(Icons.search_rounded, color: _muted, size: 17),
          filled: true,
          fillColor: _surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: _border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: _border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFFF762C)),
          ),
        ),
      ),
    );
  }

  Widget _announcementCard(AnnouncementItem item) {
    final highlighted = item.pinned;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: highlighted
              ? const Color(0xFFFFB21A)
              : _border,
          width: highlighted ? 1.1 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              widget.isDarkMode ? .10 : .035,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          onTap: () => setState(() => _selected = item),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _typeBadge(item.type),
                    if (item.pinned) ...[
                      const SizedBox(width: 8),
                      _smallBadge(
                        '⚑  Pinned Notice',
                        const Color(0xFFFFF3E4),
                        const Color(0xFFE97900),
                      ),
                    ],
                    const SizedBox(width: 8),
                    _smallBadge(
                      'Target: ${item.audience}',
                      widget.isDarkMode
                          ? const Color(0xFF202530)
                          : const Color(0xFFF2F4F8),
                      _muted,
                    ),
                    const Spacer(),
                    Text(
                      item.date,
                      style: TextStyle(
                        color: _muted,
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _emoji(item.type),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: _text,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  item.description,
                  style: TextStyle(
                    color: _muted,
                    fontSize: 12.5,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),
                Divider(height: 1, color: _border),
                const SizedBox(height: 11),
                Row(
                  children: [
                    const Icon(
                      Icons.school_outlined,
                      size: 14,
                      color: Color(0xFFFF6D25),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        item.issuer,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _muted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Text(
                      'Read Full Directive →',
                      style: TextStyle(
                        color: Color(0xFFFF5D18),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailPage(AnnouncementItem item) {
    return Container(
      color: _page,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(38, 38, 38, 60),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: Container(
              padding: const EdgeInsets.fromLTRB(38, 34, 38, 34),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: _border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      widget.isDarkMode ? .12 : .07,
                    ),
                    blurRadius: 25,
                    offset: const Offset(0, 13),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => setState(() => _selected = null),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFFFF6D25),
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'BACK TO ANNOUNCEMENTS',
                          style: TextStyle(
                            color: Color(0xFFFF6D25),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    spacing: 8,
                    runSpacing: 7,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _typeBadge(item.type),
                      if (item.pinned)
                        _smallBadge(
                          '⚑  Pinned Notice',
                          const Color(0xFFFFF3E4),
                          const Color(0xFFE97900),
                        ),
                      Text(
                        '•  ${item.date}',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${_emoji(item.type)}  ${item.title}',
                    style: TextStyle(
                      color: _text,
                      fontSize: 25,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        color: Color(0xFFFF6D25),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Issued by: ${item.issuer}',
                          style: TextStyle(
                            color: _text,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '|  Audience: ${item.audience}',
                        style: TextStyle(color: _muted, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(height: 1, color: _border),
                  const SizedBox(height: 27),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(23, 22, 23, 22),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? const Color(0xFF171B23)
                          : const Color(0xFFF8F9FB),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: _border),
                    ),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        color: _text,
                        fontSize: 14,
                        height: 1.65,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _selected = null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF762C),
                          foregroundColor: Colors.white,
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: const Text(
                          'Close Notice',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeBadge(String type) {
    final c = _typeColor(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withOpacity(.10),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: c,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _smallBadge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'ACADEMIC':
        return const Color(0xFF3385E8);
      case 'SYSTEM':
        return const Color(0xFFFF762C);
      case 'PLACEMENT':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFFFF3D8A);
    }
  }

  String _emoji(String type) {
    switch (type) {
      case 'ACADEMIC':
        return '🎓';
      case 'SYSTEM':
        return '⚡';
      case 'PLACEMENT':
        return '💼';
      default:
        return '📢';
    }
  }

  Widget _empty() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 25),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Icon(Icons.campaign_outlined, size: 40, color: _muted),
          const SizedBox(height: 14),
          Text(
            'No Announcements Found',
            style: TextStyle(
              color: _text,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another search term.',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class AnnouncementItem {
  final String id;
  final String type;
  final String title;
  final String date;
  final String issuer;
  final String audience;
  final bool pinned;
  final String description;

  const AnnouncementItem({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.issuer,
    required this.audience,
    required this.pinned,
    required this.description,
  });
}
