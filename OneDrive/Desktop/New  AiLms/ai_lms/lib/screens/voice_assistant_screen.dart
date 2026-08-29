import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Next Gen LMS - Native Voice Assistant
///
/// Features:
/// - Real-time speech-to-text with partial results.
/// - 11 languages shown in the supplied UI design.
/// - Uses the language installed/available on the current device.
/// - Automatically restarts a recognition session after the platform stops,
///   while the user keeps the microphone session enabled.
/// - Works with the existing LMS shell: this screen does NOT create a sidebar
///   or global top bar.
///
/// Add to pubspec.yaml:
///   speech_to_text: ^7.4.0
///
/// Windows support in speech_to_text is currently beta. The selected language
/// must also be available to the Windows speech-recognition service.
class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({
    super.key,
    this.userName = 'Abhijeet Sahu',
    this.isDarkMode = false,
  });

  final String userName;
  final bool isDarkMode;

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantLayout {
  // Change these values to control the overall Voice Assistant sizing.
  static const double maxContentWidth = 1280;
  static const double pageHorizontalPadding = 22;
  static const double pageTopPadding = 26;
  static const double pageBottomPadding = 34;
  static const double sectionGap = 20;
  static const double panelGap = 18;

  // Main cards
  static const double heroRadius = 20;
  static const double panelRadius = 20;
  static const double heroHorizontalPadding = 26;
  static const double heroVerticalPadding = 24;
  static const double panelPadding = 22;

  // Language tiles
  static const double languageTileHeight = 58;
  static const double languageTileGap = 9;

  // Microphone card
  static const double microphoneCardHeight = 190;
  static const double microphoneButtonSize = 68;

  // Transcript / explanation boxes
  static const double transcriptMinHeight = 92;
  static const double explanationBoxMinHeight = 96;

  // Smaller cards
  static const double vocabularyCardHeight = 92;
  static const double quickPromptHeight = 46;
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  final TextEditingController _textController = TextEditingController();
  Timer? _restartTimer;

  bool _speechAvailable = false;
  bool _keepListening = false;
  bool _isListening = false;
  bool _isProcessing = false;

  String _selectedLanguage = 'Hindi';
  String _selectedLocaleId = 'hi-IN';

  String _liveText = '';
  String _lastFinalText = '';
  String _status = 'Initializing voice recognition...';
  String _error = '';

  double _soundLevel = 0;

  List<stt.LocaleName> _deviceLocales = [];

  final Map<String, _VoiceLanguage> _languages = const {
    'Hindi': _VoiceLanguage(
      code: 'IN',
      nativeName: 'हिन्दी',
      subtitle: 'Hindi',
      locale: 'hi-IN',
      flag: '🇮🇳',
    ),
    'Tamil': _VoiceLanguage(
      code: 'IN',
      nativeName: 'தமிழ்',
      subtitle: 'Tamil',
      locale: 'ta-IN',
      flag: '🇮🇳',
    ),
    'Telugu': _VoiceLanguage(
      code: 'IN',
      nativeName: 'తెలుగు',
      subtitle: 'Telugu',
      locale: 'te-IN',
      flag: '🇮🇳',
    ),
    'Bengali': _VoiceLanguage(
      code: 'IN',
      nativeName: 'বাংলা',
      subtitle: 'Bengali',
      locale: 'bn-IN',
      flag: '🇮🇳',
    ),
    'Marathi': _VoiceLanguage(
      code: 'IN',
      nativeName: 'मराठी',
      subtitle: 'Marathi',
      locale: 'mr-IN',
      flag: '🇮🇳',
    ),
    'Kannada': _VoiceLanguage(
      code: 'IN',
      nativeName: 'ಕನ್ನಡ',
      subtitle: 'Kannada',
      locale: 'kn-IN',
      flag: '🇮🇳',
    ),
    'Spanish': _VoiceLanguage(
      code: 'ES',
      nativeName: 'Español',
      subtitle: 'Spanish',
      locale: 'es-ES',
      flag: '🇪🇸',
    ),
    'French': _VoiceLanguage(
      code: 'FR',
      nativeName: 'Français',
      subtitle: 'French',
      locale: 'fr-FR',
      flag: '🇫🇷',
    ),
    'German': _VoiceLanguage(
      code: 'DE',
      nativeName: 'Deutsch',
      subtitle: 'German',
      locale: 'de-DE',
      flag: '🇩🇪',
    ),
    'Indian English': _VoiceLanguage(
      code: 'IN',
      nativeName: 'Indian English',
      subtitle: 'English (India)',
      locale: 'en-IN',
      flag: '🇮🇳',
    ),
    'English': _VoiceLanguage(
      code: 'US',
      nativeName: 'English',
      subtitle: 'English (Global)',
      locale: 'en-US',
      flag: '🇺🇸',
    ),
  };

  final List<String> _quickPrompts = const [
    'What are React Hooks?',
    'Why is Virtual DOM useful?',
    'What is an API?',
    'What is a Cloud Database?',
  ];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  @override
  void dispose() {
    _restartTimer?.cancel();
    _speech.stop();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _initializeSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
        debugLogging: false,
      );

      if (!mounted) return;

      if (!available) {
        setState(() {
          _speechAvailable = false;
          _status = 'Speech recognition is not available.';
          _error =
              'Enable microphone and speech recognition permissions on this device.';
        });
        return;
      }

      final locales = await _speech.locales();
      final systemLocale = await _speech.systemLocale();

      setState(() {
        _speechAvailable = true;
        _deviceLocales = locales;
        _status = 'Ready — choose a language and tap the microphone.';
      });

      // Prefer Hindi for this UI, but fall back to the device locale if
      // Hindi is not installed.
      final preferred = _findAvailableLocale('hi-IN');
      if (preferred != null) {
        _selectedLocaleId = preferred.localeId;
      } else if (systemLocale != null) {
        final systemMatch = _findAvailableLocale(systemLocale.localeId);
        if (systemMatch != null) {
          _selectedLocaleId = systemMatch.localeId;
          final matchingLanguage = _languages.entries.where(
            (entry) =>
                entry.value.locale.toLowerCase() ==
                systemMatch.localeId.toLowerCase(),
          );
          if (matchingLanguage.isNotEmpty) {
            _selectedLanguage = matchingLanguage.first.key;
          }
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _speechAvailable = false;
        _status = 'Speech initialization failed.';
        _error = e.toString();
      });
    }
  }

  stt.LocaleName? _findAvailableLocale(String wanted) {
    if (_deviceLocales.isEmpty) return null;

    final exact = _deviceLocales.where(
      (locale) => locale.localeId.toLowerCase() == wanted.toLowerCase(),
    );
    if (exact.isNotEmpty) return exact.first;

    final languageCode = wanted.split('-').first.toLowerCase();
    final sameLanguage = _deviceLocales.where(
      (locale) => locale.localeId.split('-').first.toLowerCase() == languageCode,
    );
    if (sameLanguage.isNotEmpty) return sameLanguage.first;

    return null;
  }

  Future<void> _selectLanguage(String languageName) async {
    final language = _languages[languageName];
    if (language == null) return;

    if (_isListening) {
      await _stopListening();
    }

    final available = _findAvailableLocale(language.locale);

    setState(() {
      _selectedLanguage = languageName;
      _error = '';
    });

    if (available == null) {
      setState(() {
        _selectedLocaleId = language.locale;
        _status =
            '${language.subtitle} is not installed/available on this device.';
        _error =
            'Install the corresponding speech language pack, then try again.';
      });
      return;
    }

    setState(() {
      _selectedLocaleId = available.localeId;
      _status = '${language.nativeName} selected. Tap the microphone to speak.';
    });
  }

  Future<void> _toggleListening() async {
    if (!_speechAvailable) {
      await _initializeSpeech();
      if (!_speechAvailable) return;
    }

    if (_isListening || _keepListening) {
      await _stopListening();
    } else {
      await _startListening();
    }
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) return;

    final availableLocale = _findAvailableLocale(_selectedLocaleId);

    if (availableLocale == null) {
      setState(() {
        _status =
            'The selected language is unavailable on this device.';
        _error =
            'Available languages: ${_deviceLocales.isEmpty ? 'none reported' : _deviceLocales.map((e) => e.localeId).join(', ')}';
      });
      return;
    }

    _restartTimer?.cancel();

    setState(() {
      _keepListening = true;
      _isListening = true;
      _isProcessing = false;
      _liveText = '';
      _error = '';
      _status = 'Listening in ${_languages[_selectedLanguage]?.subtitle}...';
    });

    try {
      await _speech.listen(
        onResult: _onSpeechResult,
        onSoundLevelChange: _onSoundLevel,
        listenOptions: stt.SpeechListenOptions(
          localeId: availableLocale.localeId,
          partialResults: true,
          cancelOnError: false,
          onDevice: false,
          autoPunctuation: true,
          listenMode: stt.ListenMode.dictation,
          pauseFor: const Duration(seconds: 3),
          listenFor: const Duration(minutes: 1),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isListening = false;
        _keepListening = false;
        _status = 'Could not start microphone.';
        _error = e.toString();
      });
    }
  }

  Future<void> _stopListening() async {
    _restartTimer?.cancel();
    _keepListening = false;

    try {
      await _speech.stop();
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _isListening = false;
      _soundLevel = 0;
      _status = _liveText.isEmpty
          ? 'Microphone stopped.'
          : 'Voice captured successfully.';
    });
  }

  Future<void> _cancelListening() async {
    _restartTimer?.cancel();
    _keepListening = false;

    try {
      await _speech.cancel();
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _isListening = false;
      _liveText = '';
      _soundLevel = 0;
      _status = 'Listening cancelled.';
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    final recognized = result.recognizedWords.trim();

    setState(() {
      _liveText = recognized;

      if (result.finalResult && recognized.isNotEmpty) {
        _lastFinalText = recognized;
        _isProcessing = true;
      }

      if (recognized.isNotEmpty) {
        _status = result.finalResult
            ? 'Final result received.'
            : 'Listening — words are appearing in real time...';
      }
    });

    // A final result may be followed by a platform stop. Keep the session
    // alive when the user explicitly selected continuous listening.
    if (result.finalResult && _keepListening) {
      _scheduleRestart();
    }
  }

  void _scheduleRestart() {
    _restartTimer?.cancel();

    _restartTimer = Timer(const Duration(milliseconds: 450), () async {
      if (!mounted || !_keepListening || _speech.isListening) return;

      setState(() {
        _isListening = true;
        _status = 'Listening...';
      });

      try {
        await _speech.listen(
          onResult: _onSpeechResult,
          onSoundLevelChange: _onSoundLevel,
          listenOptions: stt.SpeechListenOptions(
            localeId: _selectedLocaleId,
            partialResults: true,
            cancelOnError: false,
            onDevice: false,
            autoPunctuation: true,
            listenMode: stt.ListenMode.dictation,
            pauseFor: const Duration(seconds: 3),
            listenFor: const Duration(minutes: 1),
          ),
        );
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _isListening = false;
          _status = 'Recognition session ended. Tap the microphone to retry.';
        });
      }
    });
  }

  void _onSpeechStatus(String status) {
    if (!mounted) return;

    final normalized = status.toLowerCase();

    if (normalized.contains('listening')) {
      setState(() {
        _isListening = true;
        _status = 'Listening in ${_languages[_selectedLanguage]?.subtitle}...';
      });
      return;
    }

    if (normalized.contains('notlistening') ||
        normalized.contains('done') ||
        normalized.contains('stopped')) {
      if (_keepListening) {
        _scheduleRestart();
      } else {
        setState(() {
          _isListening = false;
          _soundLevel = 0;
        });
      }
    }
  }

  void _onSpeechError(SpeechRecognitionError error) {
    if (!mounted) return;

    final message = error.errorMsg.trim();

    setState(() {
      _isListening = false;
      _soundLevel = 0;
      _error = message.isEmpty ? 'Speech recognition error.' : message;
      _status = 'Speech recognition reported an error.';
    });

    if (_keepListening && !error.permanent) {
      _scheduleRestart();
    }
  }

  void _onSoundLevel(double level) {
    if (!mounted) return;

    setState(() {
      _soundLevel = level.clamp(0.0, 12.0);
    });
  }

  void _submitText() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _liveText = text;
      _lastFinalText = text;
      _isProcessing = true;
      _status = 'Text submitted.';
    });

    FocusScope.of(context).unfocus();
  }

  void _useQuickPrompt(String prompt) {
    setState(() {
      _liveText = prompt;
      _lastFinalText = prompt;
      _isProcessing = true;
      _status = 'Quick prompt selected.';
    });
  }

  void _clearHistory() {
    setState(() {
      _liveText = '';
      _lastFinalText = '';
      _textController.clear();
      _isProcessing = false;
      _error = '';
      _status = 'History cleared.';
    });
  }

  _VoiceLanguage get _currentLanguage =>
      _languages[_selectedLanguage] ?? _languages.values.first;

  String get _nativeExplanation {
    final text = _lastFinalText.isEmpty ? _liveText : _lastFinalText;

    if (text.trim().isEmpty) {
      return 'Start speaking. Your words will appear here in real time.';
    }

    // This is intentionally a local UI explanation. Replace this getter with
    // your Gemini/Supabase backend response when AI explanation is connected.
    return 'I heard:\n$text\n\n'
        'Sophia can now explain this question, translate it, create a '
        'learning summary, and generate technical vocabulary for the selected language.';
  }

  @override
  Widget build(BuildContext context) {
    final dark = widget.isDarkMode;

    final background = dark
        ? const Color(0xFF090D16)
        : const Color(0xFFF4F6FB);
    final card = dark ? const Color(0xFF131927) : Colors.white;
    final text = dark ? Colors.white : const Color(0xFF172033);
    final sub = dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final border = dark
        ? const Color(0xFF263247)
        : const Color(0xFFE1E6EF);

    return Container(
      color: background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: _VoiceAssistantLayout.maxContentWidth,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              _VoiceAssistantLayout.pageHorizontalPadding,
              _VoiceAssistantLayout.pageTopPadding,
              _VoiceAssistantLayout.pageHorizontalPadding,
              _VoiceAssistantLayout.pageBottomPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(card, text, sub, border),
                const SizedBox(height: 26),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      return Column(
                        children: [
                          _buildLanguageAndMicPanel(
                            card,
                            text,
                            sub,
                            border,
                          ),
                          const SizedBox(height: _VoiceAssistantLayout.sectionGap),
                          _buildSandboxPanel(
                            card,
                            text,
                            sub,
                            border,
                          ),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _buildLanguageAndMicPanel(
                            card,
                            text,
                            sub,
                            border,
                          ),
                        ),
                        const SizedBox(width: _VoiceAssistantLayout.panelGap),
                        Expanded(
                          flex: 7,
                          child: _buildSandboxPanel(
                            card,
                            text,
                            sub,
                            border,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
    Color card,
    Color text,
    Color sub,
    Color border,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: _VoiceAssistantLayout.heroHorizontalPadding,
        vertical: _VoiceAssistantLayout.heroVerticalPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDarkMode
              ? const [
                  Color(0xFF271B2C),
                  Color(0xFF171B2A),
                ]
              : const [
                  Color(0xFFFFF0F3),
                  Color(0xFFF8F4F7),
                ],
        ),
        borderRadius: BorderRadius.circular(_VoiceAssistantLayout.heroRadius),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF57324D)
              : const Color(0xFFF5C8D0),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 700;

          final titleBlock = Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pill(
                  '✦ MULTILINGUAL INDIA BETA',
                  const Color(0xFFFFE1E7),
                  const Color(0xFFFF4D63),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      '🗣️',
                      style: TextStyle(fontSize: 34),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Native Voice Assistant',
                        style: TextStyle(
                          color: text,
                          fontSize: 31,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Talk to Next Gen LMS in your native language. '
                  'Your speech is transcribed in real time and can be passed '
                  'to Sophia for explanation, translation and study summaries.',
                  style: TextStyle(
                    color: sub,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          );

          final stats = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _statCard(
                'SUPPORTED',
                '11+ Languages',
                const Color(0xFFFF6B35),
                card,
                text,
              ),
              const SizedBox(width: 14),
              _statCard(
                'ACCURACY',
                'Device STT',
                const Color(0xFF1DBB75),
                card,
                text,
              ),
            ],
          );

          return compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBlock,
                    const SizedBox(height: 20),
                    stats,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titleBlock,
                    const SizedBox(width: 24),
                    stats,
                  ],
                );
        },
      ),
    );
  }

  Widget _buildLanguageAndMicPanel(
    Color card,
    Color text,
    Color sub,
    Color border,
  ) {
    return Container(
      padding: const EdgeInsets.all(_VoiceAssistantLayout.panelPadding),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(_VoiceAssistantLayout.panelRadius),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              widget.isDarkMode ? 0.08 : 0.04,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌐 SELECT YOUR NATIVE LANGUAGE',
            style: TextStyle(
              color: widget.isDarkMode
                  ? const Color(0xFFFF9A82)
                  : const Color(0xFF7E8798),
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth < 450 ? 1 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _languages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: _VoiceAssistantLayout.languageTileGap,
                  crossAxisSpacing: _VoiceAssistantLayout.languageTileGap,
                  mainAxisExtent: _VoiceAssistantLayout.languageTileHeight,
                ),
                itemBuilder: (context, index) {
                  final name = _languages.keys.elementAt(index);
                  return _buildLanguageTile(
                    name,
                    _languages[name]!,
                    text,
                    sub,
                  );
                },
              );
            },
          ),
          const SizedBox(height: 26),
          _buildMicCard(card, text, sub, border),
          const SizedBox(height: 22),
          Text(
            'OR WRITE/EDIT NATIVE TEXT DIRECTLY',
            style: TextStyle(
              color: sub,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  onSubmitted: (_) => _submitText(),
                  style: TextStyle(color: text),
                  decoration: InputDecoration(
                    hintText:
                        'Ask in ${_currentLanguage.nativeName} (e.g. React Hooks?)',
                    hintStyle: TextStyle(color: sub),
                    filled: true,
                    fillColor: widget.isDarkMode
                        ? const Color(0xFF0E1420)
                        : const Color(0xFFF5F7FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: _submitText,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 17,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _buildQuickPrompts(text, sub, border),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    String name,
    _VoiceLanguage language,
    Color text,
    Color sub,
  ) {
    final selected = name == _selectedLanguage;
    final available = _findAvailableLocale(language.locale) != null;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _selectLanguage(name),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? (widget.isDarkMode
                  ? const Color(0xFF321E28)
                  : const Color(0xFFFFEEF0))
              : (widget.isDarkMode
                  ? const Color(0xFF151C2A)
                  : const Color(0xFFF3F6FA)),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFFFF5A63)
                : (widget.isDarkMode
                    ? const Color(0xFF273247)
                    : const Color(0xFFE4E9F1)),
            width: selected ? 1.3 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              language.flag,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFF5A63)
                    : (widget.isDarkMode
                        ? const Color(0xFF202A3B)
                        : Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                language.code,
                style: TextStyle(
                  color: selected ? Colors.white : sub,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    language.nativeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: text,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    language.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: sub,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            if (!available)
              Tooltip(
                message: 'Not installed on this device',
                child: Icon(
                  Icons.cloud_off_outlined,
                  size: 15,
                  color: sub,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMicCard(
    Color card,
    Color text,
    Color sub,
    Color border,
  ) {
    final active = _isListening || _keepListening;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: _VoiceAssistantLayout.microphoneCardHeight,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF0F1623)
            : const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Text(
            active
                ? 'LISTENING — SPEAK NOW'
                : 'PUSH TO SPEAK NATIVE AUDIO',
            style: TextStyle(
              color: active
                  ? const Color(0xFFFF5A63)
                  : sub,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.9,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            active
                ? 'Your words appear on the right in real time'
                : 'Hold or click the mic button and start talking',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: sub,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              if (active)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 92 + (_soundLevel * 2),
                  height: 92 + (_soundLevel * 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF5A63).withOpacity(0.08),
                  ),
                ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _toggleListening,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _VoiceAssistantLayout.microphoneButtonSize,
                    height: _VoiceAssistantLayout.microphoneButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active
                          ? const Color(0xFFFF5A63)
                          : (widget.isDarkMode
                              ? const Color(0xFF202A3B)
                              : Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: active
                              ? const Color(0xFFFF5A63).withOpacity(0.25)
                              : Colors.black.withOpacity(0.08),
                          blurRadius: 18,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Icon(
                      active ? Icons.mic : Icons.mic_none_rounded,
                      color: active
                          ? Colors.white
                          : const Color(0xFF9AA5B7),
                      size: 31,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (active) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: _stopListening,
              child: const Text(
                'Stop listening',
                style: TextStyle(color: Color(0xFFFF5A63)),
              ),
            ),
          ],
          if (_error.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE04B5B),
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSandboxPanel(
    Color card,
    Color text,
    Color sub,
    Color border,
  ) {
    final currentText =
        _liveText.isEmpty ? 'Waiting for your voice...' : _liveText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'INTERACTIVE LEARNING SANDBOX',
                style: TextStyle(
                  color: sub,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.7,
                ),
              ),
            ),
            TextButton(
              onPressed: _clearHistory,
              child: Text(
                'Clear History',
                style: TextStyle(
                  color: sub,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(_VoiceAssistantLayout.panelRadius),
            border: Border.all(color: border),
          ),
          child: Column(
            children: [
              _buildVoiceTranscript(
                text,
                sub,
                border,
                currentText,
              ),
              _buildExplanation(
                text,
                sub,
                border,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceTranscript(
    Color text,
    Color sub,
    Color border,
    String currentText,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pill(
                '${_currentLanguage.flag} ${_currentLanguage.subtitle}',
                widget.isDarkMode
                    ? const Color(0xFF3B2730)
                    : const Color(0xFFFFEAD7),
                const Color(0xFFFF7A45),
              ),
              const SizedBox(width: 8),
              Icon(
                _isListening
                    ? Icons.graphic_eq_rounded
                    : Icons.access_time_rounded,
                size: 14,
                color: _isListening
                    ? const Color(0xFFFF5A63)
                    : sub,
              ),
              const SizedBox(width: 5),
              Text(
                _isListening ? 'LIVE' : 'READY',
                style: TextStyle(
                  color: _isListening
                      ? const Color(0xFFFF5A63)
                      : sub,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (_isProcessing)
                const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF7C4DFF),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            _isListening
                ? '🎙️ Listening...'
                : '🎙️ Recognized speech',
            style: TextStyle(
              color: text,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: _VoiceAssistantLayout.transcriptMinHeight,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF0E1420)
                  : const Color(0xFFF8FAFD),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _isListening
                    ? const Color(0xFFFFC0C8)
                    : border,
              ),
            ),
            child: SelectableText(
              currentText,
              style: TextStyle(
                color: _liveText.isEmpty
                    ? sub
                    : text,
                fontSize: 16,
                height: 1.6,
                fontWeight: _liveText.isEmpty
                    ? FontWeight.w400
                    : FontWeight.w600,
              ),
            ),
          ),
          if (_status.isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(
              _status,
              style: TextStyle(
                color: sub,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExplanation(
    Color text,
    Color sub,
    Color border,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✦ AI EXPLAINED NATIVE CONCEPT',
            style: TextStyle(
              color: widget.isDarkMode
                  ? const Color(0xFFB9A5FF)
                  : const Color(0xFF7C65D6),
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: _VoiceAssistantLayout.explanationBoxMinHeight,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF111A27)
                  : const Color(0xFFF8FAFD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _nativeExplanation,
              style: TextStyle(
                color: text,
                fontSize: 14,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '▱ SUMMARIZED LEARNING CHEAT SHEET',
            style: TextStyle(
              color: sub,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 10),
          ..._cheatSheet(text, sub),
          const SizedBox(height: 20),
          Text(
            '▱ BILINGUAL TECHNICAL VOCABULARY CARD',
            style: TextStyle(
              color: sub,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 10),
          _buildVocabularyGrid(text, sub),
        ],
      ),
    );
  }

  List<Widget> _cheatSheet(Color text, Color sub) {
    final language = _currentLanguage;

    final lines = <String>[
      '${language.nativeName}: Your speech is converted into text as you speak.',
      'Selected locale: $_selectedLocaleId',
      'Partial results: ON — recognition updates before the final result.',
    ];

    return lines
        .map(
          (line) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF11251F)
                  : const Color(0xFFF1FBF7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isDarkMode
                    ? const Color(0xFF214B3E)
                    : const Color(0xFFD4F0E5),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF2AC48A),
                  size: 16,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    line,
                    style: TextStyle(
                      color: text,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildVocabularyGrid(Color text, Color sub) {
    final words = [
      ('Hooks', 'हुक्स / विशेष फ़ंक्शन'),
      ('State', 'स्थिति / डेटा स्टेट'),
      ('Side-Effect', 'साइड-इफेक्ट / बाहरी कार्य'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 550 ? 1 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: words.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: _VoiceAssistantLayout.vocabularyCardHeight,
          ),
          itemBuilder: (context, index) {
            final item = words[index];

            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: widget.isDarkMode
                    ? const Color(0xFF151C27)
                    : const Color(0xFFFAFBFD),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.isDarkMode
                      ? const Color(0xFF283244)
                      : const Color(0xFFE9EDF3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.$1,
                          style: TextStyle(
                            color: text,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          item.$2,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFFFF7A45),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _vocabularyDefinition(item.$1),
                    style: TextStyle(
                      color: sub,
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _vocabularyDefinition(String word) {
    switch (word) {
      case 'Hooks':
        return 'Functions that let functional components use React features.';
      case 'State':
        return 'Data managed inside a component.';
      default:
        return 'An operation that interacts with something outside the component.';
    }
  }

  Widget _buildQuickPrompts(
    Color text,
    Color sub,
    Color border,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '▱ TRY SANDBOX QUICK PROMPTS',
          style: TextStyle(
            color: sub,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 10),
        ..._quickPrompts.map(
          (prompt) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(13),
                onTap: () => _useQuickPrompt(prompt),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: _VoiceAssistantLayout.quickPromptHeight,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? const Color(0xFF151C29)
                        : const Color(0xFFF3F6FA),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          prompt,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: text,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: sub,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
    Color valueColor,
    Color card,
    Color text,
  ) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 135,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: card.withOpacity(widget.isDarkMode ? 0.55 : 0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isDarkMode
              ? const Color(0xFF3A3040)
              : Colors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: widget.isDarkMode
                  ? const Color(0xFF9AA5B7)
                  : const Color(0xFF8D97A9),
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(
    String label,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _VoiceLanguage {
  const _VoiceLanguage({
    required this.code,
    required this.nativeName,
    required this.subtitle,
    required this.locale,
    required this.flag,
  });

  final String code;
  final String nativeName;
  final String subtitle;
  final String locale;
  final String flag;
}
