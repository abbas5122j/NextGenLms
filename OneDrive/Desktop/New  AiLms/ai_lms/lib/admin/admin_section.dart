import 'package:flutter/material.dart';
import 'admin_api_client.dart';
import 'admin_shell.dart';
import 'screens/admin_analytics_screen.dart';
import 'screens/admin_tenants_screen.dart';
import 'screens/admin_infra_screen.dart';
import 'screens/admin_cms_screen.dart';
import 'screens/admin_portal_codes_screen.dart';

class AdminSectionScreen extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleDarkMode;
  final VoidCallback? onSignOut;
  final AdminApiClient api;
  const AdminSectionScreen({super.key,required this.userName,required this.isDarkMode,required this.onToggleDarkMode,required this.api,this.onSignOut});
  @override State<AdminSectionScreen> createState()=>_AdminSectionScreenState();
}
class _AdminSectionScreenState extends State<AdminSectionScreen>{
  AdminSection active=AdminSection.analytics; bool collapsed=false;
  @override Widget build(BuildContext context)=>AdminShell(activeSection:active,userName:widget.userName,isDarkMode:widget.isDarkMode,onToggleDarkMode:widget.onToggleDarkMode,onSignOut:widget.onSignOut,sidebarCollapsed:collapsed,onToggleSidebar:()=>setState(()=>collapsed=!collapsed),onSectionSelected:(v)=>setState(()=>active=v),child:_content());
  Widget _content(){switch(active){case AdminSection.analytics:return AdminAnalyticsScreen(api:widget.api,dark:widget.isDarkMode);case AdminSection.tenants:return AdminTenantsScreen(api:widget.api,dark:widget.isDarkMode);case AdminSection.infra:return AdminInfraScreen(api:widget.api,dark:widget.isDarkMode);case AdminSection.cms:return AdminCmsScreen(api:widget.api,dark:widget.isDarkMode);case AdminSection.portalCodes:return AdminPortalCodesScreen(api:widget.api,dark:widget.isDarkMode);}}
}


/// Configuration helper used by AuthWrapper to create the Admin API client.
class AdminGatewayConfig {
  final String gatewayUrl;
  final Future<String?> Function()? accessTokenProvider;

  const AdminGatewayConfig({
    required this.gatewayUrl,
    this.accessTokenProvider,
  });

  AdminApiClient createClient() => AdminApiClient(
        gatewayBaseUrl: gatewayUrl,
        accessTokenProvider: accessTokenProvider,
      );
}
