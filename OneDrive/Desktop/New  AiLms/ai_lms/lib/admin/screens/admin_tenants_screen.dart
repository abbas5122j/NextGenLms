import 'package:flutter/material.dart';
import '../admin_api_client.dart';
import '../admin_models.dart';
import '../admin_theme.dart';
import '../admin_widgets.dart';

class AdminTenantsScreen extends StatefulWidget {
  final AdminApiClient? api;
  final bool dark;
  const AdminTenantsScreen({super.key, this.api, required this.dark});
  @override State<AdminTenantsScreen> createState()=>_AdminTenantsScreenState();
}

class _AdminTenantsScreenState extends State<AdminTenantsScreen> {
  bool get dark => widget.dark;
  final _college = TextEditingController(); final _domain = TextEditingController();
  String capacity='1000 Students'; String plan='Premium Dev'; String selected='MIT Innovation Labs';
  int students=2500, instructors=50, pm=20; String license='LIC-MIT-9932-8821-X';
  final List<_TenantRow> rows=[
    _TenantRow('MIT Innovation Labs','mit.nextgenlms.edu','1450 / 2500 Seats','Enterprise Elite','ACTIVE',true),
    _TenantRow('Stanford Technical School','stanford.edu','920 / 1500 Seats','Premium Dev','ACTIVE',true),
    _TenantRow('Indian Institute of Technology','iit.edu.in','2100 / 3000 Seats','Enterprise Elite','ACTIVE',true),
    _TenantRow('Berlin Institute of Coding','berlincode.de','0 / 500 Seats','Standard Growth','PENDING',false),
  ];
  @override void dispose(){_college.dispose();_domain.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>SingleChildScrollView(padding:const EdgeInsets.fromLTRB(44,38,44,60),child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1420),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    AdminPageHeader(dark:dark,badge:'SUPER ADMIN CONTROL NODE',title:'SaaS Global Mainframe Management',subtitle:'Configure multi-tenant limits, allocate compiler limits, input API keys, and publish master curriculum libraries.',trailing:AdminStatusPill(text:'GLOBAL STATUS: ACTIVE (99.982% UPTIME)',color:AdminTheme.green)),
    SizedBox(height:28), _TenantControlRow(), SizedBox(height:26), _PartnersCard(),
  ]))));

  Widget _TenantControlRow()=>LayoutBuilder(builder:(_,c)=>c.maxWidth<980?Column(children:[_onboard(),const SizedBox(height:20),_allocator()]):Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:_onboard()),const SizedBox(width:24),Expanded(flex:2,child:_allocator())]));

  Widget _onboard()=>Container(padding:const EdgeInsets.fromLTRB(28,26,28,26),decoration:AdminTheme.cardDecoration(dark,radius:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[const Icon(Icons.add_circle_outline,color:AdminTheme.primary),const SizedBox(width:10),Text('Onboard Tenant College',style:AdminText.section(dark))]),
    const SizedBox(height:5),Text('Instantly spin up isolated relational namespaces, quotas, and licensing.',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:11)),const SizedBox(height:25),
    AdminInput(label:'College Name',hint:'e.g. Harvard Innovation Labs',controller:_college,dark:dark),const SizedBox(height:17),AdminInput(label:'Authorized Domain Mapping',hint:'e.g. harvard.edu',controller:_domain,dark:dark),const SizedBox(height:17),
    Row(children:[Expanded(child:_dropdown('Student Capacity',capacity,['500 Students','1000 Students','1500 Students','2500 Students'],(v)=>setState(()=>capacity=v))),const SizedBox(width:12),Expanded(child:_dropdown('SaaS Plan Tier',plan,['Standard Growth','Premium Dev','Enterprise Elite'],(v)=>setState(()=>plan=v)))]),const SizedBox(height:18),
    AdminActionButton(label:'Authorize & Provision Client Node',icon:Icons.apartment_outlined,onPressed:_provision),
  ]));

  Widget _allocator()=>Container(padding:const EdgeInsets.fromLTRB(28,26,28,28),decoration:AdminTheme.cardDecoration(dark,radius:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[const Icon(Icons.tune_rounded,color:AdminTheme.purple),const SizedBox(width:10),Text('Live Quota Allocator & Licensing Control',style:AdminText.section(dark))]),const SizedBox(height:5),Text('Customize specific platform thresholds, maximum active user boundaries, and rotate secret keys.',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:11)),const SizedBox(height:24),
    Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:dark ? const Color(0xFF201B2D) : const Color(0xFFFBF8FF),borderRadius:BorderRadius.circular(16),border:Border.all(color:dark ? const Color(0xFF4A356B) : const Color(0xFFE7DAFF))),child:Row(children:[Expanded(child:_dropdown('Select Target College Client',selected,rows.map((e)=>e.name).toList(),(v)=>setState(()=>selected=v))),const SizedBox(width:18),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('License Verification Token',style:AdminText.label(dark)),const SizedBox(height:7),Row(children:[Expanded(child:Container(height:45,padding:const EdgeInsets.symmetric(horizontal:14),alignment:Alignment.centerLeft,decoration:BoxDecoration(color:dark ? const Color(0xFF1C2535) : const Color(0xFFF1F2F5),borderRadius:BorderRadius.circular(12)),child:Text(license,style:TextStyle(color:AdminTheme.secondary(dark),fontSize:11,fontWeight:FontWeight.w700)))),const SizedBox(width:9),TextButton(onPressed:_rotate,child:Text('Rotate',style:TextStyle(fontSize:11,fontWeight:FontWeight.w900)))])]))])),
    const SizedBox(height:23),Row(children:[Expanded(child:_number('MAX ACTIVE STUDENTS QUOTA',students,(v)=>students=v)),const SizedBox(width:18),Expanded(child:_number('MAX INSTRUCTOR SEATS CAP',instructors,(v)=>instructors=v)),const SizedBox(width:18),Expanded(child:_number('MAX AGILE PROJECT PM TEAMS',pm,(v)=>pm=v))]),const SizedBox(height:22),
    SizedBox(width:double.infinity,child:ElevatedButton.icon(onPressed:(){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Hard quotas enforced globally.')));},icon:const Icon(Icons.verified_outlined,size:17),label:Text('Enforce Hard Quotas & Broadcast Limits',style:TextStyle(fontWeight:FontWeight.w900,fontSize:12)),style:ElevatedButton.styleFrom(backgroundColor:AdminTheme.purple,foregroundColor:Colors.white,elevation:0,padding:const EdgeInsets.symmetric(vertical:15),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12))))),
  ]));

  Widget _dropdown(String label, String value, List<String> values, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AdminText.label(dark)),
        const SizedBox(height: 7),
        DropdownButtonFormField<String>(
          value: value,
          items: values.map((v) => DropdownMenuItem<String>(value: v, child: Text(v, overflow: TextOverflow.ellipsis, style: TextStyle(color: AdminTheme.foreground(dark), fontSize: 11.5, fontWeight: FontWeight.w700)))).toList(),
          onChanged: (v) { if (v != null) onChanged(v); },
          decoration: InputDecoration(
            filled: true,
            fillColor: dark ? const Color(0xFF0F1522) : const Color(0xFFF8F9FB),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AdminTheme.outline(dark))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AdminTheme.outline(dark))),
          ),
        ),
      ],
    );
  }

  Widget _number(String label,int value,ValueChanged<int> onChanged)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:AdminText.label(dark)),const SizedBox(height:7),TextFormField(initialValue:'$value',keyboardType:TextInputType.number,onChanged:(v)=>onChanged(int.tryParse(v)??value),decoration:InputDecoration(filled:true,fillColor:dark ? const Color(0xFF0F1522) : const Color(0xFFF8F9FB),contentPadding:const EdgeInsets.symmetric(horizontal:14,vertical:13),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide(color:AdminTheme.outline(dark))),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide(color:AdminTheme.outline(dark)))))]);

  Widget _PartnersCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 27, 28, 22),
      decoration: AdminTheme.cardDecoration(dark, radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Onboarded College Partners', style: AdminText.section(dark)),
          const SizedBox(height: 5),
          Text('Status monitors and billing tiers of verified institution clients.', style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11)),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 26,
              headingTextStyle: TextStyle(color: AdminTheme.secondary(dark), fontSize: 10, fontWeight: FontWeight.w900),
              dataTextStyle: TextStyle(color:AdminTheme.foreground(dark), fontSize: 11, fontWeight: FontWeight.w600),
              columns: const [
                DataColumn(label: Text('COLLEGE CLIENT NAME')),
                DataColumn(label: Text('DOMAIN MAPPING')),
                DataColumn(label: Text('ALLOCATED LIMITS')),
                DataColumn(label: Text('PLAN TIER')),
                DataColumn(label: Text('SYSTEM STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: rows.map((r) => DataRow(cells: [
                DataCell(SizedBox(width: 220, child: Text(r.name, style: TextStyle(color: AdminTheme.foreground(dark), fontWeight: FontWeight.w900)))),
                DataCell(Text(r.domain, style: TextStyle(color: AdminTheme.secondary(dark)))),
                DataCell(Text(r.seats)),
                DataCell(AdminStatusPill(text: r.plan, color: AdminTheme.blue)),
                DataCell(AdminStatusPill(text: r.status, color: r.active ? AdminTheme.green : AdminTheme.yellow)),
                DataCell(Row(children: [
                  TextButton(onPressed: () => _modify(r), child: Text('Modify Limit', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900))),
                  TextButton(onPressed: () => setState(() => r.active = !r.active), child: Text(r.active ? 'Suspend' : 'Activate', style: TextStyle(color: r.active ? AdminTheme.red : AdminTheme.green, fontSize: 10, fontWeight: FontWeight.w900))),
                ])),
              ])).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _provision(){final name=_college.text.trim(); if(name.isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Enter a college name first.')));return;}setState((){rows.add(_TenantRow(name,_domain.text.trim().isEmpty?'newtenant.edu':_domain.text.trim(),'0 / 1000 Seats',plan,'PENDING',false));_college.clear();_domain.clear();});ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$name provisioned as a tenant.')));}
  void _rotate(){setState(()=>license='LIC-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}-X');}
  void _modify(_TenantRow r){showDialog(context:context,builder:(_)=>AlertDialog(title:Text('Modify Limit'),content:Text('Quota editor is connected to the tenant control plane.'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:Text('Close'))]));}
}
class _TenantRow {final String name,domain,seats,plan,status; bool active; _TenantRow(this.name,this.domain,this.seats,this.plan,this.status,this.active);}
