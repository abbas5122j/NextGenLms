import 'package:flutter/material.dart';
import '../admin_api_client.dart';
import '../admin_theme.dart';
import '../admin_widgets.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  final AdminApiClient? api;
  final bool dark;
  const AdminAnalyticsScreen({super.key, this.api, required this.dark});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(44, 38, 44, 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1420),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminPageHeader(
                dark: dark,
                badge: 'SUPER ADMIN CONTROL NODE',
                title: 'SaaS Global Mainframe Management',
                subtitle: 'Configure multi-tenant limits, allocate compiler limits, input API keys, and publish master curriculum libraries.',
                trailing: const AdminStatusPill(
                  text: 'GLOBAL STATUS: ACTIVE (99.982% UPTIME)',
                  color: AdminTheme.green,
                ),
              ),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (_, c) => GridView.count(
                  crossAxisCount: c.maxWidth >= 1180 ? 4 : c.maxWidth >= 760 ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.35,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _Metric(icon: Icons.apartment_outlined, iconBg: Color(0xFFEDE6FF), iconColor: AdminTheme.purple, label: 'ACTIVE INSTITUTIONS', value: '4 Universities', note: '↑ 1 New This Month', noteColor: AdminTheme.green),
                    _Metric(icon: Icons.groups_2_outlined, iconBg: Color(0xFFDDF9EC), iconColor: AdminTheme.green, label: 'GLOBAL ACTIVE STUDENTS', value: '4,470 / 7,500', note: 'Quota utilization 71%', noteColor: AdminTheme.secondary(dark)),
                    _Metric(icon: Icons.trending_up_rounded, iconBg: Color(0xFFE4EEFF), iconColor: AdminTheme.blue, label: 'MONTHLY PLATFORM MRR', value: '\$64,500 USD', note: '↑ 12.4% MoM growth', noteColor: AdminTheme.green),
                    _Metric(icon: Icons.auto_awesome_outlined, iconBg: Color(0xFFFFF0C8), iconColor: AdminTheme.yellow, label: 'GLOBAL AI TOKEN USAGE', value: '1,452,192', note: 'Sophia + Auto-Tutor runs', noteColor: AdminTheme.secondary(dark)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (_, c) => c.maxWidth < 900
                    ? Column(children: const [_ThreatMonitor(), SizedBox(height: 20), _UsageTrends()])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(flex: 4, child: _ThreatMonitor()),
                          SizedBox(width: 24),
                          Expanded(flex: 9, child: _UsageTrends()),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label, value, note;
  final Color noteColor;
  const _Metric({required this.icon, required this.iconBg, required this.iconColor, required this.label, required this.value, required this.note, required this.noteColor});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AdminTheme.cardDecoration(dark, radius: 18),
      child: Row(
        children: [
          Container(width: 53, height: 53, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: iconColor, size: 25)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: .5)),
                const SizedBox(height: 4),
                FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(color: AdminTheme.foreground(dark), fontSize: 24, fontWeight: FontWeight.w900))),
                const SizedBox(height: 3),
                Text(note, style: TextStyle(color: noteColor, fontSize: 10, fontWeight: noteColor == AdminTheme.green ? FontWeight.w800 : FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThreatMonitor extends StatelessWidget {
  const _ThreatMonitor();
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 27, 28, 28),
      decoration: AdminTheme.cardDecoration(dark, radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Icon(Icons.monitor_heart_outlined, color: AdminTheme.purple, size: 22), const SizedBox(width: 10), Text('Live Platform Threat Monitor', style: AdminText.section(dark))]),
          const SizedBox(height: 5),
          Text('Global anomalous action scanning from proctor networks.', style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11)),
          const SizedBox(height: 25),
          _monitorRow('Active Anti-Cheat Violations', 'None (Healthy)', AdminTheme.green, dark),
          _monitorRow('Host Network Sync Latency', '18 ms', AdminTheme.purple, dark),
          _monitorRow('Google Meet API Sign-ins', 'Online', AdminTheme.green, dark),
          _monitorRow('Isolated Compiler Nodes', '4 / 4 Healthy', AdminTheme.green, dark),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: dark ? const Color(0xFF2A171B) : const Color(0xFFFFF4F3),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: dark ? const Color(0xFF5A2830) : const Color(0xFFFFD4D1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded, color: AdminTheme.red, size: 17),
                const SizedBox(width: 9),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Global Compliance Standard', style: TextStyle(color: AdminTheme.red, fontSize: 11, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 5),
                  Text('All active Docker image sandboxes comply with sandbox virtualization standards, enforcing CPU cycles caps at 1.5 cores.', style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 10, height: 1.45)),
                ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _monitorRow(String a, String b, Color color, bool dark) => Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(color: dark ? const Color(0xFF101824) : const Color(0xFFF8F9FB), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Expanded(child: Text(a, style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11, fontWeight: FontWeight.w600))),
          Text(b, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
        ]),
      );
}

class _UsageTrends extends StatelessWidget {
  const _UsageTrends();
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 27, 28, 25),
      decoration: AdminTheme.cardDecoration(dark, radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Monthly Usage Trends', style: AdminText.section(dark)),
              const SizedBox(height: 5),
              Text('Monthly platform scale parameters over the last 6 cycles.', style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11)),
            ])),
            const AdminBadge(text: 'PLACEMENT RATE: 84.6% OVERALL', color: AdminTheme.green),
          ]),
          const SizedBox(height: 28),
          _bar('Global AI Token Consumed (Millions)', '1.45M / 2.00M Cap', .72, AdminTheme.purple, dark),
          _bar('Active Tenant University Growth', '4 Active Institutions', .80, AdminTheme.green, dark),
          _bar('Overall Compiler Code Submissions Processed', '12,851 successful execs', .63, AdminTheme.primary, dark),
          const SizedBox(height: 17),
          Row(children: [
            Expanded(child: _Cycle(label: 'JAN-MAR PLACEMENT', value: '81.2%', dark: dark)),
            const SizedBox(width: 18),
            Expanded(child: _Cycle(label: 'APR-JUN PLACEMENT', value: '83.9%', dark: dark)),
            const SizedBox(width: 18),
            Expanded(child: _Cycle(label: 'CURRENT CYCLE TARGET', value: '88.5%', purple: true, dark: dark)),
          ]),
        ],
      ),
    );
  }

  Widget _bar(String label, String value, double progress, Color color, bool dark) => Padding(
        padding: const EdgeInsets.only(bottom: 19),
        child: Column(children: [
          Row(children: [
            Expanded(child: Text(label, style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11, fontWeight: FontWeight.w800))),
            Text(value, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(99), child: Stack(children: [
            Container(height: 18, color: dark ? const Color(0xFF202938) : const Color(0xFFF0F1F4)),
            FractionallySizedBox(widthFactor: progress, child: Container(height: 18, color: color)),
          ])),
        ]),
      );
}

class _Cycle extends StatelessWidget {
  final String label, value;
  final bool purple, dark;
  const _Cycle({required this.label, required this.value, this.purple = false, required this.dark});
  @override
  Widget build(BuildContext context) => Container(
        height: 70,
        decoration: BoxDecoration(color: dark ? const Color(0xFF101824) : const Color(0xFFF8F9FB), borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(label, style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 9, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(color: purple ? AdminTheme.purple : AdminTheme.foreground(dark), fontSize: 17, fontWeight: FontWeight.w900)),
        ]),
      );
}
