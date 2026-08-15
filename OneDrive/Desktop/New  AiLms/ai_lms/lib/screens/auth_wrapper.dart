import 'package:flutter/material.dart';

import '../models/auth_state.dart';

import '../widgets/left_hero_section.dart';

import 'beginner_roadmap_modal.dart';
import 'course_suggestion_screen.dart';
import 'forgot_password_card.dart';
import 'login_form.dart';
import 'signup_form.dart';
import 'skill_level_screen.dart';
import 'sophia_ai_screen.dart';
import 'student_home_hub.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({
    super.key,
  });

  @override
  State<AuthWrapper> createState() =>
      _AuthWrapperState();
}

class _AuthWrapperState
    extends State<AuthWrapper> {

  // ==========================================================
  // AUTH SCREEN
  // ==========================================================

  AuthScreenState _currentScreen =
      AuthScreenState.login;

  // ==========================================================
  // ROLE
  //
  // 0 = Student
  // 1 = College
  // 2 = Instructor
  // 3 = Admin
  // ==========================================================

  int _selectedRoleIndex = 0;

  // ==========================================================
  // STUDENT DATA
  // ==========================================================

  String _selectedStudentBranch =
      'B.Tech - Computer Science & Eng. (CSE)';

  String _selectedCourseTitle =
      'Full-Stack Web Development';

  String _assessedLevel =
      'beginner';

  // ==========================================================
  // FORM CONTROLLERS
  // ==========================================================

  final TextEditingController
      _emailController =
      TextEditingController(
    text: 'abhijeetsahu7978@gmail.com',
  );

  final TextEditingController
      _passwordController =
      TextEditingController();

  final TextEditingController
      _nameController =
      TextEditingController(
    text: 'Abhijeet Sahu',
  );

  final TextEditingController
      _collegeController =
      TextEditingController(
    text: 'MIT Innovation Labs',
  );

  final TextEditingController
      _dobController =
      TextEditingController(
    text: '05/12/2004',
  );

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _collegeController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------
    // BEGINNER ROADMAP
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.beginnerRoadmapReady) {
      return BeginnerRoadmapModalScreen(
        userName:
            _nameController.text.isEmpty
                ? 'Abhijeet'
                : _nameController.text,

        onUnlockPressed: () {
          setState(() {
            _currentScreen =
                AuthScreenState.beginnerDashboard;
          });
        },
      );
    }

    // ----------------------------------------------------------
    // STUDENT DASHBOARD
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.beginnerDashboard) {
      return StudentHomeHubScreen(
        userName: _nameController.text.isEmpty
          ? 'Abhijeet Sahu'
          : _nameController.text,

        selectedCourseTitle: _selectedCourseTitle,

        userLevel: _assessedLevel,

        onSignOut: () {
          setState(() {
            _currentScreen = AuthScreenState.login;
          });
        },
      );
    }

    // ----------------------------------------------------------
    // SOPHIA ASSESSMENT
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.sophiaAssessment) {
      return SophiaAIScreen(
        userName:
            _nameController.text.isEmpty
                ? 'Abhijeet'
                : _nameController.text,

        selectedCourseTitle:
            _selectedCourseTitle,

        onExit: () {
          setState(() {
            _currentScreen =
                AuthScreenState
                    .skillLevelSelection;
          });
        },

        onAssessmentComplete:
            (assessedLevel) {
          setState(() {
            _assessedLevel =
                assessedLevel;

            if (assessedLevel ==
                'beginner') {
              _currentScreen =
                  AuthScreenState
                      .beginnerRoadmapReady;
            } else {
              _currentScreen =
                  AuthScreenState
                      .beginnerDashboard;
            }
          });
        },
      );
    }

    // ----------------------------------------------------------
    // SKILL LEVEL
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.skillLevelSelection) {
      return SkillLevelScreen(
        userName:
            _nameController.text.isEmpty
                ? 'Abhijeet'
                : _nameController.text,

        selectedCourseTitle:
            _selectedCourseTitle,

        onChangeTrack: () {
          setState(() {
            _currentScreen =
                AuthScreenState
                    .courseSuggestion;
          });
        },

        onContinue:
            (selectedLevel) {
          setState(() {
            _assessedLevel =
                selectedLevel;

            if (selectedLevel ==
                'beginner') {
              _currentScreen =
                  AuthScreenState
                      .beginnerRoadmapReady;
            } else {
              _currentScreen =
                  AuthScreenState
                      .sophiaAssessment;
            }
          });
        },
      );
    }

    // ----------------------------------------------------------
    // COURSE SUGGESTION
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.courseSuggestion) {
      return CourseSuggestionScreen(
        initialSelectedBranch:
            _selectedStudentBranch,

        onBack: () {
          setState(() {
            _currentScreen =
                AuthScreenState.signup;
          });
        },

        onNext:
            (chosenCourseTitle) {
          setState(() {
            _selectedCourseTitle =
                chosenCourseTitle;

            _currentScreen =
                AuthScreenState
                    .skillLevelSelection;
          });
        },
      );
    }

    // ----------------------------------------------------------
    // FORGOT PASSWORD
    // ----------------------------------------------------------

    if (_currentScreen ==
        AuthScreenState.forgotPassword) {
      return Scaffold(
        backgroundColor:
            const Color(0xFFF4F6FB),

        body: Center(
          child:
              SingleChildScrollView(
            padding:
                const EdgeInsets.all(24),

            child:
                ForgotPasswordCard(
              emailController:
                  _emailController,

              onBackTap: () {
                setState(() {
                  _currentScreen =
                      AuthScreenState.login;
                });
              },
            ),
          ),
        ),
      );
    }

    // ----------------------------------------------------------
    // LOGIN / SIGNUP
    // ----------------------------------------------------------

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F6FB),

      body:
          LayoutBuilder(
        builder:
            (context, constraints) {

          if (constraints.maxWidth >
              850) {
            return Row(
              children: [
                const Expanded(
                  flex: 1,
                  child:
                      LeftHeroSection(),
                ),

                Expanded(
                  flex: 1,
                  child:
                      Container(
                    color:
                        const Color(
                      0xFFF4F6FB,
                    ),

                    child:
                        Center(
                      child:
                          SingleChildScrollView(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal:
                              48,
                          vertical:
                              32,
                        ),

                        child:
                            ConstrainedBox(
                          constraints:
                              const BoxConstraints(
                            maxWidth:
                                450,
                          ),

                          child:
                              _buildFormContent(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Container(
            color:
                const Color(
              0xFFF4F6FB,
            ),

            child:
                SafeArea(
              child:
                  SingleChildScrollView(
                child:
                    Column(
                  children: [
                    const LeftHeroSection(
                      isMobile:
                          true,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.all(
                        24,
                      ),

                      child:
                          _buildFormContent(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // LOGIN / SIGNUP FORM
  // ==========================================================

  Widget _buildFormContent() {

    if (_currentScreen ==
        AuthScreenState.login) {
      return LoginForm(
        emailController:
            _emailController,

        passwordController:
            _passwordController,

        selectedRoleIndex:
            _selectedRoleIndex,

        onRoleSelected:
            (index) {
          setState(() {
            _selectedRoleIndex =
                index;
          });
        },

        onForgotPasswordTap:
            () {
          setState(() {
            _currentScreen =
                AuthScreenState
                    .forgotPassword;
          });
        },

        onSignUpTap:
            () {
          setState(() {
            _currentScreen =
                AuthScreenState.signup;
          });
        },

        onSignInSuccess:
            () {
          setState(() {
            _currentScreen =
                AuthScreenState
                    .beginnerDashboard;
          });
        },
      );
    }

    return SignUpForm(
      nameController:
          _nameController,

      emailController:
          _emailController,

      collegeController:
          _collegeController,

      dobController:
          _dobController,

      passwordController:
          _passwordController,

      selectedRoleIndex:
          _selectedRoleIndex,

      onRoleSelected:
          (index) {
        setState(() {
          _selectedRoleIndex =
              index;
        });
      },

      onSignInTap:
          () {
        setState(() {
          _currentScreen =
              AuthScreenState.login;
        });
      },

      onCreateAccountPressed:
          (
        chosenBranch,
        chosenCourse,
      ) {
        _handleAccountCreation(
          chosenBranch,
          chosenCourse,
        );
      },
    );
  }

  // ==========================================================
  // ACCOUNT CREATION
  // ==========================================================

  void _handleAccountCreation(
    String chosenBranch,
    String chosenCourse,
  ) {
    // STUDENT
    if (_selectedRoleIndex == 0) {
      setState(() {
        _selectedStudentBranch =
            chosenBranch;

        _selectedCourseTitle =
            chosenCourse;

        _currentScreen =
            AuthScreenState
                .courseSuggestion;
      });

      return;
    }

    // OTHER PORTALS

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Account Created Successfully!',
        ),
        backgroundColor:
            Color(0xFF22C55E),
      ),
    );

    setState(() {
      _currentScreen =
          AuthScreenState
              .beginnerDashboard;
    });
  }
}