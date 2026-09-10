import 'package:flutter/material.dart';
import '../admin_api_client.dart';
import '../admin_theme.dart';
import '../admin_widgets.dart';

class AdminInfraScreen extends StatefulWidget {
  final AdminApiClient? api; final bool dark;
  const AdminInfraScreen({super.key,this.api,required this.dark});
  @override State<AdminInfraScreen> createState()=>_AdminInfraScreenState();
}
class _AdminInfraScreenState extends State<AdminInfraScreen>{
  bool get dark => widget.dark;
  String provider='Gemini 2.0 Flash (Default - High Speed)'; bool ai=true; bool compiler=true;
  late final TextEditingController gemini,meet,rtc;
  final Map<String,TextEditingController> time={},memory={};
  final data=[('Python 3 Isolated Environment','nextgen/python-sandbox:latest',4000,64,AdminTheme.green),('C++ (GCC 13 Clang SIMD)','nextgen/cpp-compiler:13-alpine',5000,128,AdminTheme.purple),('Java Virtual Machine (OpenJDK 21 Loom)','nextgen/openjdk:21-virtual-threads',6000,256,AdminTheme.purple),('Web Frontend Sandbox (Node 20 Vite)','nextgen/node-web-host:20',8000,512,AdminTheme.blue)];
  @override void initState(){super.initState();gemini=TextEditingController(text: '••••••••••••••••••••••••••');meet=TextEditingController(text: 'meet-992138-api-client.apps.googleusercontent.com');rtc=TextEditingController(text: 'rtc-sig-sec-33821-node-prod');for(final d in data){time[d.$1]=TextEditingController(text:'${d.$3}');memory[d.$1]=TextEditingController(text:'${d.$4}');}}
  @override void dispose(){gemini.dispose();meet.dispose();rtc.dispose();for(final c in [...time.values,...memory.values])c.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>SingleChildScrollView(padding:const EdgeInsets.fromLTRB(44,38,44,60),child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1420),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    AdminPageHeader(dark:dark,badge:'SUPER ADMIN CONTROL NODE',title:'SaaS Global Mainframe Management',subtitle:'Configure multi-tenant limits, allocate compiler limits, input API keys, and publish master curriculum libraries.',trailing:AdminStatusPill(text:'GLOBAL STATUS: ACTIVE (99.982% UPTIME)',color:AdminTheme.green)),
    const SizedBox(height:28),
    LayoutBuilder(builder:(_,c)=>c.maxWidth<980?Column(children:[_keys(),const SizedBox(height:20),_sandboxes()]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:_keys()),const SizedBox(width:24),Expanded(child:_sandboxes())])),
    const SizedBox(height:22),Align(alignment:Alignment.centerRight,child:AdminActionButton(label:'Commit Infrastructure Changes Globally',icon:Icons.check_rounded,color:AdminTheme.primary,onPressed:(){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Infrastructure changes committed globally.')));}))
  ]))));
  Widget _keys()=>Container(padding:const EdgeInsets.fromLTRB(28,27,28,31),decoration:AdminTheme.cardDecoration(dark,radius:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[const Icon(Icons.key_outlined,color:AdminTheme.primary),const SizedBox(width:10),Text('Enterprise API Keys Keychain',style:AdminText.section(dark))]),const SizedBox(height:5),Text('Central secrets to power Sophia AI integration, Google Meet virtual video rooms, and WebRTC streaming.',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:11,height:1.45)),const SizedBox(height:25),
    Text('Default LLM Provider Engine',style:AdminText.label(dark)),const SizedBox(height:7),DropdownButtonFormField<String>(value:provider,items:['Gemini 2.0 Flash (Default - High Speed)','Gemini 2.5 Pro','OpenAI GPT'].map((v)=>DropdownMenuItem(value:v,child:Text(v,style:TextStyle(color:AdminTheme.foreground(dark),fontSize:12,fontWeight:FontWeight.w800)))).toList(),onChanged:(v){if(v!=null)setState(()=>provider=v);},decoration:_dec()),const SizedBox(height:19),
    AdminInput(label:'GEMINI_API_KEY Secret',controller:gemini,dark:dark,suffix:TextButton(onPressed:(){setState((){gemini.text=gemini.text.startsWith('•')?'sk-demo-secret-key-xxxx-xxxx':'••••••••••••••••••••••••••';});},child:Text('Show Key',style:TextStyle(fontSize:10,fontWeight:FontWeight.w800)))),const SizedBox(height:4),Text('Stored securely on server. Accessible solely via server-side /api proxy routes.',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:10)),const SizedBox(height:18),
    Row(children:[Expanded(child:AdminInput(label:'Google Meet Client ID',controller:meet,dark:dark)),const SizedBox(width:18),Expanded(child:AdminInput(label:'WebRTC Signaling Key',controller:rtc,dark:dark))]),
  ]));
  InputDecoration _dec()=>InputDecoration(filled:true,fillColor:dark ? const Color(0xFF0F1522) : const Color(0xFFF8F9FB),contentPadding:const EdgeInsets.symmetric(horizontal:14,vertical:13),border:OutlineInputBorder(borderRadius:BorderRadius.circular(13),borderSide:BorderSide(color:AdminTheme.outline(dark))),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(13),borderSide:BorderSide(color:AdminTheme.outline(dark))));
  Widget _sandboxes()=>Container(padding:const EdgeInsets.fromLTRB(28,27,28,28),decoration:AdminTheme.cardDecoration(dark,radius:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[const Icon(Icons.memory_outlined,color:AdminTheme.purple),const SizedBox(width:10),Text('Sandbox Execution & Memory Bounds',style:AdminText.section(dark))]),const SizedBox(height:5),Text('Define CPU execution timeouts and memory block limits across our language compilers to avoid RAM overflow.',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:11)),const SizedBox(height:23),
    for(final d in data) Padding(padding:const EdgeInsets.only(bottom:14),child:_sandbox(d.$1,d.$2,d.$3,d.$4,d.$5)),
  ]));
  Widget _sandbox(String title,String image,int t,int m,Color iconColor)=>Container(padding:const EdgeInsets.fromLTRB(14,14,14,16),decoration:BoxDecoration(border:Border.all(color:AdminTheme.foreground(dark),width:1),borderRadius:BorderRadius.circular(16)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(Icons.circle,color:iconColor,size:10),const SizedBox(width:7),Expanded(child:Text(title,style:TextStyle(color:AdminTheme.foreground(dark),fontSize:11,fontWeight:FontWeight.w900))),Text('Docker Image: $image',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:9))]),const SizedBox(height:12),Row(children:[Expanded(child:AdminInput(label:'Execution Timeout (ms)',controller:time[title],dark:dark)),const SizedBox(width:16),Expanded(child:AdminInput(label:'Memory Cap (MB)',controller:memory[title],dark:dark))]) ]));
}
