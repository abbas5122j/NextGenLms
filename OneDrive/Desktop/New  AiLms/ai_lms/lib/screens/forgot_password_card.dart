import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_inputs.dart';

class ForgotPasswordCard extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onBackTap;

  const ForgotPasswordCard({
    super.key,
    required this.emailController,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onBackTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back, size: 14, color: Color(0xFFFF5722)),
                const SizedBox(width: 4),
                Text(
                  'BACK',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: const Color(0xFFFF5722),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Forgot your password?',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 6),
          Text(
            'Enter your email address to receive a secure recovery code.',
            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 24),

          const CustomLabel('Email Address'),
          const SizedBox(height: 8),
          CustomTextField(controller: emailController),
          const SizedBox(height: 24),

          PrimaryButton(title: 'Send Reset Link', onPressed: () {}),
        ],
      ),
    );
  }
}