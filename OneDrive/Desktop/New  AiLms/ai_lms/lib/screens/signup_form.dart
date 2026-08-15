import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_inputs.dart';
import '../widgets/role_selector.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController collegeController;
  final TextEditingController dobController;
  final TextEditingController passwordController;

  final int selectedRoleIndex;
  final ValueChanged<int> onRoleSelected;

  final VoidCallback onSignInTap;

  final void Function(String branch, String course)?
      onCreateAccountPressed;

  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.collegeController,
    required this.dobController,
    required this.passwordController,
    required this.selectedRoleIndex,
    required this.onRoleSelected,
    required this.onSignInTap,
    this.onCreateAccountPressed,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // ============================================================
  // AVAILABLE COURSES
  // ============================================================

  final List<String> courses = [
    'B.Tech - Computer Science & Eng. (CSE)',
    'B.Tech - AI & Machine Learning (AIML)',
    'B.Tech - Data Science (DS)',
    'B.Tech - Information Technology (IT)',
    'B.Tech - Electronics & Comm. (ECE)',
    'B.Tech - Electrical Engineering (EE)',
    'B.Tech - Mechanical Engineering (ME)',
    'B.Tech - Civil Engineering (CE)',
    'M.Tech / Higher Studies',
    'Diploma / Polytechnic',
  ];

  late String selectedCourse;

  // Used for College / Instructor / Admin verification
  final TextEditingController _uniqueCodeController =
      TextEditingController();

  // ============================================================
  // INITIALIZATION
  // ============================================================

  @override
  void initState() {
    super.initState();

    selectedCourse = courses[0];
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _uniqueCodeController.dispose();
    super.dispose();
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 12, 5),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF6B35),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.dobController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ========================================================
        // HEADER
        // ========================================================

        Text(
          'Create your account',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Sign up in 30 seconds to begin assessments.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF64748B),
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // ROLE SELECTOR
        // ========================================================

        RoleSelector(
          selectedIndex: widget.selectedRoleIndex,
          onRoleSelected: widget.onRoleSelected,
        ),

        const SizedBox(height: 20),

        // ========================================================
        // ROLE-SPECIFIC FIELDS
        // ========================================================

        ..._buildRoleSpecificFields(context),

        const SizedBox(height: 14),

        // ========================================================
        // PASSWORD
        // ========================================================

        const CustomLabel('Password'),

        const SizedBox(height: 6),

        CustomTextField(
          controller: widget.passwordController,
          isPassword: true,
          icon: Icons.lock_outline,
        ),

        const SizedBox(height: 20),

        // ========================================================
        // CREATE ACCOUNT
        // ========================================================

        PrimaryButton(
          title: 'Create My Account',
          onPressed: () {
            if (widget.onCreateAccountPressed != null) {
              widget.onCreateAccountPressed!(
                selectedCourse,
                selectedCourse,
              );
            }
          },
        ),

        const SizedBox(height: 20),

        // ========================================================
        // SOCIAL AUTH
        // ========================================================

        const SocialAuthSection(),

        const SizedBox(height: 20),

        // ========================================================
        // SIGN IN LINK
        // ========================================================

        Center(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF64748B),
              ),
              children: [
                TextSpan(
                  text: widget.selectedRoleIndex == 3
                      ? 'Already registered? '
                      : 'Already have an account? ',
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: widget.onSignInTap,
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF5722),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ROLE-SPECIFIC FIELDS
  // ============================================================

  List<Widget> _buildRoleSpecificFields(BuildContext context) {
    switch (widget.selectedRoleIndex) {
      // ==========================================================
      // COLLEGE
      // ==========================================================

      case 1:
        return [
          const CustomLabel('Name of College'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.collegeController,
          ),

          const SizedBox(height: 14),

          const CustomLabel('College Email'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.emailController,
          ),

          const SizedBox(height: 14),

          const CustomLabel(
            'Unique Code provided by Admin',
          ),

          const SizedBox(height: 6),

          CustomTextField(
            controller: _uniqueCodeController,
          ),
        ];

      // ==========================================================
      // INSTRUCTOR
      // ==========================================================

      case 2:
        return [
          const CustomLabel('Instructor Name'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.nameController,
          ),

          const SizedBox(height: 14),

          const CustomLabel('College Email'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.emailController,
          ),

          const SizedBox(height: 14),

          const CustomLabel(
            'Unique Credential Code',
          ),

          const SizedBox(height: 6),

          CustomTextField(
            controller: _uniqueCodeController,
          ),
        ];

      // ==========================================================
      // ADMIN
      // ==========================================================

      case 3:
        return [
          const CustomLabel('Employee Name'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.nameController,
          ),

          const SizedBox(height: 14),

          const CustomLabel('Company Code'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: _uniqueCodeController,
          ),
        ];

      // ==========================================================
      // STUDENT
      // ==========================================================

      case 0:
      default:
        return [
          const CustomLabel('Student Name'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.nameController,
          ),

          const SizedBox(height: 14),

          const CustomLabel('Email Address'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.emailController,
          ),

          const SizedBox(height: 14),

          const CustomLabel('College Name'),

          const SizedBox(height: 6),

          CustomTextField(
            controller: widget.collegeController,
          ),

          const SizedBox(height: 14),

          // ------------------------------------------------------
          // DOB + COURSE
          // ------------------------------------------------------

          Row(
            children: [
              // --------------------------------------------------
              // DATE OF BIRTH
              // --------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLabel('Date of Birth'),

                    const SizedBox(height: 6),

                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller: widget.dobController,
                          icon: Icons.calendar_today_outlined,
                          isSuffixIcon: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // --------------------------------------------------
              // COURSE / BRANCH
              // --------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomLabel('Course / Branch'),

                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCourse,
                          isExpanded: true,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF0F172A),
                          ),
                          items: courses.map((course) {
                            return DropdownMenuItem<String>(
                              value: course,
                              child: Text(
                                course,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCourse = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ];
    }
  }
}