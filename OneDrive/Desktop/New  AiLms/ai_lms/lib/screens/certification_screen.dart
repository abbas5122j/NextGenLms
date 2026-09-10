
import 'package:flutter/material.dart';

class CertificationScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;

  const CertificationScreen({
    super.key,
    required this.userName,
    required this.isDarkMode,
  });

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  CertificationItem? selectedCredential;

  static const credentials = <CertificationItem>[
    CertificationItem(
      id: 'BC-2026-9941A',
      title: 'Full-Stack AI Engineering & Systems Architect',
      subtitle:
          'Large Language Models, Distributed Systems & Cloud Microservices',
      issuedOn: 'June 15, 2026',
      grade: 'Distinction (A+) (98.5%)',
      specialization:
          'Large Language Models, Distributed Systems & Cloud Microservices',
      partners: [
        'Google Cloud',
        'Microsoft AI',
        'Amazon Web Services',
        'IBM Quantum & Security',
      ],
      skills: [
        'Gemini 1.5 Pro/Flash Integration',
        'React 18 Architecture',
        'Node.js Microservices',
        'Distributed Caching',
        'PostgreSQL & Vector Search',
        'CI/CD & Cloud Run',
      ],
      txHash:
          '0x7f9a8b2c4e1d3a5f6b8c0d2e4f6a8b0c2d4e6f8a1b3c5d7e9f0a2b4c6d8e0f1a',
      sha:
          'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
    ),
    CertificationItem(
      id: 'BC-2026-8832B',
      title: 'Advanced React 18, TypeScript & Web Performance',
      subtitle: 'Modern Single Page Applications & Real-time State Management',
      issuedOn: 'May 20, 2026',
      grade: 'High Distinction (A) (96.2%)',
      specialization:
          'Modern Single Page Applications & Real-time State Management',
      partners: ['Meta Developers', 'Salesforce'],
      skills: [
        'React 18 Architecture',
        'TypeScript Patterns',
        'Vite Performance',
        'Real-time State Management',
      ],
      txHash:
          '0x91bc24d8a13f7e2b6c5d4a3908f7e6d5c4b3a29182736455463728190abcdef12',
      sha:
          '7f83b1657ff1fc53b92dc18148a1d65dfc2d6a4d2c2f8c7a4e0d3e7f5f2c1a9b',
    ),
    CertificationItem(
      id: 'BC-2026-7721C',
      title: 'Cryptographic Security, Data Privacy & Blockchain Systems',
      subtitle:
          'Smart Contract Audit, Zero Knowledge Proofs & Decentralized Identity',
      issuedOn: 'April 10, 2026',
      grade: 'Distinction (A+) (99.1%)',
      specialization:
          'Smart Contract Audit, Zero Knowledge Proofs & Decentralized Identity',
      partners: ['NVIDIA AI Security', 'IBM Quantum & Security'],
      skills: [
        'Smart Contract Auditing',
        'Zero Knowledge Proofs',
        'Blockchain Security',
        'Decentralized Identity',
      ],
      txHash:
          '0x5ad812c4e7f9310b6a2d8c4e9f103b7d5c2a8e6f4b1d9c7e3a5f2b8c6d0e1a4',
      sha:
          '4a44dc15364204a80fe80e9039455cc1608281820f4f2a9d2b9b0d1c5e6f7a8b',
    ),
  ];

  Color get text => widget.isDarkMode ? Colors.white : const Color(0xFF111827);
  Color get muted =>
      widget.isDarkMode ? const Color(0xFF9AA3B5) : const Color(0xFF697489);
  Color get page =>
      widget.isDarkMode ? const Color(0xFF10131A) : const Color(0xFFF3F5FA);
  Color get surface =>
      widget.isDarkMode ? const Color(0xFF1B1F29) : Colors.white;
  Color get border =>
      widget.isDarkMode ? const Color(0xFF303744) : const Color(0xFFE1E6EF);

  @override
  Widget build(BuildContext context) {
    // Scaffold is intentional here: this screen is CONTENT ONLY and does not
    // contain a drawer/sidebar/app bar. StudentLmsShell remains the parent.
    return Scaffold(
      backgroundColor: page,
      body: selectedCredential == null
          ? _buildDirectory()
          : _buildCredentialDetail(selectedCredential!),
    );
  }

  Widget _buildDirectory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(38, 34, 38, 55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHero(),
          const SizedBox(height: 35),
          _buildPartners(),
          const SizedBox(height: 36),
          Text(
            'Your Blockchain Verified Credentials',
            style: TextStyle(
              color: text,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Click any certificate to inspect full cryptographic metadata, view executive diploma layout, or verify on-chain.',
            style: TextStyle(color: muted, fontSize: 12.5),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1100
                  ? 3
                  : constraints.maxWidth >= 720
                      ? 2
                      : 1;
              final gap = 20.0;
              final width = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: credentials
                    .map(
                      (item) => SizedBox(
                        width: width,
                        child: _buildCredentialCard(item),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(34),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF11152F), Color(0xFF1B396D)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 18,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 800;

          final left = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 9,
                runSpacing: 8,
                children: [
                  _badge(
                    '◉  ON-CHAIN VERIFIED BLOCKCHAIN CREDENTIALS',
                    const Color(0xFF00E5A0),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Polygon PoS  &  W3C VC v2.0',
                      style: TextStyle(
                        color: Color(0xFFE0E6F4),
                        fontSize: 9.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Immutable Corporate & Academic Certification Ledger',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                'Every credential earned on NextGen LMS is cryptographically hashed, timestamped on the Polygon Blockchain, and universally recognized by premier technology companies worldwide.',
                style: TextStyle(
                  color: Color(0xFFD8DEED),
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.workspace_premium_outlined, size: 17),
                label: const Text('Earned Credentials (3)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7A30),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _showVerifier,
                icon: const Icon(Icons.verified_user_outlined, size: 16),
                label: const Text('Employer Verifier'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF263F6C),
                  side: const BorderSide(color: Color(0xFF58709A)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: 22), actions],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: left),
              const SizedBox(width: 28),
              SizedBox(width: 300, child: actions),
            ],
          );
        },
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        border: Border.all(color: color.withOpacity(.30)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          letterSpacing: .7,
        ),
      ),
    );
  }

  Widget _buildPartners() {
    const names = [
      ['Google', 'Cloud Authorized'],
      ['Microsoft', 'Enterprise Endorsed'],
      ['AWS', 'Infra Accredited'],
      ['IBM', 'Crypto Validator'],
      ['Meta', 'React Ecosystem'],
      ['NVIDIA', 'Compute Partner'],
      ['Salesforce', 'CRM & Cloud'],
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 21),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.business_outlined,
                color: Color(0xFFFF782F),
                size: 15,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'CORPORATE ENDORSEMENTS & EMPLOYER RECOGNITION NETWORK',
                  style: TextStyle(
                    color: muted,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .65,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FAF3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  '◉ 100% Industry Recognized',
                  style: TextStyle(
                    color: Color(0xFF00A96B),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 22, color: border),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: names
                .map(
                  (p) => SizedBox(
                    width: 150,
                    height: 62,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.isDarkMode
                            ? const Color(0xFF202530)
                            : const Color(0xFFF8FAFC),
                        border: Border.all(color: border),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            p[0],
                            style: TextStyle(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            p[1],
                            style: TextStyle(color: muted, fontSize: 8.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialCard(CertificationItem item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 22),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _smallPill(item.id),
              const Spacer(),
              _verifiedPill(),
            ],
          ),
          const SizedBox(height: 17),
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8A00),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              color: Colors.white,
              size: 31,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            style: TextStyle(
              color: text,
              fontSize: 17,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            item.subtitle,
            style: TextStyle(
              color: muted,
              fontSize: 11.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 17),
          Divider(color: border),
          const SizedBox(height: 12),
          Text(
            'RECOGNIZED & ENDORSED BY',
            style: TextStyle(
              color: muted,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: .7,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: item.partners
                .map(
                  (p) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? const Color(0xFF1D2530)
                          : const Color(0xFFF8FBFF),
                      border: Border.all(color: const Color(0xFFA9C7FF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? const Color(0xFFBBD4FF)
                            : const Color(0xFF1264E8),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 17),
          Divider(color: border),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _meta('Issued On', item.issuedOn),
              ),
              Expanded(
                child: _meta(
                  'Grade Performance',
                  item.grade,
                  end: true,
                  green: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          InkWell(
            onTap: () => setState(() => selectedCredential = item),
            child: const Row(
              children: [
                Text(
                  'View Executive Diploma',
                  style: TextStyle(
                    color: Color(0xFFFF6C22),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFFF6C22),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallPill(String value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? const Color(0xFF252A34)
              : const Color(0xFFF2F4F8),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: muted,
            fontSize: 9,
            fontFamily: 'monospace',
          ),
        ),
      );

  Widget _verifiedPill() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE5FAF2),
          border: Border.all(color: const Color(0xFF9DE9CF)),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Text(
          '◉ Verified On-Chain',
          style: TextStyle(
            color: Color(0xFF00A96B),
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  Widget _meta(
    String label,
    String value, {
    bool end = false,
    bool green = false,
  }) {
    return Column(
      crossAxisAlignment:
          end ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: muted, fontSize: 9.5)),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: end ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            color: green ? const Color(0xFF00A96B) : text,
            fontSize: 10.5,
            height: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialDetail(CertificationItem item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(38, 18, 38, 55),
      child: Column(
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () => setState(() => selectedCredential = null),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text('Back to All Credentials'),
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () => _verify(item),
                icon: const Icon(Icons.verified_user_outlined, size: 16),
                label: const Text('Verify Polygon Hash'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _print(item),
                icon: const Icon(Icons.print_outlined, size: 16),
                label: const Text('Print / Save PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111A2F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _diploma(item),
          const SizedBox(height: 24),
          _share(item),
        ],
      ),
    );
  }

  Widget _diploma(CertificationItem item) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1010),
      padding: const EdgeInsets.fromLTRB(55, 48, 55, 50),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        border: Border.all(color: const Color(0xFFFFC45A), width: 2),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.14),
            blurRadius: 25,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFFF8A00),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              color: Colors.white,
              size: 33,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'OFFICIAL INSTITUTIONAL & CORPORATE DIRECTIVE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE76500),
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'CERTIFICATE OF ACADEMIC\nDISTINCTION',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF101729),
              fontSize: 35,
              height: 1.08,
              fontFamily: 'serif',
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: 135,
            height: 3,
            color: const Color(0xFFFFBE4C),
          ),
          const SizedBox(height: 17),
          const Text(
            'THIS CRYPTOGRAPHICALLY IMMUTABLE CREDENTIAL IS AWARDED TO',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF606B7D),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: .7,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.userName.isEmpty
                ? 'ABHIJEET SAHU'
                : widget.userName.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF11192D),
              fontSize: 38,
              fontFamily: 'serif',
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Student  Matrix ID: NG-2026-CS-0892',
            style: TextStyle(
              color: Color(0xFF687287),
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 31),
          Text(
            'In recognition of successful completion and mastery of all rigorous academic and industry-aligned objectives in',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF273248),
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF11192D),
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Specialization: ${item.specialization}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF687287),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 7,
            runSpacing: 7,
            children: item.skills
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5E7),
                      border: Border.all(color: const Color(0xFFFFD59B)),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      s,
                      style: const TextStyle(
                        color: Color(0xFFE36A00),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 32),
          const Divider(color: Color(0xFFFFDFAF)),
          const SizedBox(height: 20),
          const Text(
            'INDUSTRY ENDORSING CONSORTIUMS & TECHNOLOGY PARTNERS',
            style: TextStyle(
              color: Color(0xFF8A96A9),
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: item.partners
                .map(
                  (p) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      border: Border.all(color: const Color(0xFFA8C7FF)),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '✓ $p',
                      style: const TextStyle(
                        color: Color(0xFF1670E8),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 30),
          const Divider(color: Color(0xFFFFDFAF)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _signature('Dr. Eleanor Vance', 'Head of Department')),
              const SizedBox(width: 18),
              _seal(),
              const SizedBox(width: 18),
              Expanded(
                child: _signature(
                  'Prof. Marcus Thorne',
                  'Dean of Academic & Accreditation Affairs',
                  right: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF10192F),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Wrap(
              spacing: 30,
              runSpacing: 12,
              children: [
                _hash('Transaction Hash (TxHash)', item.txHash),
                _hash('SHA-256 Digest', item.sha),
                _hash('Credential ID', item.id),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signature(String name, String role, {bool right = false}) {
    return Column(
      crossAxisAlignment:
          right ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          name,
          textAlign: right ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF202A3D),
            fontSize: 17,
            fontStyle: FontStyle.italic,
            fontFamily: 'serif',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        Container(height: 1, color: const Color(0xFF9AA5B6)),
        const SizedBox(height: 7),
        Text(
          role,
          textAlign: right ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF667186),
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _seal() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFFFFC400),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE49B00), width: 3),
      ),
      alignment: Alignment.center,
      child: const Text(
        'POLY•ON•\nCHAIN\nVERIFIED 2026',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF473100),
          fontSize: 7,
          height: 1.25,
          fontWeight: FontWeight.w900,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _hash(String label, String value) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF8E9AB0), fontSize: 8.5),
          ),
          const SizedBox(height: 3),
          SelectableText(
            value,
            style: const TextStyle(
              color: Color(0xFFE0E7F2),
              fontSize: 8,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _share(CertificationItem item) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1010),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Share & Embed Verified Credential',
            style: TextStyle(
              color: text,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _shareButton(
                'Copy Verification URL',
                Icons.open_in_new_rounded,
                'https://nextgenlms.example/verify/${item.id}',
              ),
              _shareButton(
                'Copy Polygon TxHash',
                Icons.lock_outline_rounded,
                item.txHash,
              ),
              _shareButton(
                'Copy W3C JSON-LD',
                Icons.data_object_rounded,
                '{"credentialId":"${item.id}"}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shareButton(String title, IconData icon, String value) {
    return SizedBox(
      width: 290,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title copied')),
          );
        },
        icon: Icon(icon, size: 16),
        label: Text(title, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  void _showVerifier() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Employer Verifier'),
        content: const Text(
          'Enter a credential ID and Polygon transaction hash in your production verification service to validate a certificate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _verify(CertificationItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.id} verified on Polygon (demo).')),
    );
  }

  void _print(CertificationItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Print / Save PDF is ready to connect to your PDF service.'),
      ),
    );
  }
}

class CertificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String issuedOn;
  final String grade;
  final String specialization;
  final List<String> partners;
  final List<String> skills;
  final String txHash;
  final String sha;

  const CertificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.issuedOn,
    required this.grade,
    required this.specialization,
    required this.partners,
    required this.skills,
    required this.txHash,
    required this.sha,
  });
}
