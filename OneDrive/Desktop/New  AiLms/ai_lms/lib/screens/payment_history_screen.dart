import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({
    super.key,
    this.isDarkMode = false,
    this.userName = 'Abhijeet Sahu',
  });

  final bool isDarkMode;
  final String userName;

  @override
  State<PaymentHistoryScreen> createState() =>
      _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  int _selectedTab = 0;

  String _paymentFilter = 'All';
  String _searchQuery = '';

  bool _autoRenew = true;

  final TextEditingController _searchController =
      TextEditingController();

  final List<PaymentTransaction> _transactions = [
    const PaymentTransaction(
      id: 'TXN-9842',
      date: 'Jul 15, 2026 at 10:14 AM',
      plan: 'Next Gen Monthly Pro',
      paymentMethod: 'Visa ending in •••• 9842',
      amount: 29.00,
      status: PaymentStatus.paid,
    ),
    const PaymentTransaction(
      id: 'TXN-8711',
      date: 'Jun 15, 2026 at 09:30 AM',
      plan: 'Next Gen Monthly Pro',
      paymentMethod: 'Visa ending in •••• 9842',
      amount: 29.00,
      status: PaymentStatus.paid,
    ),
    const PaymentTransaction(
      id: 'TXN-5431',
      date: 'May 15, 2026 at 02:45 PM',
      plan: 'Next Gen Monthly Pro',
      paymentMethod: 'Visa ending in •••• 9842',
      amount: 29.00,
      status: PaymentStatus.failed,
    ),
    const PaymentTransaction(
      id: 'TXN-1122',
      date: 'Apr 15, 2026 at 11:20 AM',
      plan: 'Next Gen Monthly Pro',
      paymentMethod: 'Visa ending in •••• 9842',
      amount: 29.00,
      status: PaymentStatus.paid,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color get background =>
      widget.isDarkMode
          ? const Color(0xFF090D16)
          : const Color(0xFFF4F6FB);

  Color get cardColor =>
      widget.isDarkMode
          ? const Color(0xFF131927)
          : Colors.white;

  Color get primaryText =>
      widget.isDarkMode
          ? Colors.white
          : const Color(0xFF151B2B);

  Color get secondaryText =>
      widget.isDarkMode
          ? const Color(0xFF94A3B8)
          : const Color(0xFF64748B);

  Color get borderColor =>
      widget.isDarkMode
          ? const Color(0xFF263247)
          : const Color(0xFFE1E6EF);

  static const orange = Color(0xFFFF6B35);
  static const green = Color(0xFF09A66D);
  static const red = Color(0xFFFF4664);
  static const blue = Color(0xFF246BFE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                36,
                28,
                36,
                50,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1380,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildTabs(),
                      const SizedBox(height: 22),
                      _buildTabContent(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // TABS
  // ============================================================

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          _tabButton(
            index: 0,
            icon: Icons.receipt_long_outlined,
            title: 'Payment Ledger & Receipts',
            count: 4,
          ),
          const SizedBox(width: 10),
          _tabButton(
            index: 1,
            icon: Icons.auto_awesome_outlined,
            title: 'Subscription Models & Plans',
          ),
          const SizedBox(width: 10),
          _tabButton(
            index: 2,
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods & Settings',
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required int index,
    required IconData icon,
    required String title,
    int? count,
  }) {
    final selected = _selectedTab == index;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected
              ? orange
              : cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? orange
                : borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: selected
                  ? Colors.white
                  : secondaryText,
            ),
            const SizedBox(width: 9),
            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 5),
              Text(
                '($count)',
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : secondaryText,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TAB CONTENT
  // ============================================================

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 1:
        return _buildPlansPage();

      case 2:
        return _buildPaymentSettingsPage();

      default:
        return _buildLedgerPage();
    }
  }

  // ============================================================
  // LEDGER PAGE
  // ============================================================

  Widget _buildLedgerPage() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _buildSubscriptionSummary(),
        const SizedBox(height: 28),
        _buildLedgerSearch(),
        const SizedBox(height: 22),
        _buildPaymentTable(),
      ],
    );
  }

  Widget _buildSubscriptionSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        36,
        30,
        36,
        30,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: widget.isDarkMode ? 0.12 : 0.04,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _badge(
                          '⚡ ACTIVE SUBSCRIPTION',
                          const Color(0xFFFFEEE6),
                          orange,
                        ),
                        const SizedBox(width: 10),
                        _badge(
                          '✓ AUTO-RENEW ENABLED',
                          const Color(0xFFE6FAF3),
                          green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Next Gen Monthly Pro',
                            style: TextStyle(
                              color: primaryText,
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        _priceBadge(
                          '\$29.00 / month',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your subscription unlocks unlimited 24/7 AI Tutor streaming, '
                      'multi-tenant engineering tracks, verified course certificates, '
                      'and the full code compiler.',
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      icon: const Icon(
                        Icons.auto_awesome,
                        size: 17,
                      ),
                      label: const Text(
                        'Upgrade / Switch Model',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor:
                            Colors.white,
                        elevation: 0,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 260,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showInvoice(
                          _transactions.first,
                        );
                      },
                      icon: const Icon(
                        Icons.description_outlined,
                        size: 17,
                      ),
                      label: const Text(
                        'Latest Tax Receipt',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryText,
                        side: BorderSide(
                          color: borderColor,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          Divider(
            color: borderColor,
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: _summaryStat(
                  'TOTAL INVESTED',
                  '\$87.00 USD',
                  primaryText,
                ),
              ),
              Expanded(
                child: _summaryStat(
                  'COMPLETED INVOICES',
                  '3 Paid',
                  green,
                ),
              ),
              Expanded(
                child: _summaryStat(
                  'ACCOUNT TIER',
                  'Pro Tier',
                  orange,
                ),
              ),
              Expanded(
                child: _summaryStat(
                  'BILLING ENTITY',
                  'Next Gen LMS Inc.',
                  primaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryStat(
    String title,
    String value,
    Color valueColor,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: secondaryText,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildLedgerSearch() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery =
                      value.toLowerCase();
                });
              },
              style: TextStyle(
                color: primaryText,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: secondaryText,
                ),
                hintText:
                    'Search by Transaction ID (TXN-...), plan, or date...',
                hintStyle: TextStyle(
                  color: secondaryText,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: widget.isDarkMode
                    ? const Color(0xFF0E1420)
                    : const Color(0xFFF8FAFD),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Text(
            '☷ Filter:',
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          _filterButton('All'),
          _filterButton('Paid'),
          _filterButton('Pending'),
          _filterButton('Failed'),
          const SizedBox(width: 14),
          ElevatedButton.icon(
            onPressed: _simulatePayment,
            icon: const Icon(
              Icons.add,
              size: 17,
            ),
            label:
                const Text('Simulate Payment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String filter) {
    final selected =
        _paymentFilter == filter;

    return Padding(
      padding:
          const EdgeInsets.only(right: 6),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(10),
        onTap: () {
          setState(() {
            _paymentFilter = filter;
          });
        },
        child: Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF111827)
                : (widget.isDarkMode
                    ? const Color(0xFF202A3B)
                    : const Color(0xFFF2F4F8)),
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: Text(
            filter,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : primaryText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTable() {
    final filtered =
        _transactions.where((transaction) {
      final matchesFilter =
          _paymentFilter == 'All' ||
              transaction.status.name.toLowerCase() ==
                  _paymentFilter.toLowerCase();

      final search =
          _searchQuery.trim();

      final matchesSearch =
          search.isEmpty ||
              transaction.id
                  .toLowerCase()
                  .contains(search) ||
              transaction.plan
                  .toLowerCase()
                  .contains(search) ||
              transaction.date
                  .toLowerCase()
                  .contains(search);

      return matchesFilter &&
          matchesSearch;
    }).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [
          _tableHeader(),
          ...filtered.map(
            (transaction) =>
                _paymentRow(transaction),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            child: Row(
              children: [
                Text(
                  'Showing ${filtered.length} of ${_transactions.length} total entries',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.verified_user_outlined,
                  color: green,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'PCI-DSS Level 1 Compliant Transaction Records',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF101722)
            : const Color(0xFFF8FAFD),
        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          _headerCell(
            'INVOICE ID',
            1.0,
          ),
          _headerCell(
            'BILLING DATE & TIME',
            1.8,
          ),
          _headerCell(
            'PLAN / SERVICE DESCRIPTION',
            2.5,
          ),
          _headerCell(
            'PAYMENT METHOD',
            2.0,
          ),
          _headerCell(
            'AMOUNT',
            1.0,
          ),
          _headerCell(
            'STATUS',
            1.0,
          ),
          _headerCell(
            'ACTIONS',
            1.7,
          ),
        ],
      ),
    );
  }

  Widget _headerCell(
    String text,
    double flex,
  ) {
    return Expanded(
      flex: (flex * 10).round(),
      child: Text(
        text,
        style: TextStyle(
          color: secondaryText,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.7,
        ),
      ),
    );
  }

  Widget _paymentRow(
    PaymentTransaction transaction,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 19,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(
              transaction.id,
              style: TextStyle(
                color: primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 18,
            child: Text(
              transaction.date,
              style: TextStyle(
                color: primaryText,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 25,
            child: Text(
              transaction.plan,
              style: TextStyle(
                color: primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Text(
              transaction.paymentMethod,
              style: TextStyle(
                color: secondaryText,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: _statusBadge(
              transaction.status,
            ),
          ),
          Expanded(
            flex: 17,
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      _showInvoice(
                        transaction,
                      );
                    },
                    icon: const Icon(
                      Icons.description_outlined,
                      size: 14,
                    ),
                    label: const Text(
                      'View Receipt',
                    ),
                    style:
                        TextButton.styleFrom(
                      foregroundColor:
                          orange,
                      backgroundColor:
                          const Color(
                        0xFFFFF1E9,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 10,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          9,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                _smallActionButton(
                  Icons.print_outlined,
                  () {
                    _showMessage(
                      'Print dialog would open here.',
                    );
                  },
                ),
                const SizedBox(width: 5),
                _smallActionButton(
                  Icons.download_outlined,
                  () {
                    _showMessage(
                      'Receipt download started.',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallActionButton(
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(9),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? const Color(0xFF202A3B)
              : const Color(0xFFF1F4F8),
          borderRadius:
              BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 16,
          color: secondaryText,
        ),
      ),
    );
  }

  Widget _statusBadge(
    PaymentStatus status,
  ) {
    final paid =
        status == PaymentStatus.paid;

    final failed =
        status == PaymentStatus.failed;

    final color = paid
        ? green
        : failed
            ? red
            : orange;

    final background = paid
        ? const Color(0xFFE9FBF4)
        : failed
            ? const Color(0xFFFFEEF1)
            : const Color(0xFFFFF4E8);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius:
              BorderRadius.circular(999),
          border: Border.all(
            color:
                color.withValues(alpha: 0.35),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              paid
                  ? 'Paid'
                  : failed
                      ? 'Failed'
                      : 'Pending',
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PLANS
  // ============================================================

  Widget _buildPlansPage() {
    return Column(
      children: [
        _buildPlansHeading(),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder:
              (context, constraints) {
            if (constraints.maxWidth <
                950) {
              return Column(
                children: [
                  _planCard(
                    title: 'Free Starter',
                    subtitle:
                        'For casual learners exploring basic course modules.',
                    price: '\$0',
                    priceSuffix: '/ forever',
                    label: 'BASIC TIER',
                    features: [
                      'Access to 2 basic course modules per branch',
                      '10 AI Tutor queries / day',
                      'Community Q&A & forum access',
                    ],
                    disabledFeatures: [
                      'No verified certificates',
                      'No AI Voice Assistant access',
                    ],
                    buttonText:
                        'Default Base Tier',
                    buttonColor:
                        const Color(0xFFF1F3F6),
                    buttonTextColor:
                        secondaryText,
                  ),
                  const SizedBox(height: 18),
                  _planCard(
                    title: 'Monthly Pro',
                    subtitle:
                        'Full power for dedicated engineering students.',
                    price: '\$29',
                    priceSuffix: '/ month',
                    label: 'MOST POPULAR',
                    current: true,
                    features: [
                      'Unlimited AI Tutor streams',
                      'Full 8-branch course curriculums',
                      'Instant project rubric evaluations',
                      '24/7 AI Voice Assistant & Mock Interviews',
                      'Verified course & project certificates',
                    ],
                    buttonText:
                        'Active / Manage Plan',
                    buttonColor: orange,
                    buttonTextColor:
                        Colors.white,
                  ),
                  const SizedBox(height: 18),
                  _planCard(
                    title: 'Annual Expert Pro',
                    subtitle:
                        'For long-term career prep and placement tracking.',
                    price: '\$19',
                    priceSuffix: '/ mo (\$228/yr)',
                    label: 'BEST VALUE',
                    features: [
                      'Everything in Monthly Pro',
                      'Priority 1-on-1 instructor doubt clearance',
                      'Recruiter-ready public portfolio badge',
                      'Early access to new AI roadmaps',
                      'Saves over \$120/year versus monthly',
                    ],
                    buttonText:
                        'Switch to Annual Expert (\$19/mo)',
                    buttonColor: red,
                    buttonTextColor:
                        Colors.white,
                  ),
                  const SizedBox(height: 18),
                  _planCard(
                    title: 'Institutional Pass',
                    subtitle:
                        'Multi-tenant college admin command center.',
                    price: '\$49',
                    priceSuffix: '/ student / yr',
                    label: 'UNIVERSITY & COLLEGE',
                    features: [
                      'Centralized Dean & HOD Analytics Command',
                      'Automated AI Exam & Quiz Generator',
                      'Cheating detection & webcam proctoring',
                      'Grade calculator & SGPA transcript logs',
                    ],
                    buttonText:
                        'Request College License',
                    buttonColor:
                        Colors.transparent,
                    buttonTextColor: blue,
                    outlined: true,
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _planCard(
                    title: 'Free Starter',
                    subtitle:
                        'For casual learners exploring basic course modules.',
                    price: '\$0',
                    priceSuffix: '/ forever',
                    label: 'BASIC TIER',
                    features: [
                      'Access to 2 basic course modules per branch',
                      '10 AI Tutor queries / day',
                      'Community Q&A & forum access',
                    ],
                    disabledFeatures: [
                      'No verified certificates',
                      'No AI Voice Assistant access',
                    ],
                    buttonText:
                        'Default Base Tier',
                    buttonColor:
                        const Color(0xFFF1F3F6),
                    buttonTextColor:
                        secondaryText,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _planCard(
                    title: 'Monthly Pro',
                    subtitle:
                        'Full power for dedicated engineering students.',
                    price: '\$29',
                    priceSuffix: '/ month',
                    label: 'MOST POPULAR',
                    current: true,
                    features: [
                      'Unlimited AI Tutor streams',
                      'Full 8-branch course curriculums',
                      'Instant project rubric evaluations',
                      '24/7 AI Voice Assistant & Mock Interviews',
                      'Verified course & project certificates',
                    ],
                    buttonText:
                        'Active / Manage Plan',
                    buttonColor: orange,
                    buttonTextColor:
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _planCard(
                    title: 'Annual Expert Pro',
                    subtitle:
                        'For long-term career prep and placement tracking.',
                    price: '\$19',
                    priceSuffix: '/ mo (\$228/yr)',
                    label: 'BEST VALUE',
                    features: [
                      'Everything in Monthly Pro',
                      'Priority 1-on-1 instructor doubt clearance',
                      'Recruiter-ready public portfolio badge',
                      'Early access to new AI roadmaps',
                      'Saves over \$120/year versus monthly',
                    ],
                    buttonText:
                        'Switch to Annual Expert (\$19/mo)',
                    buttonColor: red,
                    buttonTextColor:
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _planCard(
                    title: 'Institutional Pass',
                    subtitle:
                        'Multi-tenant college admin command center.',
                    price: '\$49',
                    priceSuffix: '/ student / yr',
                    label:
                        'UNIVERSITY & COLLEGE',
                    features: [
                      'Centralized Dean & HOD Analytics Command',
                      'Automated AI Exam & Quiz Generator',
                      'Cheating detection & webcam proctoring',
                      'Grade calculator & SGPA transcript logs',
                    ],
                    buttonText:
                        'Request College License',
                    buttonColor:
                        Colors.transparent,
                    buttonTextColor: blue,
                    outlined: true,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 38),
        _buildComparisonMatrix(),
      ],
    );
  }

  Widget _buildPlansHeading() {
    return Column(
      children: [
        _badge(
          'FLEXIBLE STUDENT & CAMPUS PRICING',
          const Color(0xFFFFF0E9),
          orange,
        ),
        const SizedBox(height: 15),
        Text(
          'Choose the Perfect Learning Tier',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryText,
            fontSize: 31,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upgrade or switch models anytime. All plans include access to Gemini 3.5 AI Tutor server proxies, verified credentials, and real-time sandbox environments.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: secondaryText,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _planCard({
    required String title,
    required String subtitle,
    required String price,
    required String priceSuffix,
    required String label,
    required List<String> features,
    required String buttonText,
    required Color buttonColor,
    required Color buttonTextColor,
    List<String> disabledFeatures = const [],
    bool current = false,
    bool outlined = false,
  }) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
        28,
        24,
        28,
        24,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(23),
        border: Border.all(
          color: current
              ? orange
              : outlined
                  ? blue
                  : borderColor,
          width: current ? 1.8 : 1,
        ),
        boxShadow: current
            ? [
                BoxShadow(
                  color:
                      orange.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset:
                      const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: current
                        ? orange
                        : outlined
                            ? blue
                            : secondaryText,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (current)
                _miniBadge(
                  'CURRENT ACTIVE',
                  orange,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: primaryText,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            subtitle,
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: primaryText,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  priceSuffix,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ...features.map(
            (feature) => _featureRow(
              feature,
              enabled: true,
            ),
          ),
          ...disabledFeatures.map(
            (feature) => _featureRow(
              feature,
              enabled: false,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 49,
            child: outlined
                ? OutlinedButton(
                    onPressed: () {},
                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          buttonTextColor,
                      side: BorderSide(
                        color:
                            buttonTextColor,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child:
                        Text(buttonText),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonColor,
                      foregroundColor:
                          buttonTextColor,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    child:
                        Text(buttonText),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _featureRow(
    String text, {
    required bool enabled,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            enabled
                ? Icons.check
                : Icons.close,
            size: 17,
            color: enabled
                ? green
                : const Color(0xFFD1D5DB),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: enabled
                    ? primaryText
                    : secondaryText,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonMatrix() {
    final rows = [
      [
        '24/7 AI Tutor Streams',
        '10 / day',
        'Unlimited',
        'Unlimited',
        'Unlimited',
      ],
      [
        'Engineering Branch Curriculums',
        '2 Modules',
        'All 8 Branches',
        'All 8 Branches',
        'All 8 + Custom',
      ],
      [
        'Verified Certificates',
        '❌ No',
        '✅ Yes',
        '✅ Yes + URL',
        '✅ Accredited',
      ],
      [
        'AI Voice Assistant & Audio',
        '❌ No',
        '✅ Included',
        '✅ Included',
        '✅ Included',
      ],
      [
        'Project Rubric Evaluation',
        'Standard',
        'Instant AI',
        'Instant AI',
        'Custom Rubrics',
      ],
      [
        'Instructor 1-on-1 Doubt Meets',
        '❌ No',
        'Standard Queue',
        '🚀 Priority Queue',
        'Dedicated HOD',
      ],
      [
        'Centralized Dean Dashboard',
        '❌ No',
        '❌ No',
        '❌ No',
        '✅ Full Access',
      ],
    ];

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.fromLTRB(
        26,
        25,
        26,
        25,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tune,
                color: orange,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                'Detailed Model Feature Comparison Matrix',
                style: TextStyle(
                  color: primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SingleChildScrollView(
            scrollDirection:
                Axis.horizontal,
            child: DataTable(
              columnSpacing: 42,
              headingRowHeight: 42,
              dataRowMinHeight: 48,
              dataRowMaxHeight: 58,
              columns: const [
                DataColumn(
                  label:
                      Text('FEATURE CAPABILITY'),
                ),
                DataColumn(
                  label:
                      Text('FREE STARTER'),
                ),
                DataColumn(
                  label: Text(
                    'MONTHLY PRO (\$29/MO)',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ANNUAL EXPERT (\$19/MO)',
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CAMPUS PASS (\$49/YR)',
                  ),
                ),
              ],
              rows: rows
                  .map(
                    (row) => DataRow(
                      cells: row
                          .map(
                            (cell) =>
                                DataCell(
                              Text(
                                cell,
                                style:
                                    TextStyle(
                                  color:
                                      primaryText,
                                  fontSize:
                                      12,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAYMENT SETTINGS
  // ============================================================

  Widget _buildPaymentSettingsPage() {
    return LayoutBuilder(
      builder:
          (context, constraints) {
        final narrow =
            constraints.maxWidth < 900;

        if (narrow) {
          return Column(
            children: [
              _buildSavedCards(),
              const SizedBox(height: 20),
              _buildAutoRenew(),
              const SizedBox(height: 20),
              _buildBillingDetails(),
              const SizedBox(height: 20),
              _buildBillingHelp(),
            ],
          );
        }

        return Column(
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildSavedCards(),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildAutoRenew(),
                      const SizedBox(height: 25),
                      _buildBillingHelp(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildBillingDetails(),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSavedCards() {
    return _settingsCard(
      title: 'Saved Payment Instruments',
      subtitle:
          'Your credit cards are secured with tokenized bank-grade encryption.',
      child: Column(
        children: [
          Align(
            alignment:
                Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _addCard,
              icon: const Icon(
                Icons.add,
                size: 16,
              ),
              label:
                  const Text('Add New Card'),
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor:
                    Colors.white,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(13),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _paymentCard(
            brand: 'V',
            brandName: 'Visa',
            number:
                'Visa ending in •••• 9842',
            expiry: 'Expires 12/28',
            defaultCard: true,
            color: blue,
          ),
          const SizedBox(height: 12),
          _paymentCard(
            brand: 'M',
            brandName: 'Mastercard',
            number:
                'Mastercard ending in •••• 4321',
            expiry: 'Expires 09/27',
            defaultCard: false,
            color: orange,
          ),
        ],
      ),
    );
  }

  Widget _paymentCard({
    required String brand,
    required String brandName,
    required String number,
    required String expiry,
    required bool defaultCard,
    required Color color,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: defaultCard
            ? const Color(0xFFFFF9F6)
            : cardColor,
        borderRadius:
            BorderRadius.circular(17),
        border: Border.all(
          color: defaultCard
              ? orange
              : borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                brand,
                style:
                    const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  expiry,
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (defaultCard)
            _miniBadge(
              'Default',
              orange,
            )
          else
            TextButton(
              onPressed: () {
                _showMessage(
                  '$brandName is now the default card.',
                );
              },
              child:
                  const Text('Make Default'),
            ),
        ],
      ),
    );
  }

  Widget _buildAutoRenew() {
    return _settingsCard(
      title: 'Subscription Auto-Renew',
      child: Container(
        padding:
            const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.isDarkMode
              ? const Color(0xFF101722)
              : const Color(0xFFF8FAFD),
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto-Renew Monthly',
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Avoid interruption to AI Tutor',
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _autoRenew,
              onChanged: (value) {
                setState(() {
                  _autoRenew = value;
                });
              },
              activeThumbColor: green,
            ),
          ],
        ),
      ),
      footer: _autoRenew
          ? 'If disabled, your Monthly Pro plan will remain active until August 15, 2026, then transition to the Free Starter tier.'
          : 'Auto-renew is disabled. Your Monthly Pro plan will end on August 15, 2026.',
    );
  }

  Widget _buildBillingDetails() {
    return _settingsCard(
      title: 'Tax Invoice Billing Details',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _billingField(
                  'FULL LEGAL NAME',
                  'Abhijeet Sahu',
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _billingField(
                  'BILLING EMAIL ADDRESS',
                  'abhijeetsahu7978@gmail.com',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _billingField(
                  'TAX EIN / GST REGISTRATION (OPTIONAL)',
                  'EIN: 94-3829102',
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _billingField(
                  'COUNTRY / REGION',
                  'United States (US)',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billingField(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: secondaryText,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: widget.isDarkMode
                ? const Color(0xFF0E1420)
                : const Color(0xFFF8FAFD),
            borderRadius:
                BorderRadius.circular(13),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: primaryText,
              fontSize: 12,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillingHelp() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF080C15),
        borderRadius:
            BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.16),
            blurRadius: 20,
            offset:
                const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            color: orange,
            size: 32,
          ),
          const SizedBox(height: 16),
          const Text(
            'Need Billing or Tax Help?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Our support team provides official tax invoice updates, '
            'GST refund receipts, and university institutional billing statements.',
            style: TextStyle(
              color:
                  Colors.white.withValues(alpha: 0.72),
              fontSize: 12,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'Contact Next Gen Billing Support ↗',
            style: TextStyle(
              color: orange,
              fontSize: 12,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsCard({
    required String title,
    String? subtitle,
    required Widget child,
    String? footer,
  }) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(27),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: widget.isDarkMode ? 0.10 : 0.03,
            ),
            blurRadius: 18,
            offset:
                const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: primaryText,
              fontSize: 18,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: secondaryText,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 20),
          child,
          if (footer != null) ...[
            const SizedBox(height: 15),
            Text(
              footer,
              style: TextStyle(
                color: secondaryText,
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // INVOICE
  // ============================================================

  void _showInvoice(
    PaymentTransaction transaction,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.all(30),
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 830,
              maxHeight: 900,
            ),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: _invoiceContent(
                  transaction,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _invoiceContent(
    PaymentTransaction transaction,
  ) {
    return Padding(
      padding:
          const EdgeInsets.all(48),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration:
                              BoxDecoration(
                            color: orange,
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                          child:
                              const Center(
                            child: Text(
                              'NG',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Next Gen LMS Academy, Inc.',
                          style: TextStyle(
                            color:
                                Color(0xFF172033),
                            fontSize: 22,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '100 Pine Street, Suite 2400\n'
                      'San Francisco, CA 94111, USA\n'
                      'Support: billing@nextgenlms.edu | Tax EIN: 94-3829102',
                      style: TextStyle(
                        color:
                            Color(0xFF64748B),
                        fontSize: 12,
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xFFE7FAF2),
                      borderRadius:
                          BorderRadius.circular(
                        999,
                      ),
                    ),
                    child:
                        const Text(
                      'PAID IN FULL',
                      style:
                          TextStyle(
                        color: green,
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'OFFICIAL INVOICE NO.',
                    style: TextStyle(
                      color:
                          Color(0xFF94A3B8),
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.id,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF172033),
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.date,
                    style:
                        const TextStyle(
                      color:
                          Color(0xFF64748B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          const Divider(
            color: Color(0xFFE1E6EF),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              Expanded(
                child: _invoiceInfoBox(
                  'BILLED TO (STUDENT)',
                  [
                    widget.userName,
                    'abhijeetsahu7978@gmail.com',
                    'Student ID: STU-2026-9842',
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _invoiceInfoBox(
                  'PAYMENT INFORMATION',
                  [
                    'Visa ending in •••• 9842',
                    'Auth Code: #AUTH-89219-NV',
                    'Status: Verified Charge',
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    const Color(0xFFE1E6EF),
              ),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(18),
                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFFF3F4F6),
                    borderRadius:
                        BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'ITEM DESCRIPTION',
                          style:
                              TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'BILLING\nCYCLE',
                          style:
                              TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'QTY',
                          style:
                              TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'AMOUNT',
                          style:
                              TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Next Gen Monthly Pro\n'
                          'Unlimited 24/7 AI Tutor Access, Course Catalog & Code Sandbox',
                          style:
                              TextStyle(
                            color:
                                Color(0xFF172033),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '1 Month',
                          style:
                              TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '1',
                          style:
                              TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '\$29.00',
                          style:
                              TextStyle(
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Align(
            alignment:
                Alignment.centerRight,
            child: SizedBox(
              width: 320,
              child: Column(
                children: [
                  _invoiceAmount(
                    'Subtotal:',
                    '\$29.00',
                  ),
                  _invoiceAmount(
                    'Educational Tax (0%):',
                    '\$0.00',
                  ),
                  _invoiceAmount(
                    'Processing Fees:',
                    '\$0.00',
                  ),
                  const Divider(),
                  _invoiceAmount(
                    'Total Charged:',
                    '\$29.00 USD',
                    large: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Divider(
            color: Color(0xFFE1E6EF),
          ),
          const SizedBox(height: 20),
          const Text(
            'Notice: This is an electronically generated official receipt. Next Gen LMS Academy is a registered educational platform provider. All fees are covered by standard student sandbox terms.',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 10,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'For billing disputes, tax exemptions, or university credit transfers, please email billing@nextgenlms.edu quoting the invoice ID.',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _invoiceInfoBox(
    String title,
    List<String> values,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:
                  Color(0xFF94A3B8),
              fontSize: 10,
              fontWeight:
                  FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          ...values.map(
            (value) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 5,
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: value ==
                          values.first
                      ? const Color(
                          0xFF172033)
                      : const Color(
                          0xFF64748B),
                  fontSize:
                      value == values.first
                          ? 13
                          : 11,
                  fontWeight:
                      value == values.first
                          ? FontWeight.w800
                          : FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _invoiceAmount(
    String title,
    String amount, {
    bool large = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  const Color(0xFF64748B),
              fontSize:
                  large ? 16 : 12,
              fontWeight: large
                  ? FontWeight.w900
                  : FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              color: large
                  ? orange
                  : const Color(
                      0xFF172033),
              fontSize:
                  large ? 18 : 12,
              fontWeight: large
                  ? FontWeight.w900
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  Widget _badge(
    String text,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
            BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight:
              FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _miniBadge(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight:
              FontWeight.w900,
        ),
      ),
    );
  }

  Widget _priceBadge(String text) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF202A3B)
            : const Color(0xFFF1F3F6),
        borderRadius:
            BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: secondaryText,
          fontSize: 11,
          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }

  void _simulatePayment() {
    _showMessage(
      'Payment simulation completed successfully.',
    );
  }

  void _addCard() {
    _showMessage(
      'Add New Card flow opened.',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }
}

// ============================================================
// MODELS
// ============================================================

enum PaymentStatus {
  paid,
  pending,
  failed,
}

class PaymentTransaction {
  const PaymentTransaction({
    required this.id,
    required this.date,
    required this.plan,
    required this.paymentMethod,
    required this.amount,
    required this.status,
  });

  final String id;
  final String date;
  final String plan;
  final String paymentMethod;
  final double amount;
  final PaymentStatus status;
}