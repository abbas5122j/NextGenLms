import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final int selectedRoleIndex;
  final ValueChanged<int> onRoleSelected;

  final VoidCallback onForgotPasswordTap;
  final VoidCallback onSignUpTap;
  final VoidCallback? onSignInSuccess;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.selectedRoleIndex,
    required this.onRoleSelected,
    required this.onForgotPasswordTap,
    required this.onSignUpTap,
    this.onSignInSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final roles = [
      {
        'title': 'Student',
        'icon': '🎓',
      },
      {
        'title': 'College',
        'icon': '🏫',
      },
      {
        'title': 'Instructor',
        'icon': '💼',
      },
      {
        'title': 'Admin',
        'icon': '👑',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ============================================================
        // WELCOME HEADER
        // ============================================================

        Text(
          'Welcome back!',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Enter your email credentials to access your dashboard.',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),

        const SizedBox(height: 28),

        // ============================================================
        // ROLE SELECTOR
        // ============================================================

        Text(
          'SELECT PORTAL ROLE',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF475569),
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: roles.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, String> role = entry.value;

              final bool isSelected = selectedRoleIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onRoleSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: 0.04,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      children: [
                        Text(
                          role['icon']!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          role['title']!,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFFFF6B35)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 24),

        // ============================================================
        // EMAIL
        // ============================================================

        Text(
          'Email Address',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF334155),
          ),
        ),

        const SizedBox(height: 6),

        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: 'abhijeetsahu7978@gmail.com',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 18,
              color: Color(0xFF94A3B8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B35),
                width: 1.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // ============================================================
        // PASSWORD HEADER + FORGOT PASSWORD
        // ============================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF334155),
              ),
            ),

            GestureDetector(
              onTap: onForgotPasswordTap,
              child: Text(
                'Forgot?',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF6B35),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        // ============================================================
        // PASSWORD FIELD
        // ============================================================

        TextField(
          controller: passwordController,
          obscureText: true,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: '••••••••••••',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.lock_outline,
              size: 18,
              color: Color(0xFF94A3B8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF6B35),
                width: 1.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ============================================================
        // SIGN IN BUTTON
        // ============================================================

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (onSignInSuccess != null) {
                onSignInSuccess!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 28),

        // ============================================================
        // DIVIDER
        // ============================================================

        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Color(0xFFE2E8F0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                'OR AUTHENTICATION VIA',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF94A3B8),
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const Expanded(
              child: Divider(
                color: Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ============================================================
        // GOOGLE + GITHUB SSO
        // ============================================================

        Row(
          children: [
            // --------------------------------------------------------
            // GOOGLE
            // --------------------------------------------------------

            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Google SSO will be connected here.
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Google SSO',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // --------------------------------------------------------
            // GITHUB
            // --------------------------------------------------------

            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // GitHub OAuth will be connected here.
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'GitHub OAuth',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // ============================================================
        // SIGN UP
        // ============================================================

        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),

              GestureDetector(
                onTap: onSignUpTap,
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}