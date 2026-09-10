import 'package:flutter/material.dart';
import '../app_page_transition.dart';

class CollegeAdminDashboardScreen extends StatefulWidget {
  final String collegeName;
  final String adminName;

  const CollegeAdminDashboardScreen({
    super.key,
    this.collegeName = 'MIT INNOVATION CAMPUS',
    this.adminName = 'Abhijeet Sahu',
  });

  @override
  State<CollegeAdminDashboardScreen> createState() => _CollegeAdminDashboardScreenState();
}

class Student {
  String name, email, dept, grad, track;
  int score;
  Student(this.name, this.email, this.dept, this.grad, this.track, this.score);
}

class Notice {
  String category, target, title, body, author, date;
  bool pinned;
  Notice(this.category, this.target, this.title, this.body, this.author, this.date, {this.pinned=false});
}

class _CollegeAdminDashboardScreenState extends State<CollegeAdminDashboardScreen> {
  int tab = 0;
  bool dark = false, collapsed = false;
  bool pii = true, zeroRetention = true, lockdown = true, clipboard = true, watermark = true;
  int similarity = 70;
  String retention = '3 Years', sso = 'Azure AD', mfa = 'Mandatory for All';
  String aiMode = 'Socratic Hints (Recommended)', webcam = 'Every 30s (Balanced)';
  String dept = 'All Departments', grad = 'All Grad Years';
  String annFilter = 'All', annSearch = '';
  bool importer = false, pinNew = false;
  final search = TextEditingController();
  final annSearchCtl = TextEditingController();
  final annTitle = TextEditingController();
  final annBody = TextEditingController();
  final annAuthor = TextEditingController(text: 'College Dean & Academic Office');
  final csv = TextEditingController();

  final students = <Student>[
    Student('Abhijeet Sahu','abhijeetsahu7978@gmail.com','Computer Science','2026','Web Development',88),
    Student('Sarah Connor','sconnor@mit.edu','Computer Science','2026','Python & AI',95),
    Student('Bruce Wayne','bwayne@stanford.edu','Electrical Eng','2027','Systems C++',92),
    Student('Tony Stark','tstark@stark.edu','Computer Science','2026','Python & AI',90),
    Student('Diana Prince','dprince@stanford.edu','Information Tech','2027','Web Development',90),
  ];

  final notices = <Notice>[
    Notice('Event','All','📢 Official Campus Hackathon 2026 & Innovation Challenge',
      'Team up across branches to build real-world AI & Full-Stack solutions. Cash prizes of up to \$10,000, cloud infrastructure credits, and direct placement interview passes to be awarded. All students and instructors are invited to register.',
      'College Dean & Academic Office','July 24, 2026',pinned:true),
    Notice('Academic','All','🎓 Mid-Term Examination Schedule & Proctoring Rules',
      'Mid-term examination gates open next Monday. Please ensure webcam feed permissions and single-browser tabs during Sophia AI assessment sessions. Instructors must submit question banks by Friday 5:00 PM.',
      'Examination Controller - MIT Campus','July 20, 2026',pinned:true),
    Notice('System','Students','⚡ Campus High-Speed GPU Server Maintenance Notice',
      'The institutional AI model training GPU clusters will undergo scheduled maintenance this Sunday between 2:00 AM and 5:00 AM IST. Compiler sandboxes will run in offline lightweight mode.',
      'IT Infrastructure & Cloud Ops','July 16, 2026'),
    Notice('Placement','Students','💼 Placement Drive: Google & Microsoft On-Campus Interviews',
      'Shortlisted candidates from Computer Science and IT with Level 03+ milestone verifications must submit updated resumes before the portal deadline.',
      'Career Development & Placement Cell','July 12, 2026'),
  ];

  final proctor = <Map<String,dynamic>>[
    {'sev':'Low','time':'Today, 10:42 AM','student':'Abhijeet Sahu','note':'Browser tab focus shifted out for 4 seconds during Python loop quiz.','done':false},
    {'sev':'High','time':'Yesterday, 3:15 PM','student':'Sarah Connor','note':'Attempted external clipboard paste into coding challenge container.','done':false},
    {'sev':'Medium','time':'Yesterday, 11:20 AM','student':'Bruce Wayne','note':'Second silhouette registered in proctor webcam path.','done':true},
    {'sev':'High','time':'July 15, 2026','student':'Tony Stark','note':'Webcam stream blacked out or lens covered during gate test.','done':true},
  ];

  final nodes = <Map<String,dynamic>>[
    {'n':'01','title':'Web Foundations & ES6+','desc':'Asynchronous JS, Event Loop, Closures, Scopes, and ES6 Modules.','abet':'ABET-SO-1','hours':'15 Hours','gate':'80% DOM Sprint Score','status':'UNLOCKED','color':Color(0xFF00BD80),'tags':['Closures & Scopes','Promises & Async/Await','DOM Performance']},
    {'n':'02','title':'React 18 & State Architecture','desc':'Virtual DOM reconciliation, useEffect rules, Context API, and Tailwind CSS.','abet':'ABET-SO-2','hours':'25 Hours','gate':'85% Proctored Component Test','status':'UNLOCKED','color':Color(0xFF00BD80),'tags':['Custom Hooks','State Normalization','Tailwind Design System']},
    {'n':'03','title':'Backend REST APIs & PostgreSQL','desc':'Relational database schema, migrations, indexing, and token authentication.','abet':'ABET-SO-2','hours':'30 Hours','gate':'80% API Coding Gate','status':'GATE REQUIRED','color':Color(0xFFFFAA16),'tags':['Express Routing','PostgreSQL Schemas','JWT Auth Middleware']},
    {'n':'04','title':'Cloud Deployment & Docker CI/CD','desc':'Packaging Node applications, multi-stage builds, reverse proxies, and deployment.','abet':'ABET-SO-6','hours':'20 Hours','gate':'Docker Container Verification','status':'LOCKED','color':Color(0xFF9AA0AA),'tags':['Dockerfiles','GitHub Actions CI/CD','Nginx Proxy Setup']},
    {'n':'05','title':'AI Integration & System Capstone','desc':'Integrating LLM endpoints, prompt engineering, vector search, and final faculty presentation.','abet':'ABET-SO-3','hours':'40 Hours','gate':'Faculty Committee Defense Approval','status':'LOCKED','color':Color(0xFF9AA0AA),'tags':['Gemini AI SDK','Vector Embeddings','System Architecture Capstone']},
  ];

  Color get bg => dark ? const Color(0xFF11131A) : const Color(0xFFF5F7FB);
  Color get card => dark ? const Color(0xFF171A23) : Colors.white;
  Color get alt => dark ? const Color(0xFF1E222C) : const Color(0xFFF8F9FC);
  Color get border => dark ? const Color(0xFF30343F) : const Color(0xFFE4E7EE);
  Color get text => dark ? Colors.white : const Color(0xFF14161D);
  Color get muted => dark ? const Color(0xFF9BA1B2) : const Color(0xFF697386);

  @override
  void dispose() {
    search.dispose(); annSearchCtl.dispose(); annTitle.dispose(); annBody.dispose(); annAuthor.dispose(); csv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3:true,fontFamily:'Arial',brightness:dark?Brightness.dark:Brightness.light,
        scaffoldBackgroundColor:bg,colorScheme:ColorScheme.fromSeed(seedColor:const Color(0xFF7827FF),brightness:dark?Brightness.dark:Brightness.light)),
      child: Scaffold(backgroundColor:bg,body:SafeArea(child:Row(children:[
        _sidebar(),
        Expanded(child:Column(children:[
          _topbar(),
          Expanded(child:AppPageTransition(pageKey:tab,child:_content())),
        ])),
      ]))),
    );
  }

  Widget _sidebar() {
    final labels=['Command Center','Control & Compliance','User Directory & CSV','Curriculum & Roadmaps','Campus Announcements','Audit & Proctoring'];
    final icons=[Icons.bar_chart_rounded,Icons.verified_user_outlined,Icons.people_outline_rounded,Icons.explore_outlined,Icons.campaign_outlined,Icons.shield_outlined];
    return AnimatedContainer(duration:const Duration(milliseconds:240),width:collapsed?78:268,color:card,
      child:Column(children:[
        SizedBox(height:90,child:Padding(padding:EdgeInsets.symmetric(horizontal:collapsed?12:18),child:Row(children:[
          _logo(), if(!collapsed)...[const SizedBox(width:10),const Expanded(child:Text.rich(TextSpan(children:[
            TextSpan(text:'Next Gen ',style:TextStyle(color:Color(0xFF35C987),fontWeight:FontWeight.w800)),
            TextSpan(text:'LMS',style:TextStyle(color:Color(0xFFFF5E68),fontWeight:FontWeight.w800)),
          ]),style:TextStyle(fontSize:19))),_iconBtn(Icons.chevron_left_rounded,()=>setState(()=>collapsed=true))],
        ]))),
        Divider(height:1,color:border),
        Expanded(child:ListView.builder(padding:const EdgeInsets.only(top:16),itemCount:labels.length,itemBuilder:(c,i){
          final active=i==tab;
          return Padding(padding:const EdgeInsets.symmetric(horizontal:7,vertical:2),child:InkWell(onTap:()=>setState(()=>tab=i),child:Container(height:54,
            padding:EdgeInsets.symmetric(horizontal:collapsed?14:18),
            decoration:BoxDecoration(color:active?(dark?const Color(0xFF20232D):const Color(0xFFFAFBFD)):Colors.transparent,
              border:Border(left:BorderSide(color:active?const Color(0xFF3475FF):Colors.transparent,width:3))),
            child:Row(children:[Icon(icons[i],size:22,color:active?const Color(0xFFFF4652):const Color(0xFF737D90)),
              if(!collapsed)...[const SizedBox(width:14),Expanded(child:Text(labels[i],maxLines:2,style:TextStyle(color:active?const Color(0xFFFF4652):muted,fontSize:15.5,fontWeight:active?FontWeight.w600:FontWeight.w500)))],
            ]))));})),
        Divider(height:1,color:border),
        _bottom(Icons.person_outline_rounded,'My Profile'),_bottom(Icons.settings_outlined,'Settings'),_bottom(Icons.logout_rounded,'Sign Out',danger:true,onTap:_signout),
        const SizedBox(height:10),
      ]));
  }

  Widget _logo()=>Container(width:42,height:42,decoration:BoxDecoration(color:const Color(0xFF35C987),borderRadius:BorderRadius.circular(13)),alignment:Alignment.center,child:const Text('N',style:TextStyle(color:Colors.white,fontSize:21,fontWeight:FontWeight.w800)));
  Widget _bottom(IconData i,String s,{bool danger=false,VoidCallback? onTap})=>Padding(padding:const EdgeInsets.symmetric(horizontal:17,vertical:3),child:InkWell(onTap:onTap??()=>_msg('$s selected'),child:SizedBox(height:43,child:Row(children:[Icon(i,size:22,color:danger?const Color(0xFFFF4652):const Color(0xFF747D90)),if(!collapsed)...[const SizedBox(width:15),Text(s,style:TextStyle(color:danger?const Color(0xFFFF4652):muted,fontSize:15.5))]]))));
  Widget _iconBtn(IconData i,VoidCallback f)=>Material(color:dark?const Color(0xFF22252E):const Color(0xFFF5F7FB),borderRadius:BorderRadius.circular(14),child:InkWell(onTap:f,borderRadius:BorderRadius.circular(14),child:SizedBox(width:47,height:47,child:Icon(i,color:muted,size:23))));

  Widget _topbar()=>Container(height:90,padding:const EdgeInsets.symmetric(horizontal:26),decoration:BoxDecoration(color:card,border:Border(bottom:BorderSide(color:border))),child:Row(children:[
    if(collapsed)...[_iconBtn(Icons.chevron_right_rounded,()=>setState(()=>collapsed=false)),const SizedBox(width:18)],
    Expanded(child:Container(constraints:const BoxConstraints(maxWidth:650),height:49,decoration:BoxDecoration(color:dark?const Color(0xFF22252E):const Color(0xFFF4F6FA),borderRadius:BorderRadius.circular(28)),child:TextField(decoration:InputDecoration(hintText:'Search courses, projects, concepts...',hintStyle:TextStyle(color:muted,fontSize:16),prefixIcon:Icon(Icons.search,color:muted),border:InputBorder.none)))),
    const Spacer(),_iconBtn(dark?Icons.light_mode_outlined:Icons.dark_mode_outlined,()=>setState(()=>dark=!dark)),const SizedBox(width:12),
    Stack(children:[_iconBtn(Icons.notifications_none_rounded,()=>_msg('You have 2 unresolved proctor flags')),const Positioned(right:9,top:7,child:CircleAvatar(radius:4,color:Color(0xFFFF5962)))]),
    const SizedBox(width:15),CircleAvatar(radius:21,backgroundColor:const Color(0xFFFF626A),child:Text(_initials(widget.adminName),style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w800))),
    const SizedBox(width:10),if(MediaQuery.sizeOf(context).width>900)Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[
      Text(widget.adminName,style:TextStyle(color:text,fontSize:14,fontWeight:FontWeight.w700)),const Text('College Admin',style:TextStyle(color:Color(0xFFFF4652),fontSize:12,fontWeight:FontWeight.w600))
    ]),Icon(Icons.keyboard_arrow_down_rounded,color:muted)
  ]));

  Widget _content()=>Container(color:bg,child:tab==0?_command():tab==1?_compliance():tab==2?_directory():tab==3?_curriculum():tab==4?_announcements():_audit());

  Widget _scroll(Widget w)=>LayoutBuilder(builder:(c,x)=>SingleChildScrollView(padding:EdgeInsets.fromLTRB(x.maxWidth<900?20:45,26,x.maxWidth<900?20:45,50),child:w));

  Widget _tabs()=>SizedBox(height:49,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:6,separatorBuilder:(_,__)=>const SizedBox(width:8),itemBuilder:(c,i){
    final names=['Command Center','Control & Compliance','Student Directory','Curriculum Roadmaps','Campus Notices','Proctor Audit'];
    final icons=[Icons.tune_rounded,Icons.verified_user_outlined,Icons.people_outline_rounded,Icons.menu_book_outlined,Icons.campaign_outlined,Icons.shield_outlined];
    final active=i==tab;
    return Material(color:active?const Color(0xFF7827FF):card,borderRadius:BorderRadius.circular(13),child:InkWell(onTap:()=>setState(()=>tab=i),child:Container(padding:const EdgeInsets.symmetric(horizontal:17),decoration:BoxDecoration(borderRadius:BorderRadius.circular(13),border:Border.all(color:active?const Color(0xFF7827FF):border)),child:Row(children:[
      Icon(icons[i],size:17,color:active?Colors.white:(i==5?const Color(0xFFFF4350):muted)),const SizedBox(width:8),Text(names[i],style:TextStyle(color:active?Colors.white:text,fontSize:13.5,fontWeight:FontWeight.w700)),
      if(i==1||i==5)...[const SizedBox(width:8),_pill(i==1?'99.4%':'2',i==5?const Color(0xFFFF4350):const Color(0xFF00B96B))]
    ]))));
  }));

  Widget _command()=>_scroll(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    _header(),const SizedBox(height:27),_tabs(),const SizedBox(height:28),_metrics(),const SizedBox(height:28),
    LayoutBuilder(builder:(c,x){final a=_panel('AI HR Mock Interview Analytics','Aggregate scores from student mock recordings.',Column(children:[
      _progress('Technical Depth',88.5,const Color(0xFF7C3DFF)),const SizedBox(height:17),_progress('Behavioral Delivery',92.1,const Color(0xFF00C968)),const SizedBox(height:17),_progress('System Design Comprehension',81.4,const Color(0xFFFF9900)),const SizedBox(height:22),_callout('Sophia AI Placement-Engine predicts a +14% rise in CS-A cohort selections in upcoming recruiting drives.')
    ]));final b=_panel('Departmental Placement-Readiness Breakdown','Overall assessment levels and code scores mapped to student classes.',Column(children:[
      Row(children:[Expanded(child:_score('COMPUTER SCIENCE','94.8%','45 students tested',const Color(0xFF7C3DFF))),const SizedBox(width:12),Expanded(child:_score('ELECTRICAL ENG','88.2%','18 students tested',const Color(0xFFFF9900))),const SizedBox(width:12),Expanded(child:_score('INFORMATION TECH','91.5%','24 students tested',const Color(0xFF00B980)))]),const SizedBox(height:20),Align(alignment:Alignment.centerLeft,child:Text('UPCOMING INSTITUTIONAL PLACEMENTS DRIVE (JULY 2026)',style:TextStyle(color:muted,fontSize:10,fontWeight:FontWeight.w800))),const SizedBox(height:10),Row(children:[Expanded(child:_date('Google Campus Drive','July 20')),const SizedBox(width:10),Expanded(child:_date('Stripe API Engineer Drive','July 24'))])
    ]));return x.maxWidth<950?Column(children:[a,const SizedBox(height:20),b]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:4,child:a),const SizedBox(width:20),Expanded(flex:6,child:b)]);}),const SizedBox(height:25),_placements()
  ]));

  Widget _header()=>Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    _badge('🎓 COLLEGE ADMIN DASHBOARD',const Color(0xFFE4F0FF),const Color(0xFF1764D8)),const SizedBox(height:10),
    Text('Institutional Control & Compliance',style:TextStyle(color:text,fontSize:31,fontWeight:FontWeight.w800)),const SizedBox(height:5),
    Text('Monitor student placement readiness, bulk upload accounts, customize gamified course paths, and review proctoring flags.',style:TextStyle(color:muted,fontSize:15.5))
  ])),const SizedBox(width:20),Container(margin:const EdgeInsets.only(top:38),padding:const EdgeInsets.symmetric(horizontal:18,vertical:12),decoration:BoxDecoration(color:dark?const Color(0xFF2B2020):const Color(0xFFFFF1EA),border:Border.all(color:dark?const Color(0xFF633E35):const Color(0xFFFFC9B1)),borderRadius:BorderRadius.circular(24)),child:Row(children:[const Icon(Icons.school_outlined,color:Color(0xFFFF783A)),const SizedBox(width:8),Text(widget.collegeName,style:TextStyle(color:text,fontWeight:FontWeight.w700,fontSize:12.5))]))]);

  Widget _badge(String s,Color b,Color f)=>Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:7),decoration:BoxDecoration(color:b,borderRadius:BorderRadius.circular(18)),child:Text(s,style:TextStyle(color:f,fontSize:10,fontWeight:FontWeight.w800,letterSpacing:.6)));
  Widget _pill(String s,Color c)=>Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),decoration:BoxDecoration(color:c.withOpacity(.12),borderRadius:BorderRadius.circular(10)),child:Text(s,style:TextStyle(color:c,fontSize:9,fontWeight:FontWeight.w800)));

  Widget _metrics()=>LayoutBuilder(builder:(c,x){final data=[
    ['TOTAL ENROLLED SEATS','5 Registered','Tap for enrolled list',Color(0xFF7A28FF),Icons.people_alt_outlined],
    ['PLACEMENT-READINESS SCORE','92.8%','Tap for score details',Color(0xFF00BD68),Icons.workspace_premium_outlined],
    ['INSTRUCTOR PERFORMANCE','98.1%\nResponse','Tap for faculty details',Color(0xFFFF9900),Icons.trending_up_rounded],
    ['PROCTOR FLAGS ACTIVE','${proctor.where((p)=>!(p['done'] as bool)).length} Unresolved','Tap to resolve flags',Color(0xFFFF3E50),Icons.gpp_bad_outlined],
  ];final n=x.maxWidth>1100?4:2;return GridView.count(crossAxisCount:n,crossAxisSpacing:20,mainAxisSpacing:20,childAspectRatio:n==4?2.05:2.3,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),children:data.map((d)=>_metric(d[0] as String,d[1] as String,d[2] as String,d[3] as Color,d[4] as IconData)).toList());});

  Widget _metric(String t,String v,String a,Color c,IconData i)=>InkWell(onTap:()=>_msg(a),child:Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(17)),child:Row(children:[Container(width:53,height:53,decoration:BoxDecoration(color:c.withOpacity(.12),borderRadius:BorderRadius.circular(14)),child:Icon(i,color:c,size:27)),const SizedBox(width:16),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Text(t,style:TextStyle(color:muted,fontSize:10,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(v,style:TextStyle(color:v.contains('Unresolved')?c:text,fontSize:24,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(a,style:TextStyle(color:c,fontSize:10.5,fontWeight:FontWeight.w800))]))]));

  Widget _panel(String t,String s,Widget child)=>Container(padding:const EdgeInsets.all(26),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:TextStyle(color:text,fontSize:17,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(s,style:TextStyle(color:muted,fontSize:11.5)),const SizedBox(height:24),child]));
  Widget _progress(String s,double v,Color c)=>Column(children:[Row(children:[Expanded(child:Text(s,style:TextStyle(color:muted,fontSize:12))),Text('${v.toStringAsFixed(1)}%',style:TextStyle(color:c,fontSize:11,fontWeight:FontWeight.w800))]),const SizedBox(height:7),ClipRRect(borderRadius:BorderRadius.circular(8),child:LinearProgressIndicator(value:v/100,minHeight:8,backgroundColor:dark?const Color(0xFF30343D):const Color(0xFFE9ECF1),valueColor:AlwaysStoppedAnimation(c)))]);
  Widget _callout(String s)=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:dark?const Color(0xFF122A24):const Color(0xFFF0FCF7),borderRadius:BorderRadius.circular(15)),child:Row(children:[const Icon(Icons.auto_awesome,color:Color(0xFF00B96B),size:18),const SizedBox(width:9),Expanded(child:Text(s,style:TextStyle(color:muted,fontSize:11.5)))]));
  Widget _score(String a,String b,String c,Color col)=>Container(height:135,decoration:BoxDecoration(border:Border.all(color:dark?const Color(0xFF666A74):const Color(0xFF5D626B)),borderRadius:BorderRadius.circular(16)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text(a,style:TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800)),const SizedBox(height:7),Text(b,style:TextStyle(color:col,fontSize:27,fontWeight:FontWeight.w800)),Text(c,style:TextStyle(color:muted,fontSize:10))]));
  Widget _date(String s,String d)=>Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:alt,border:Border.all(color:border),borderRadius:BorderRadius.circular(12)),child:Row(children:[Expanded(child:Text(s,style:TextStyle(color:text,fontSize:10.5,fontWeight:FontWeight.w700))),_pill(d,const Color(0xFF7C3DFF))]));
  Widget _placements()=>_panel('UPCOMING INSTITUTIONAL PLACEMENTS (JULY 2026)','',Row(children:[Expanded(child:_date('AI / ML Engineering','18 shortlisted')),const SizedBox(width:12),Expanded(child:_date('Backend & Cloud','11 shortlisted')),const SizedBox(width:12),Expanded(child:_date('Full-Stack Development','9 shortlisted'))]));

  Widget _compliance()=>_scroll(Column(children:[_tabs(),const SizedBox(height:28),_darkHero(),const SizedBox(height:28),LayoutBuilder(builder:(c,x){final l=Column(children:[_privacy(),const SizedBox(height:20),_sso()]);final r=Column(children:[_ai(),const SizedBox(height:20),_security()]);return x.maxWidth<1000?Column(children:[l,const SizedBox(height:20),r]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:l),const SizedBox(width:20),Expanded(child:r)]);}),const SizedBox(height:20),_auditTable()]));
  Widget _darkHero()=>Container(width:double.infinity,padding:const EdgeInsets.all(34),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF263D98),Color(0xFF10162F)]),borderRadius:BorderRadius.circular(27)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[_darkBadge('🛡 ISO 27001 & FERPA COMPLIANT',const Color(0xFF00D49A)),const SizedBox(width:9),_darkBadge('SOC-2 TYPE II CERTIFIED',const Color(0xFFB69BFF))]),
    const SizedBox(height:17),const Text('Institutional Governance & Compliance Controls',style:TextStyle(color:Colors.white,fontSize:29,fontWeight:FontWeight.w800)),
    const SizedBox(height:8),Text('Configure university-wide security mandates, FERPA data privacy policies, AI tutor guardrails, single sign-on (SSO), and ABET/NAAC accreditation tracking.',style:TextStyle(color:Colors.white70,fontSize:14.5,height:1.45)),
    const SizedBox(height:20),Wrap(spacing:10,runSpacing:10,children:[_heroStat('OVERALL SECURITY RATING','99.4% (Tier A+)',Color(0xFF00D49A)),_heroStat('FERPA PII ISOLATION','Enforced & Active',Color(0xFFB69BFF)),_heroStat('AI ZERO RETENTION','Contract Active',Color(0xFF5FA5FF)),_heroStat('SAML 2.0 / SSO IDP',sso,Color(0xFFFFC61A))])
  ]));
  Widget _darkBadge(String s,Color c)=>Container(padding:const EdgeInsets.symmetric(horizontal:11,vertical:6),decoration:BoxDecoration(color:c.withOpacity(.12),border:Border.all(color:c.withOpacity(.3)),borderRadius:BorderRadius.circular(16)),child:Text(s,style:TextStyle(color:c,fontSize:9,fontWeight:FontWeight.w800)));
  Widget _heroStat(String a,String b,Color c)=>Container(width:200,padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:Colors.white.withOpacity(.06),border:Border.all(color:Colors.white12),borderRadius:BorderRadius.circular(14)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(a,style:const TextStyle(color:Colors.white60,fontSize:9,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(b,style:TextStyle(color:c,fontSize:16,fontWeight:FontWeight.w800))]));

  Widget _privacy()=>_settings('FERPA & GDPR Student Privacy Governance','Institutional record retention and PII encryption mandates.',[
    _label('Student Record Retention Policy'),_choices(['1 Year','3 Years','5 Years','7 Years (Standard)'],retention,(v)=>setState(()=>retention=v)),
    _toggle('Automatic PII Masking in Instructor Views','Masks student phone numbers, personal emails, and social security numbers across faculty dashboards.',pii,(v)=>setState(()=>pii=v)),
    _toggle('AI Vendor Zero Data Retention Guarantee','Prevents AI suppliers from storing or training models on student submissions.',zeroRetention,(v)=>setState(()=>zeroRetention=v)),
    _label('GDPR / FERPA Subject Access Request (SAR) Data Exporter'),Row(children:[Expanded(child:_input('Enter Student Name or ID...')),const SizedBox(width:8),FilledButton(onPressed:()=>_msg('Generating export'),child:const Text('Generate Export'))])
  ],Icons.storage_outlined,Color(0xFF7C3DFF));
  Widget _ai()=>_settings('AI Ethics, Plagiarism & Integrity Controls','Manage code similarity thresholds and AI Tutor boundaries.',[
    Row(children:[Expanded(child:_label('Code Similarity Auto-Flag Threshold')),Text('$similarity% Similarity',style:const TextStyle(color:Color(0xFF7C3DFF),fontSize:10,fontWeight:FontWeight.w800))]),
    Slider(value:similarity.toDouble(),min:40,max:95,activeColor:const Color(0xFF7827FF),onChanged:(v)=>setState(()=>similarity=v.round())),
    Text('Submissions exceeding $similarity% structural code match across student repositories will be flagged for review.',style:TextStyle(color:muted,fontSize:10.5)),
    _label('AI Tutor Assistance Level Policy'),_choices(['Socratic Hints (Recommended)','Debugging Only','Full Synthesis','Exam Lockout'],aiMode,(v)=>setState(()=>aiMode=v)),
    _toggle('Block Direct Graded Answers','Prohibits AI Tutor from producing exact solution code for graded assignments or homework.',clipboard,(v)=>setState(()=>clipboard=v)),
    _toggle('Synthetic Code Metadata Watermarking','Embeds cryptographic markers into AI-suggested code snippets to verify originality during audits.',watermark,(v)=>setState(()=>watermark=v)),
  ],Icons.auto_awesome_outlined,Color(0xFF5555FF));
  Widget _sso()=>_settings('Institutional Single Sign-On (SSO) & Role Matrix','Authentication providers and role-based privilege mappings.',[
    _label('Active Enterprise Identity Provider (IdP)'),_choices(['Azure AD','Okta SAML','Google Workspace','Shibboleth'],sso,(v)=>setState(()=>sso=v)),
    _label('Multi-Factor Authentication (MFA) Policy'),_choices(['Mandatory for All','Faculty/Admin Only','Optional'],mfa,(v)=>setState(()=>mfa=v)),
    _label('Role Permissions Matrix Overview'),_matrix()
  ],Icons.key_outlined,Color(0xFF2D6DFF));
  Widget _security()=>_settings('Proctoring & Exam Security Mandatory Standards','Lockdown browser policies and live biometric webcam enforcement.',[
    _toggle('Mandatory Lockdown Browser Enforcement','Locks browser in full-screen mode, blocking window switching or unapproved browser extensions.',lockdown,(v)=>setState(()=>lockdown=v)),
    _toggle('Block Clipboard & Copy-Paste','Disables keyboard copy/paste shortcuts and right-click context menus during proctored tests.',clipboard,(v)=>setState(()=>clipboard=v)),
    _label('AI Webcam Biometric Sampling Interval'),_choices(['Every 15s (Strict)','Every 30s (Balanced)','Every 60s (Standard)'],webcam,(v)=>setState(()=>webcam=v))
  ],Icons.gpp_bad_outlined,Color(0xFFFF4350));

  Widget _settings(String title,String sub,List<Widget> children,IconData icon,Color accent)=>Container(padding:const EdgeInsets.all(25),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Container(width:43,height:43,decoration:BoxDecoration(color:accent.withOpacity(.12),borderRadius:BorderRadius.circular(13)),child:Icon(icon,color:accent)),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:TextStyle(color:text,fontSize:16,fontWeight:FontWeight.w800)),Text(sub,style:TextStyle(color:muted,fontSize:10.5))]))]),const SizedBox(height:15),Divider(color:border),const SizedBox(height:15),...children.map((w)=>Padding(padding:const EdgeInsets.only(bottom:14),child:w))]));
  Widget _label(String s)=>Padding(padding:const EdgeInsets.only(bottom:7),child:Text(s,style:TextStyle(color:text,fontSize:11,fontWeight:FontWeight.w800)));
  Widget _choices(List<String> xs,String selected,ValueChanged<String> f)=>Wrap(spacing:7,runSpacing:7,children:xs.map((s)=>InkWell(onTap:()=>f(s),child:Container(padding:const EdgeInsets.symmetric(horizontal:13,vertical:12),decoration:BoxDecoration(color:s==selected?const Color(0xFF7827FF):alt,border:Border.all(color:s==selected?const Color(0xFF7827FF):border),borderRadius:BorderRadius.circular(13)),child:Text(s,style:TextStyle(color:s==selected?Colors.white:text,fontSize:10,fontWeight:FontWeight.w700))))).toList());
  Widget _toggle(String title,String sub,bool value,ValueChanged<bool> f)=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:alt,border:Border.all(color:border),borderRadius:BorderRadius.circular(16)),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:TextStyle(color:text,fontSize:11,fontWeight:FontWeight.w800)),Text(sub,style:TextStyle(color:muted,fontSize:10,height:1.3))])),Switch.adaptive(value:value,activeColor:const Color(0xFF00BF84),onChanged:f)]));
  Widget _input(String hint,{TextEditingController? controller})=>TextField(controller:controller,style:TextStyle(color:text,fontSize:11),decoration:InputDecoration(hintText:hint,hintStyle:TextStyle(color:muted,fontSize:11),filled:true,fillColor:alt,border:OutlineInputBorder(borderRadius:BorderRadius.circular(13),borderSide:BorderSide(color:border))));
  Widget _matrix()=>Table(columnWidths:const{0:FlexColumnWidth(1.6),1:FlexColumnWidth(.7),2:FlexColumnWidth(.8),3:FlexColumnWidth(.7),4:FlexColumnWidth(.7),5:FlexColumnWidth(.7)},children:[
    _tr(['Role','Roster','Curriculum','Export','Proctor','Policy'],head:true),...[
      ['Super Admin','✓','✓','✓','✓','✓'],['Academic Dean','✓','✓','✓','✓','—'],['Instructor','✓','✓','—','✓','—'],['Exam Proctor','—','—','—','✓','—']
    ].map((r)=>_tr(r))
  ]);
  TableRow _tr(List<String> r,{bool head=false})=>TableRow(children:r.map((v)=>Padding(padding:const EdgeInsets.symmetric(vertical:6),child:Text(v,textAlign:v==r[0]?TextAlign.left:TextAlign.center,style:TextStyle(color:head?muted:(v=='✓'?const Color(0xFF00B96B):text),fontSize:9.5,fontWeight:FontWeight.w700)))).toList());

  Widget _auditTable()=>_panel('Real-Time Institutional Audit Trail & Compliance Log','Immutable ledger of administrative actions, policy edits, and security events.',SingleChildScrollView(scrollDirection:Axis.horizontal,child:DataTable(columns:const[DataColumn(label:Text('TIMESTAMP')),DataColumn(label:Text('ADMINISTRATOR')),DataColumn(label:Text('CATEGORY')),DataColumn(label:Text('ACTION DESCRIPTION')),DataColumn(label:Text('STATUS'))],rows:[
    ['2026-07-27 04:30','Director Alan Turing','FERPA / Privacy','Updated PII Masking policy to Enforced','Verified'],
    ['2026-07-27 02:15','Dean Ada Lovelace','AI Ethics','Set AI Plagiarism similarity flag threshold to 70%','Active'],
    ['2026-07-26 18:40','System Security Bot','SSO / Auth','Synchronized 1,420 Azure AD campus user accounts','Success'],
    ['2026-07-26 14:10','Director Alan Turing','Proctoring','Enforced Lockdown Browser & Clipboard Block for Batch 2026','Enforced'],
    ['2026-07-25 09:20','Registrar Office','Data Request','Fulfilled GDPR Subject Access Data Export for Student #101','Completed'],
  ].map((r)=>DataRow(cells:r.map((v)=>DataCell(Text(v,style:TextStyle(color:text,fontSize:9.5)))).toList()).toList()));

  Widget _directory()=>_scroll(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    _tabs(),const SizedBox(height:23),Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Institutional Student & Staff Directory',style:TextStyle(color:text,fontSize:20,fontWeight:FontWeight.w800)),Text('Filter by department, perform multi-row batch actions, export CSV datasets, or upload spreadsheet files.',style:TextStyle(color:muted,fontSize:11.5))])),OutlinedButton.icon(onPressed:()=>_msg('CSV template download prepared'),icon:const Icon(Icons.download,size:14),label:const Text('Download CSV Template')),const SizedBox(width:8),FilledButton.icon(onPressed:()=>setState(()=>importer=!importer),icon:const Icon(Icons.cloud_upload_outlined,size:14),label:Text(importer?'Close Import Utility':'CSV Bulk Import Engine'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFFFF7A30)))])
    ,const SizedBox(height:20),_directoryMetrics(),if(importer)...[const SizedBox(height:18),_csvWorkspace()],const SizedBox(height:18),_toolbar(),const SizedBox(height:18),
    LayoutBuilder(builder:(c,x)=>x.maxWidth<1050?Column(children:[_studentTable(),const SizedBox(height:18),_addStudent()]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:7,child:_studentTable()),const SizedBox(width:22),Expanded(flex:3,child:_addStudent())]))
  ]));
  Widget _directoryMetrics()=>GridView.count(crossAxisCount:4,crossAxisSpacing:14,childAspectRatio:2.5,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),children:[
    _mini('TOTAL ENROLLED','5 Learners',Color(0xFF7C3DFF)),_mini('AVG SCORE','91%',Color(0xFF00B98A)),_mini('ACTIVE TRACKS','3 Tracks',Color(0xFFFF9900)),_mini('CSV BATCH DRAFTS','0 Draft Rows',Color(0xFF3475FF))
  ]);
  Widget _mini(String a,String b,Color c)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(17)),child:Row(children:[Container(width:45,height:45,decoration:BoxDecoration(color:c.withOpacity(.1),borderRadius:BorderRadius.circular(12)),child:Icon(Icons.people_outline,color:c)),const SizedBox(width:12),Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Text(a,style:TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800)),Text(b,style:TextStyle(color:c==const Color(0xFF00B98A)?c:text,fontSize:20,fontWeight:FontWeight.w800))])]));
  Widget _csvWorkspace()=>Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:dark?const Color(0xFF2D2418):const Color(0xFFFFF8EC),border:Border.all(color:const Color(0xFFFFC766)),borderRadius:BorderRadius.circular(20)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('CSV Spreadsheet Bulk Ingestion Engine',style:TextStyle(color:text,fontSize:15,fontWeight:FontWeight.w800)),const SizedBox(height:8),Row(children:[Expanded(child:TextField(controller:csv,maxLines:5,style:TextStyle(color:text,fontSize:10),decoration:InputDecoration(hintText:'Name, Email, Department, Grad Year, Track',filled:true,fillColor:card,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14))))),const SizedBox(width:14),Column(children:[FilledButton(onPressed:()=>_msg('CSV buffer parsed'),child:const Text('Parse CSV Buffer')),const SizedBox(height:8),Text('0 Draft Rows',style:TextStyle(color:muted,fontSize:10))])])]));
  Widget _toolbar()=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(19)),child:Row(children:[Expanded(child:TextField(controller:search,onChanged:(_)=>setState((){}),decoration:InputDecoration(prefixIcon:Icon(Icons.search,color:muted),hintText:'Search student directory by name, email or ID...',filled:true,fillColor:alt,border:OutlineInputBorder(borderRadius:BorderRadius.circular(13))))),const SizedBox(width:8),_drop(dept,['All Departments','Computer Science','Electrical Eng','Information Tech'],(v)=>setState(()=>dept=v)),const SizedBox(width:8),_drop(grad,['All Grad Years','2026','2027','2028'],(v)=>setState(()=>grad=v)),const SizedBox(width:8),OutlinedButton.icon(onPressed:()=>_msg('Export CSV'),icon:const Icon(Icons.download,size:14),label:const Text('Export CSV'))]));
  Widget _drop(String v,List<String> xs,ValueChanged<String> f)=>Container(height:46,padding:const EdgeInsets.symmetric(horizontal:9),decoration:BoxDecoration(color:alt,border:Border.all(color:border),borderRadius:BorderRadius.circular(12)),child:DropdownButtonHideUnderline(child:DropdownButton<String>(value:v,items:xs.map((e)=>DropdownMenuItem(value:e,child:Text(e,style:TextStyle(color:text,fontSize:10)))).toList(),onChanged:(x){if(x!=null)f(x);}})));
  Widget _studentTable(){final q=search.text.toLowerCase();final list=students.where((s)=>(q.isEmpty||s.name.toLowerCase().contains(q)||s.email.toLowerCase().contains(q))&&(dept=='All Departments'||s.dept==dept)&&(grad=='All Grad Years'||s.grad==grad)).toList();return Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Select All Filtered   (${list.length} STUDENTS LISTED)',style:TextStyle(color:muted,fontSize:10,fontWeight:FontWeight.w800)),const SizedBox(height:12),SingleChildScrollView(scrollDirection:Axis.horizontal,child:DataTable(columns:const[DataColumn(label:Text('STUDENT INFO')),DataColumn(label:Text('DEPT & BATCH')),DataColumn(label:Text('ACTIVE TRACK')),DataColumn(label:Text('SCORE')),DataColumn(label:Text('ACTIONS'))],rows:list.map((s)=>DataRow(cells:[
    DataCell(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(s.name,style:TextStyle(color:text,fontSize:10,fontWeight:FontWeight.w800)),Text(s.email,style:TextStyle(color:muted,fontSize:8))])),
    DataCell(Text('${s.dept}\nGrad: ${s.grad}',style:const TextStyle(color:Color(0xFF7C3DFF),fontSize:9))),
    DataCell(Text(s.track,style:TextStyle(color:text,fontSize:9))),
    DataCell(Text('${s.score}%',style:const TextStyle(color:Color(0xFF00B98A),fontSize:10,fontWeight:FontWeight.w800))),
    DataCell(Row(children:[IconButton(onPressed:()=>_msg('Viewing ${s.name}'),icon:const Icon(Icons.visibility_outlined,size:14)),IconButton(onPressed:()=>_edit(s),icon:const Icon(Icons.edit_outlined,color:Color(0xFF7C3DFF),size:14)),IconButton(onPressed:()=>setState(()=>students.remove(s)),icon:const Icon(Icons.delete_outline,color:Colors.red,size:14))]))
  ])).toList())])]);}
  Widget _addStudent()=>Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('⊕  Add Student Account',style:TextStyle(color:text,fontSize:17,fontWeight:FontWeight.w800)),Text('Instantly register single learner credentials.',style:TextStyle(color:muted,fontSize:11)),const SizedBox(height:16),_input('e.g. Johnathan Sahu'),const SizedBox(height:10),_input('e.g. jsahu@nextgen.com'),const SizedBox(height:10),Row(children:[Expanded(child:_drop('Computer Science',['Computer Science','Electrical Eng','Information Tech'],(_)=>{})),const SizedBox(width:8),Expanded(child:_drop('2026',['2026','2027','2028'],(_)=>{}))]),const SizedBox(height:10),_drop('Web Development',['Web Development','Python & AI','Systems C++'],(_)=>{}),const SizedBox(height:14),SizedBox(width:double.infinity,height:44,child:FilledButton(onPressed:()=>_msg('Student credentials created and dispatched'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFFFF7A30)),child:const Text('Create & Dispatch Credentials')))]));
  Widget _edit(Student s){final c=TextEditingController(text:s.name);return showDialog<void>(context:context,builder:(d)=>AlertDialog(title:const Text('Edit Student Information'),content:_input('Full Name',controller:c),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('Cancel')),FilledButton(onPressed:(){setState(()=>s.name=c.text);Navigator.pop(d);},child:const Text('Save Changes'))]));}

  Widget _curriculum()=>_scroll(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_tabs(),const SizedBox(height:22),Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_badge('ABET & NAAC OUTCOMES ENGINE',const Color(0xFFEFE7FF),const Color(0xFF7C3DFF)),const SizedBox(height:7),Text('Gamified Cohort Roadmaps & Milestone Canvas',style:TextStyle(color:text,fontSize:19,fontWeight:FontWeight.w800)),Text('Customize unlock thresholds, ABET benchmarks, and video quiz gates per cohort.',style:TextStyle(color:muted,fontSize:11)),const SizedBox(height:16),Wrap(spacing:8,children:[_cohort('Computer Science 2026 Batch','5 Nodes',true),_cohort('Computer Science 2027 Batch','4 Nodes',false),_cohort('Electrical Eng 2027 Batch','5 Nodes',false)])]),const SizedBox(height:20),LayoutBuilder(builder:(c,x){final left=Container(padding:const EdgeInsets.all(25),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('MIT Advanced Web Dev (Sahu Custom)',style:TextStyle(color:text,fontSize:18,fontWeight:FontWeight.w800)),Text('Click any node below to configure gate conditions, ABET tags, and learning topics.',style:TextStyle(color:muted,fontSize:11)),const SizedBox(height:18),...nodes.map(_node)]));final right=_panel('Node Configuration Panel','Edit selected level parameters & ABET guidelines.',Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_label('Level Node Title'),_input('Web Foundations & ES6+'),_label('Description'),_input('Asynchronous JS, Event Loop, Closures, Scopes, and ES6 Modules.'),_label('ABET Outcome'),_drop('ABET-SO-1',['ABET-SO-1','ABET-SO-2','ABET-SO-3','ABET-SO-6'],(_)=>{}),_label('Status Gate'),_drop('Unlocked',['Unlocked','Gate Required','Locked'],(_)=>{}),const SizedBox(height:12),SizedBox(width:double.infinity,child:FilledButton(onPressed:()=>_msg('Milestone settings saved'),child:const Text('Save Milestone Settings')))]));return x.maxWidth<1000?Column(children:[left,const SizedBox(height:20),right]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:7,child:left),const SizedBox(width:20),Expanded(flex:3,child:right)]);})]));
  Widget _cohort(String a,String b,bool active)=>Container(padding:const EdgeInsets.symmetric(horizontal:14,vertical:10),decoration:BoxDecoration(color:active?const Color(0xFF7827FF):alt,borderRadius:BorderRadius.circular(17)),child:Text('$a   $b',style:TextStyle(color:active?Colors.white:text,fontSize:10,fontWeight:FontWeight.w800)));
  Widget _node(Map<String,dynamic> n)=>Container(margin:const EdgeInsets.only(bottom:14),padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:alt,border:Border.all(color:n['n']=='01'?const Color(0xFF8B42FF):border,width:n['n']=='01'?2:1),borderRadius:BorderRadius.circular(18)),child:Column(children:[Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:45,height:45,alignment:Alignment.center,decoration:BoxDecoration(color:n['color'],shape:BoxShape.circle),child:Text(n['n'],style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w900))),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('${n['title']}  ${n['abet']}',style:TextStyle(color:text,fontSize:14,fontWeight:FontWeight.w800)),Text(n['desc'],style:TextStyle(color:muted,fontSize:10.5)),Text('⏱ ${n['hours']}   🔒 Gate: ${n['gate']}',style:TextStyle(color:muted,fontSize:9))])),_pill(n['status'],n['color'])]),const SizedBox(height:10),Wrap(spacing:6,children:(n['tags'] as List<String>).map((t)=>_pill('#$t',muted)).toList())]));

  Widget _announcements()=>_scroll(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_header(),const SizedBox(height:25),_tabs(),const SizedBox(height:25),_announcementHero(),const SizedBox(height:22),LayoutBuilder(builder:(c,x){final form=_announcementForm();final feed=_announcementFeed();return x.maxWidth<1050?Column(children:[form,const SizedBox(height:20),feed]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:5,child:form),const SizedBox(width:22),Expanded(flex:7,child:feed)]);})]));
  Widget _announcementHero()=>Container(padding:const EdgeInsets.all(32),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF243E9A),Color(0xFF12182F)]),borderRadius:BorderRadius.circular(27)),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_darkBadge('📣 COLLEGE BROADCASTER & DIRECTIVE CENTER',Color(0xFF9CB5FF)),const SizedBox(height:12),const Text('Official Campus Announcements',style:TextStyle(color:Colors.white,fontSize:29,fontWeight:FontWeight.w800)),Text('Broadcast institutional notices, academic deadlines, placement drives, and urgent campus alerts directly to all Student and Instructor dashboards in real time.',style:TextStyle(color:Colors.white70,fontSize:13.5))])),const SizedBox(width:18),Container(width:135,padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:Colors.white10,borderRadius:BorderRadius.circular(16)),child:Column(children:[Text('${notices.length}',style:const TextStyle(color:Color(0xFFFFD03C),fontSize:30,fontWeight:FontWeight.w900)),const Text('ACTIVE NOTICES',style:TextStyle(color:Colors.white60,fontSize:9,fontWeight:FontWeight.w800))]))]));
  Widget _announcementForm()=>Container(padding:const EdgeInsets.all(25),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(24)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('✈  Publish Campus Announcement',style:TextStyle(color:text,fontSize:17,fontWeight:FontWeight.w800)),Text('Posted items will be broadcasted live to students and instructors.',style:TextStyle(color:muted,fontSize:11)),const SizedBox(height:16),_label('Announcement Title *'),_input('e.g. 🎓 Mid-Term Exam Guidelines & Proctoring Schedule',controller:annTitle),_label('Category'),_drop('Academic',['Academic','Event','Placement','System','Urgent','General'],(_)=>{}),_label('Target Audience'),_drop('All (Students & Instructors)',['All (Students & Instructors)','Students Only','Instructors Only'],(_)=>{}),_label('Author / Publishing Office'),_input('College Dean & Examination Cell',controller:annAuthor),_label('Announcement Body / Details *'),TextField(controller:annBody,maxLines:6,decoration:InputDecoration(hintText:'Provide complete details, instructions, links, or criteria for this notice...',filled:true,fillColor:alt,border:OutlineInputBorder(borderRadius:BorderRadius.circular(13)))),Row(children:[Checkbox(value:pinNew,onChanged:(v)=>setState(()=>pinNew=v??false)),Text('Pin to top of Student and Instructor feeds',style:TextStyle(color:text,fontSize:10))]),SizedBox(width:double.infinity,height:44,child:FilledButton.icon(onPressed:_publish,icon:const Icon(Icons.campaign_outlined,size:15),label:const Text('Broadcast Notice Now'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFFFF7A30))) ]));
  Widget _announcementFeed()=>Column(children:[Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:card,border:Border.all(color:border),borderRadius:BorderRadius.circular(18)),child:Row(children:[Expanded(child:Wrap(spacing:5,children:['All','Pinned','Academic','Event','Placement','Urgent','System'].map((s)=>ChoiceChip(label:Text(s,style:const TextStyle(fontSize:9)),selected:annFilter==s,onSelected:(_)=>setState(()=>annFilter=s),selectedColor:const Color(0xFFFF7A30))).toList())),SizedBox(width:175,child:TextField(controller:annSearchCtl,onChanged:(v)=>setState(()=>annSearch=v),decoration:InputDecoration(hintText:'Search announcements...',prefixIcon:Icon(Icons.search,size:14,color:muted),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))))])),const SizedBox(height:12),...notices.where((n){final q=annSearch.toLowerCase();final m=q.isEmpty||n.title.toLowerCase().contains(q)||n.body.toLowerCase().contains(q);return m&&(annFilter=='All'||(annFilter=='Pinned'?n.pinned:n.category==annFilter));}).map(_noticeCard)]);
  Widget _noticeCard(Notice n)=>Container(margin:const EdgeInsets.only(bottom:13),padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:card,border:Border.all(color:n.pinned?const Color(0xFFFFC44D):border),borderRadius:BorderRadius.circular(19)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[_pill(n.category, n.category=='Urgent'?Colors.red:n.category=='Academic'?const Color(0xFF3475FF):n.category=='Placement'?const Color(0xFF00B98A):const Color(0xFF8B42FF)),const SizedBox(width:6),_pill('Target: ${n.target}',muted),if(n.pinned)...[const SizedBox(width:6),_pill('📌 Pinned Notice',Color(0xFFFFA51C))],const Spacer(),Text(n.date,style:TextStyle(color:muted,fontSize:9))]),const SizedBox(height:11),Text(n.title,style:TextStyle(color:text,fontSize:15,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(n.body,style:TextStyle(color:muted,fontSize:11,height:1.4)),const Divider(),Row(children:[Expanded(child:Text(n.author,style:TextStyle(color:muted,fontSize:10,fontWeight:FontWeight.w700))),TextButton(onPressed:()=>setState(()=>n.pinned=!n.pinned),child:Text(n.pinned?'Unpin':'Pin to Top')),TextButton(onPressed:()=>setState(()=>notices.remove(n)),child:const Text('Delete',style:TextStyle(color:Colors.red)))])]));

  Widget _audit()=>_scroll(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[_tabs(),const SizedBox(height:25),_panel('AI Technical Proctoring Audit Trail','Integrates 4 webcam and viewport listeners tracking tab swaps, multi-face overlaps, and clipboard violations.',GridView.count(crossAxisCount:4,crossAxisSpacing:14,childAspectRatio:2.5,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),children:[_miniAudit('TAB SWAPS SWAPPED','12 times logged',text),_miniAudit('MULTIPLE FACES SCAN','1 Warning level',Color(0xFFFF9900)),_miniAudit('CLIPBOARD BYPASSES','2 Blocked attempts',Color(0xFFFF4350)),_miniAudit('NO WEBCAM STREAMS','1 High alert flag',Color(0xFFFF4350))])),const SizedBox(height:20),_panel('LIVE ANTI-CHEAT ANOMALY STREAM','',Column(children:proctor.map(_proctorCard).toList()))]));
  Widget _miniAudit(String a,String b,Color c)=>Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:alt,border:Border.all(color:dark?const Color(0xFF666A74):const Color(0xFF5D626B)),borderRadius:BorderRadius.circular(15)),child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[Text(a,style:TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800)),Text(b,style:TextStyle(color:c,fontSize:18,fontWeight:FontWeight.w800))]));
  Widget _proctorCard(Map<String,dynamic> p)=>Container(margin:const EdgeInsets.only(bottom:13),padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:card,border:Border.all(color:dark?const Color(0xFF4D515B):const Color(0xFF545862)),borderRadius:BorderRadius.circular(17)),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[_pill('${p['sev']} SEVERITY ANOMALY',p['sev']=='High'?Colors.red:p['sev']=='Medium'?Colors.orange:muted),const SizedBox(width:7),Text(p['time'],style:TextStyle(color:muted,fontSize:9))]),const SizedBox(height:7),Text('Student: ${p['student']}',style:TextStyle(color:text,fontSize:11.5,fontWeight:FontWeight.w800)),Text(p['note'],style:TextStyle(color:muted,fontSize:10.5))])),if(p['done'] as bool)_pill('✓ REVIEWED & CLEARED',Color(0xFF00C98A))else Row(children:[OutlinedButton(onPressed:()=>_msg('Opening deep-dive report'),child:const Text('Deep-Dive Report')),const SizedBox(width:6),FilledButton(onPressed:()=>setState(()=>p['done']=true),style:FilledButton.styleFrom(backgroundColor:const Color(0xFF00B98A)),child:const Text('Resolve Log'))])]));

  void _publish(){if(annTitle.text.trim().isEmpty||annBody.text.trim().isEmpty){_msg('Please provide title and body');return;}setState((){notices.insert(0,Notice('Academic','All',annTitle.text.trim(),annBody.text.trim(),annAuthor.text.trim(),'Today',pinned:pinNew));annTitle.clear();annBody.clear();pinNew=false;});_msg('Official Campus Announcement Published!');}
  void _msg(String s)=>ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content:Text(s),behavior:SnackBarBehavior.floating));
  void _signout(){showDialog<void>(context:context,builder:(d)=>AlertDialog(title:const Text('Sign Out'),content:const Text('Are you sure you want to sign out of the College Admin portal?'),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('Cancel')),FilledButton(onPressed:(){Navigator.pop(d);_msg('Signed out');},child:const Text('Sign Out'))]));}
  String _initials(String s){final p=s.trim().split(RegExp(r'\s+'));return p.length>1?'${p.first[0]}${p.last[0]}'.toUpperCase():p.isEmpty?'CA':p.first[0].toUpperCase();}
}
