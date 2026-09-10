import 'package:flutter/material.dart';
import '../admin_api_client.dart';
import '../admin_theme.dart';
import '../admin_widgets.dart';

class AdminPortalCodesScreen extends StatefulWidget { final AdminApiClient? api; final bool dark; const AdminPortalCodesScreen({super.key,this.api,required this.dark}); @override State<AdminPortalCodesScreen> createState()=>_AdminPortalCodesScreenState(); }
class _AdminPortalCodesScreenState extends State<AdminPortalCodesScreen>{
  bool get dark => widget.dark;
  final college=TextEditingController();
  late final List<_Code> codes = [
    _Code('COLL-MIT-9912','MIT Innovation Labs','2026-07-15 10:30 AM','Active',AdminTheme.green),
    _Code('COLL-STAN-4431','Stanford Tech','2026-07-18 02:15 PM','Redeemed',AdminTheme.secondary(dark)),
  ];
  @override void dispose(){college.dispose();super.dispose();}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(44, 38, 44, 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(28, 27, 28, 28),
                decoration: AdminTheme.cardDecoration(dark, radius: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.key_outlined, color: AdminTheme.primary, size: 24),
                      const SizedBox(width: 11),
                      Text('Unique Portal Code Generator', style: AdminText.section(dark)),
                      const Spacer(),
                      const AdminBadge(text: 'AUTHORIZED: ADMIN', color: AdminTheme.primary),
                    ]),
                    const SizedBox(height: 5),
                    Text('Generate official security codes to authenticate authorized College tenants.', style: TextStyle(color: AdminTheme.secondary(dark), fontSize: 11)),
                    const SizedBox(height: 23),
                    Text('College Name', style: AdminText.label(dark)),
                    const SizedBox(height: 7),
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: college,
                          style: TextStyle(color: AdminTheme.foreground(dark), fontSize: 12, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: 'e.g. Yale Science Campus',
                            hintStyle: TextStyle(color: AdminTheme.secondary(dark), fontSize: 13),
                            filled: true,
                            fillColor: dark ? const Color(0xFF0F1522) : const Color(0xFFF8F9FB),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AdminTheme.outline(dark))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AdminTheme.outline(dark))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      SizedBox(width: 305, child: AdminActionButton(label: 'Generate Unique Key', icon: Icons.auto_awesome_outlined, onPressed: _generate)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _table(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _table()=>Container(padding:const EdgeInsets.fromLTRB(28,27,28,23),decoration:AdminTheme.cardDecoration(dark,radius:24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('GENERATED SECURITY CREDENTIALS (${codes.length})',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:10,fontWeight:FontWeight.w900,letterSpacing:.8)),const SizedBox(height:20),SingleChildScrollView(scrollDirection:Axis.horizontal,child:DataTable(columnSpacing:42,headingTextStyle:TextStyle(color:AdminTheme.secondary(dark),fontSize:9.5,fontWeight:FontWeight.w900),dataTextStyle:TextStyle(color:AdminTheme.foreground(dark),fontSize:10.5,fontWeight:FontWeight.w600),columns:const [DataColumn(label:Text('UNIQUE SECURITY CODE')),DataColumn(label:Text('TARGET ASSIGNEE')),DataColumn(label:Text('DATE CREATED')),DataColumn(label:Text('SECURITY STATUS')),DataColumn(label:Text('ACTIONS'))],rows:codes.map((c)=>DataRow(cells:[DataCell(Row(children:[Container(padding:const EdgeInsets.symmetric(horizontal:11,vertical:7),decoration:BoxDecoration(color:dark ? const Color(0xFF1C2535) : const Color(0xFFF1F2F4),borderRadius:BorderRadius.circular(8)),child:Text(c.code,style:TextStyle(color:AdminTheme.foreground(dark),fontWeight:FontWeight.w900,fontSize:10.5))),const SizedBox(width:9),IconButton(onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${c.code} copied.')));},icon: Icon(Icons.copy_outlined,size:16,color:AdminTheme.secondary(dark)))])),DataCell(Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children:[Text(c.target,style:TextStyle(color:AdminTheme.foreground(dark),fontWeight:FontWeight.w900,fontSize:10.5)),Text('College Key',style:TextStyle(color:AdminTheme.secondary(dark),fontSize:9))])),DataCell(Text(c.date,style:TextStyle(color:AdminTheme.secondary(dark),fontSize:9.5))),DataCell(AdminStatusPill(text:c.status,color:c.color)),DataCell(IconButton(onPressed:()=>setState(()=>codes.remove(c)),icon:const Icon(Icons.delete_outline,color:AdminTheme.red,size:18)))])).toList()))]));
  void _generate(){final n=college.text.trim();if(n.isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Enter a college name.')));return;}final suffix=DateTime.now().millisecondsSinceEpoch.toString().substring(8);setState(()=>codes.insert(0,_Code('COLL-${suffix.padLeft(4,'0')}','$n','2026-09-10 02:46 PM','Active',AdminTheme.green)));college.clear();}
}
class _Code {final String code,target,date,status;final Color color;_Code(this.code,this.target,this.date,this.status,this.color);}
