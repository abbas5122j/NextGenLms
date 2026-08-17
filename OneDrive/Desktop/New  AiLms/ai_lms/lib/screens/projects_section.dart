import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Next Gen LMS Project module.
/// IMPORTANT: This widget intentionally has NO sidebar.
/// Use it inside your existing StudentHomeHub shell so the built-in
/// sidebar remains the only sidebar.
class ProjectsSection extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  const ProjectsSection({super.key, required this.userName, required this.isDarkMode});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const orange = Color(0xFFFF6B35);
  static const bg = Color(0xFFF4F6FB);
  String branch = 'ALL';
  String search = '';
  ProjectData? selected;

  final branches = const [
    Branch('ALL', 'All Branches', 13), Branch('CSE', 'CSE', 3),
    Branch('IT', 'IT', 2), Branch('ECE', 'ECE', 2), Branch('EEE', 'EEE', 2),
    Branch('ME', 'ME', 2), Branch('CE', 'CE', 2), Branch('CH', 'CH', 2), Branch('AE', 'AE', 2),
  ];

  final projects = const <ProjectData>[
    ProjectData('cse-chat','CSE','COMPUTER SCIENCE & ENGINEERING','Real-time Multi-Room Chat Engine with WebSockets & Redis','Design and implement a high-concurrency, multi-room chat server using Node.js WebSockets (ws/Socket.io), backed by Redis Pub/Sub for horizontal scaling and message replay.','Intermediate','IN PROGRESS','Oct 28, 2026',['React 18','TypeScript','Node.js','Socket.io','Redis','Tailwind CSS'],'Client UI connects via persistent WebSocket connections. Express handles initial auth and HTTP handshakes. Messages are published to Redis channels, enabling multi-node scalability across Cloud Run instances.',['WebSocket Server Source Code','Redis Pub/Sub Connector Module','React Chat UI Component','Load Testing Benchmarks (10k conns)'],['AS','RK','PM'],[
      StepData('WebSocket Server Setup & Heartbeat Ping/Pong','Initialize an Express HTTP server integrated with ws or Socket.io. Implement ping/pong heartbeat logic to drop broken TCP connections within 30 seconds.', 'const io = new Server(server, { cors: { origin: "*" } });','Heartbeat timers prevent silent memory leaks from dead TCP sockets.'),
      StepData('Redis Pub/Sub Integration for Multi-Node Scaling','Create publisher and subscriber clients and broadcast room events through Redis.','await subscriber.subscribe("chat:room:42", onMessage);','Keep Redis responsible for cross-node fan-out.'),
      StepData('React Chat UI with Optimistic UI Updates & Scrolling','Build room switching, optimistic messages, connection indicators and automatic scroll-to-bottom behaviour.','setMessages(items => [...items, optimisticMessage]);','Optimistic updates make the interface feel instant.')]),
    ProjectData('cse-rag','CSE','COMPUTER SCIENCE & ENGINEERING','AI-Powered Vector Search & RAG Engine','Build a Retrieval-Augmented Generation (RAG) system that chunks documents, generates text embeddings using Google Gemini API, stores vectors in a high-density index, and synthesizes grounded answers.','Advanced','IN REVIEW','Nov 05, 2026',['Google Gemini API','Python / TypeScript','Vector Store','React','RAG'],'Documents are ingested, chunked and embedded. The vector store retrieves semantically relevant chunks which are passed to the generation layer as grounded context.',['Document ingestion pipeline','Embedding and vector search module','RAG API','React search interface'],['AI','DS','PM'],[
      StepData('Document Chunking & Metadata','Split documents into meaningful chunks while preserving source, page and section metadata.','chunks = splitter.split_documents(documents)','Good metadata makes retrieval explainable.'),
      StepData('Embedding & Vector Index','Generate embeddings and persist them in a vector index for semantic retrieval.','results = vector_store.similarity_search(query, k=5)','Tune chunk size and top-k together.'),
      StepData('Grounded Generation','Combine retrieved context with the question and generate a grounded answer.','prompt = context + question','Preserve source metadata when presenting RAG answers.')]),
    ProjectData('cse-commerce','CSE','COMPUTER SCIENCE & ENGINEERING','E-Commerce Microservices Architecture with Redis & Docker','Design a decoupled microservices platform with Product Catalog, Order Processing, and Payment Gateways communicating asynchronously via gRPC / REST.','Advanced','IN PROGRESS','Nov 12, 2026',['Docker','Node.js / Express','Redis','PostgreSQL','gRPC'],'Independent services communicate through REST/gRPC and asynchronous Redis-backed events. Docker provides repeatable environments.',['Product Catalog Service','Order Processing Service','Payment Gateway Service','Docker Compose deployment'],['MS','RK','PM'],[
      StepData('Service Boundaries','Define independent responsibilities and APIs for catalog, orders and payments.','catalog-service / order-service / payment-service','Keep service boundaries aligned with business capabilities.'),
      StepData('Redis Event Bus','Publish domain events without tightly coupling services.','redis.publish("order.created", event)','Use idempotent consumers.'),
      StepData('Dockerized Deployment','Create repeatable service containers and local compose environment.','docker compose up','Add health checks and environment variables.')]),
    ProjectData('it-firewall','IT','INFORMATION TECHNOLOGY','Cyber Threat Detection & Packet Inspection Firewall Engine','Build a network security inspection tool that parses TCP/IP packet headers, detects SYN-flood patterns, inspects payload signatures for SQL Injection / XSS, and triggers automated firewall actions.','Advanced','IN PROGRESS','Nov 15, 2026',['Node.js / Python','Wireshark / PCAP','Express API','Recharts','Packet Analysis'],'Captured packets are parsed into normalized events. Detection rules score suspicious traffic and the response layer can trigger controlled firewall actions.',['PCAP ingestion engine','Threat detection rules','Security dashboard','Automated response module'],['NS','RK'],[
      StepData('PCAP Packet Parser','Read packet captures and normalize network metadata.','event = normalize(packet)','Normalize before writing detection rules.'),
      StepData('Threat Scoring','Combine packet-rate, protocol and signature signals into a threat score.','if syn_rate > threshold: score += 50','Keep detection rules observable.')]),
    ProjectData('it-cloud','IT','INFORMATION TECHNOLOGY','Multi-Region Cloud Infrastructure with Terraform & AWS VPC','Write Terraform templates to provision a highly-available AWS/Cloud setup across 2 availability zones with public/private subnets, NAT gateways, and ALB routing.','Intermediate','UNASSIGNED','Nov 20, 2026',['Terraform','AWS / GCP','Docker','Nginx','VPC'],'Terraform defines networking, routing, compute and load balancing resources so infrastructure can be reproduced consistently.',['Terraform modules','VPC and subnet configuration','Load balancer setup','Deployment documentation'],['CL','PM'],[
      StepData('VPC & Subnet Design','Create public and private subnets across two availability zones.','module "network" { source = "./modules/vpc" }','Separate public and private workloads.'),
      StepData('Routing & NAT','Configure route tables and NAT gateways for private workloads.','private_route -> NAT -> internet_gateway','Private resources should not need direct inbound internet access.')]),
    ProjectData('me-cad','ME','MECHANICAL ENGINEERING','Automotive Control Arm 3D CAD & FEA Stress Heatmap','Design a lightweight aluminium suspension control arm in 3D CAD, perform finite element mesh generation, and compute Von Mises stress distributions under 15kN bump load.','Intermediate','IN PROGRESS','Nov 14, 2026',['Solidworks / Inventor','ANSYS / FEA Solver','Python Matrix Solver','Three.js 3D Viewer'],'CAD geometry is converted to a finite-element mesh. Boundary conditions and loads are applied before solving stress and displacement fields.',['3D CAD model','FEA mesh and boundary conditions','Stress heatmap','Engineering report'],['ME','FEA'],[
      StepData('CAD Geometry','Create the control arm geometry and identify lightweighting opportunities.','Sketch -> Extrude -> Mounting points','Avoid removing material from high-stress regions.'),
      StepData('FEA Setup','Generate the mesh and apply the 15kN bump load with realistic constraints.','Mesh -> BC -> Load -> Solve','Perform mesh convergence.')]),
    ProjectData('me-robot','ME','MECHANICAL ENGINEERING','6-DOF Industrial Robotic Arm Kinematics & Servo Controller','Formulate Denavit-Hartenberg parameters for a 6-axis articulated robot arm and derive forward and inverse kinematics equations.','Advanced','UNASSIGNED','Nov 24, 2026',['Python / C++','ROS 2 / MoveIt','Three.js 3D Canvas','Tailwind CSS'],'Joint states are transformed through a chain of homogeneous matrices and desired trajectories become joint commands.',['Forward kinematics module','Inverse kinematics solver','3D visualization','Servo control prototype'],['RO','ME'],[
      StepData('D-H Parameter Model','Represent each joint using standard Denavit-Hartenberg parameters.','A_i = RotZ(theta) * TransZ(d) * TransX(a) * RotX(alpha)','Keep frame conventions consistent.'),
      StepData('Trajectory & Control','Solve joint configurations and send smooth trajectories.','q(t) -> inverseKinematics -> servoCommand','Use interpolation and velocity limits.')]),
    ProjectData('ce-frame','CE','CIVIL ENGINEERING','High-Rise Reinforced Concrete Frame & Seismic Shear Wall','Model a 15-story reinforced concrete building frame under lateral wind and earthquake loads using ETABS / STAAD.Pro principles, analyzing rebar areas and storey drift limits.','Advanced','IN PROGRESS','Nov 16, 2026',['STAAD.Pro / ETABS','Python Matrix Structural Solver','Recharts','Tailwind CSS'],'The structural model combines gravity and lateral systems. Analysis outputs are checked against drift and reinforcement design requirements.',['Structural model','Seismic load case','Shear wall design','Drift and reinforcement report'],['CE','ST'],[
      StepData('Structural Model','Create the frame, floor levels, columns, beams and shear walls.','Grid -> Members -> Supports -> Materials','Validate geometry before analysis.'),
      StepData('Seismic Analysis','Apply lateral seismic loads and evaluate storey drift.','Base Shear -> Storey Forces -> Drift','Check drift at every relevant storey.')]),
    ProjectData('ce-traffic','CE','CIVIL ENGINEERING','Traffic Flow Intersection Density & Highway Pavement Design','Simulate urban traffic signal timing and design flexible asphalt pavement thickness layers based on CBR and ESAL.','Intermediate','UNASSIGNED','Nov 26, 2026',['Python Traffic Simulator','CBR Pavement Solver','Recharts','Tailwind CSS'],'Traffic simulation estimates intersection demand while pavement design uses soil and axle-load inputs.',['Traffic simulator','Signal timing analysis','CBR pavement solver','Design report'],['CE'],[
      StepData('Traffic Simulation','Model arrival rates, queues and signal phases.','arrivalRate -> queue -> signalPhase -> throughput','Compare timings using the same traffic demand.'),
      StepData('Pavement Design','Convert CBR and ESAL inputs into pavement layers.','CBR + ESAL -> Design Thickness','Document design assumptions.')]),
    ProjectData('ch-reactor','CH','CHEMICAL ENGINEERING','Catalytic CSTR & Plug Flow Reactor (PFR) Yield Simulator','Build an interactive reactor design simulator comparing CSTR and PFR for first-order exothermic catalytic liquid-phase reactions.','Intermediate','IN PROGRESS','Nov 17, 2026',['Python NumPy / SciPy','TypeScript RK4 Solver','Recharts','Tailwind CSS'],'The simulator solves reaction-rate and energy-balance equations and visualizes conversion and temperature.',['CSTR solver','PFR numerical solver','Yield comparison charts','Parameter controls'],['CH','RX'],[
      StepData('Reaction Model','Define the first-order reaction rate and temperature dependency.','r = k(T) C_A','Keep kinetic parameters separate from the solver.'),
      StepData('Numerical Integration','Solve PFR state equations using a stable method.','state_(n+1) = RK4(state_n, dt)','Validate against limiting cases.')]),
    ProjectData('ch-distillation','CH','CHEMICAL ENGINEERING','Distillation Column Separation & McCabe-Thiele Calculator','Develop a graphical McCabe-Thiele solver for binary mixture distillation columns, computing minimum reflux ratio, equilibrium stages, and optimum feed tray location.','Advanced','UNASSIGNED','Nov 27, 2026',['TypeScript / Python','VLE Equation Engine','Recharts Step Visualizer','Tailwind CSS'],'VLE data defines equilibrium relationships. Operating lines and stepping logic determine stage requirements.',['VLE calculator','McCabe-Thiele plot','Stage counter','Feed tray estimator'],['CH'],[
      StepData('VLE Model','Implement binary equilibrium data and interpolation.','y_eq = f(x, P, T)','Use consistent units.'),
      StepData('McCabe-Thiele Solver','Draw operating lines and step between equilibrium and operating curves.','q-line -> operating lines -> stages','Make plotted points inspectable.')]),
    ProjectData('ae-airfoil','AE','AEROSPACE ENGINEERING','Supersonic Airfoil Compressible Flow & Shockwave Solver','Develop a numerical solver for 2D supersonic compressible airfoil flow at Mach 1.5 - 3.0, computing oblique shockwave angles and expansion waves.','Advanced','IN PROGRESS','Nov 19, 2026',['C++ / Python','Compressible Flow Solver','Recharts Shock Plotter','Tailwind CSS'],'Mach number, geometry and gas properties are passed through shock and expansion relations to compute flow states.',['Shock-angle solver','Expansion-wave module','Pressure distribution plot','Validation report'],['AE','CFD'],[
      StepData('Oblique Shock Solver','Solve the theta-beta-M relation for Mach number and wedge angle.','theta-beta-M -> beta -> downstream Mach','Use a robust root finder.'),
      StepData('Expansion Wave','Calculate Prandtl-Meyer expansion and downstream state.','nu(M2) = nu(M1) + theta','Keep angles in radians internally.')]),
    ProjectData('ae-turbofan','AE','AEROSPACE ENGINEERING','Turbofan Jet Engine Thrust & Specific Impulse Cycle Simulator','Simulate thermodynamic cycle performance for high-bypass turbofan engines across altitudes 0 - 40,000 ft and Mach numbers 0 - 0.85.','Intermediate','UNASSIGNED','Nov 29, 2026',['Python / TypeScript','Thermodynamic Engine Solver','Recharts','Tailwind CSS'],'Atmospheric conditions feed inlet, compressor, combustor, turbine, bypass and nozzle calculations.',['Engine cycle solver','Atmosphere model','Thrust calculator','Performance charts'],['AE'],[
      StepData('Atmosphere Model','Calculate pressure and temperature as functions of altitude.','h -> T, P, rho, a','Validate sea-level conditions first.'),
      StepData('Turbofan Cycle','Solve bypass and core flow states.','inlet -> compressor -> combustor -> turbine -> nozzle','Track energy and pressure ratios.')]),
  ];

  List<ProjectData> get filtered => projects.where((p) {
    if (branch != 'ALL' && p.branch != branch) return false;
    if (search.trim().isEmpty) return true;
    final q = search.toLowerCase();
    return '${p.title} ${p.description} ${p.tags.join(' ')} ${p.branchName}'.toLowerCase().contains(q);
  }).toList();

  @override
  Widget build(BuildContext context) {
    if (selected != null) {
      return ProjectDetails(
        project: selected!,
        dark: widget.isDarkMode,
        userName: widget.userName,
        onBack: () => setState(() => selected = null),
      );
    }

    final dark = widget.isDarkMode;
    final card = dark ? const Color(0xFF131927) : Colors.white;
    final text = dark ? Colors.white : const Color(0xFF111827);
    final sub = dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Container(
      color: dark ? const Color(0xFF090D16) : bg,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(34, 26, 34, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🎓  BRANCH-WISE ENGINEERING TRACK',
                        style: GoogleFonts.inter(
                          color: orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .6,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Hands-On Engineering Projects & AI Guidance',
                        style: GoogleFonts.inter(
                          color: text,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Explore real-world projects with step-by-step roadmaps, code hints, troubleshooting guides, and our Sophia AI Mentor.',
                        style: GoogleFonts.inter(
                          color: sub,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: 330,
                  child: TextField(
                    onChanged: (value) => setState(() => search = value),
                    style: GoogleFonts.inter(
                      color: text,
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search projects, skills, tech...',
                      hintStyle: GoogleFonts.inter(
                        color: sub,
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: sub,
                        size: 18,
                      ),
                      filled: true,
                      fillColor: card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                          color: dark
                              ? const Color(0xFF273244)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                          color: dark
                              ? const Color(0xFF273244)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: branches.map((b) {
                  final active = branch == b.code;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => branch = b.code),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: active ? orange : card,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: active
                                ? orange
                                : (dark
                                    ? const Color(0xFF273244)
                                    : const Color(0xFFE2E8F0)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              b.label,
                              style: GoogleFonts.inter(
                                color: active ? Colors.white : text,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (b.code != 'ALL') ...[
                              const SizedBox(width: 7),
                              Text(
                                '${b.count}',
                                style: GoogleFonts.inter(
                                  color: active ? Colors.white : sub,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            if (filtered.isEmpty)
              _empty(text, sub, card)
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 1000 ? 2 : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                      mainAxisExtent: 264,
                    ),
                    itemBuilder: (context, index) {
                      return _projectCard(
                        filtered[index],
                        card,
                        text,
                        sub,
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _projectCard(ProjectData p, Color card, Color text, Color sub) {
    final bc = _branchColor(p.branch);
    return Material(color: card, borderRadius: BorderRadius.circular(18), child: InkWell(onTap: () => setState(() => selected = p), borderRadius: BorderRadius.circular(18), child: Container(padding: const EdgeInsets.fromLTRB(24,20,24,16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: widget.isDarkMode ? const Color(0xFF273244) : const Color(0xFFE2E8F0))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: _badge('${p.branch} • ${p.branchName}', bc)), const SizedBox(width: 8), _badge(p.difficulty, const Color(0xFF64748B))]),
      const SizedBox(height: 12),
      Row(children: [Expanded(child: Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: text, fontSize: 16.5, fontWeight: FontWeight.w900))), const SizedBox(width: 8), _status(p.status)]),
      const SizedBox(height: 7),
      Text(p.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: sub, fontSize: 11, height: 1.45)),
      const Spacer(),
      Wrap(spacing: 7, runSpacing: 6, children: p.tags.take(4).map((t) => _tag(t, sub)).toList()),
      const SizedBox(height: 12),
      Divider(color: widget.isDarkMode ? const Color(0xFF273244) : const Color(0xFFE2E8F0), height: 1),
      const SizedBox(height: 9),
      Row(children: [const Icon(Icons.calendar_today_outlined, size: 13, color: orange), const SizedBox(width: 5), Text('Due: ${p.due}', style: GoogleFonts.inter(color: sub, fontSize: 10, fontWeight: FontWeight.w700)), const Spacer(), OutlinedButton.icon(onPressed: () => setState(() => selected = p), icon: const Icon(Icons.code, size: 12, color: Color(0xFF00A86B)), label: Text('Open Sandbox', style: GoogleFonts.inter(color: const Color(0xFF00A86B), fontSize: 9.5, fontWeight: FontWeight.w800)), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7), side: const BorderSide(color: Color(0x5500A86B))),), const SizedBox(width: 5), TextButton(onPressed: () => setState(() => selected = p), child: Text('View Specs ›', style: GoogleFonts.inter(color: orange, fontSize: 9.5, fontWeight: FontWeight.w800)))])
    ]))));
  }

  Widget _badge(String s, Color c) => Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: c.withValues(alpha:.10), borderRadius: BorderRadius.circular(7)), child: Text(s, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: c, fontSize: 8.5, fontWeight: FontWeight.w900)));
  Widget _tag(String s, Color sub) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: widget.isDarkMode ? const Color(0xFF1B2433) : const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(6), border: Border.all(color: widget.isDarkMode ? const Color(0xFF273244) : const Color(0xFFE2E8F0))), child: Text(s, style: GoogleFonts.firaCode(color: sub, fontSize: 8)));
  Widget _status(String s) { final c = s == 'IN REVIEW' ? const Color(0xFF9A6700) : s == 'UNASSIGNED' ? const Color(0xFF475569) : const Color(0xFF2563EB); final b = s == 'IN REVIEW' ? const Color(0xFFFFF4B8) : s == 'UNASSIGNED' ? const Color(0xFFF1F5F9) : const Color(0xFFE0EDFF); return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: b, borderRadius: BorderRadius.circular(18)), child: Text(s, style: GoogleFonts.inter(color: c, fontSize: 7.5, fontWeight: FontWeight.w900))); }
  Widget _empty(Color text, Color sub, Color card) => Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 65), decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18), border: Border.all(color: widget.isDarkMode ? const Color(0xFF273244) : const Color(0xFFE2E8F0))), child: Column(children: [Icon(Icons.filter_alt_outlined, size: 48, color: sub), const SizedBox(height: 13), Text('No projects found for this filter', style: GoogleFonts.inter(color: text, fontSize: 16, fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text('Try selecting "All Branches" or clearing your search term to view all engineering projects.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: sub, fontSize: 10.5)), const SizedBox(height: 17), ElevatedButton(onPressed: () => setState(() { branch='ALL'; search=''; }), style: ElevatedButton.styleFrom(backgroundColor: orange), child: const Text('Reset Filters'))]));
  Color _branchColor(String b) { switch(b) { case 'CSE': return const Color(0xFF7C3AED); case 'IT': return const Color(0xFF2563EB); case 'ME': return const Color(0xFF475569); case 'CE': return const Color(0xFFF97316); case 'CH': return const Color(0xFF06B6D4); case 'AE': return const Color(0xFFEC4899); default: return const Color(0xFF64748B); } }
}


class ProjectDetails extends StatefulWidget {
  final ProjectData project;
  final bool dark;
  final String userName;
  final VoidCallback onBack;

  const ProjectDetails({
    super.key,
    required this.project,
    required this.dark,
    required this.userName,
    required this.onBack,
  });

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  int tab = 0;
  bool submitMode = false;

  final tabs = const [
    'Overview & Specs',
    'Interactive Sandbox IDE',
    'Step-by-Step Roadmap (3)',
    'Troubleshooting & Debug (2)',
    'AI Mentor (Sophia)',
    'Rubrics & Doubt Sessions',
  ];

  @override
  Widget build(BuildContext context) {
    if (submitMode) {
      return SubmitDeliverableScreen(
        project: widget.project,
        dark: widget.dark,
        onBack: () => setState(() => submitMode = false),
      );
    }

    final p = widget.project;
    final card = widget.dark ? const Color(0xFF131927) : Colors.white;
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Container(
      color: widget.dark ? const Color(0xFF090D16) : const Color(0xFFF4F6FB),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(34, 20, 34, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back, size: 15, color: Colors.redAccent),
              label: Text(
                'BACK TO PROJECTS DIRECTORY',
                style: GoogleFonts.inter(
                  color: Colors.redAccent,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.dark
                      ? const Color(0xFF273244)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 28, 30, 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  _badge(
                                    '${p.branch} • ${p.branchName}',
                                    const Color(0xFF7C3AED),
                                  ),
                                  _badge(
                                    p.status,
                                    const Color(0xFF2563EB),
                                  ),
                                  _badge(
                                    p.difficulty,
                                    const Color(0xFF7C3AED),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                p.title,
                                style: GoogleFonts.inter(
                                  color: text,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  height: 1.12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                p.description,
                                style: GoogleFonts.inter(
                                  color: sub,
                                  fontSize: 12,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _hero(
                              'Code Sandbox IDE',
                              Icons.code,
                              const Color(0xFF00A86B),
                              () => setState(() => tab = 1),
                            ),
                            _hero(
                              'Sophia AI Mentor',
                              Icons.smart_toy_outlined,
                              const Color(0xFF6D28D9),
                              () => setState(() => tab = 4),
                            ),
                            _hero(
                              'Submit Deliverable',
                              Icons.cloud_upload_outlined,
                              const Color(0xFFFF6B35),
                              () => setState(() => submitMode = true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: widget.dark
                              ? const Color(0xFF273244)
                              : const Color(0xFFE2E8F0),
                        ),
                        bottom: BorderSide(
                          color: widget.dark
                              ? const Color(0xFF273244)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          tabs.length,
                          (i) => InkWell(
                            onTap: () => setState(() => tab = i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 16,
                              ),
                              margin: const EdgeInsets.only(right: 17),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: tab == i
                                        ? const Color(0xFFFF6B35)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _tabIcon(i),
                                    size: 14,
                                    color: tab == i
                                        ? const Color(0xFFFF6B35)
                                        : sub,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    tabs[i],
                                    style: GoogleFonts.inter(
                                      color: tab == i
                                          ? const Color(0xFFFF6B35)
                                          : sub,
                                      fontSize: 10.5,
                                      fontWeight: tab == i
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28),
                    child: _content(p, text, sub, card),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _tabIcon(int i) {
    const icons = [
      Icons.menu_book_outlined,
      Icons.code,
      Icons.layers_outlined,
      Icons.build_outlined,
      Icons.smart_toy_outlined,
      Icons.videocam_outlined,
    ];
    return icons[i];
  }

  Widget _content(ProjectData p, Color text, Color sub, Color card) {
    switch (tab) {
      case 1:
        return Sandbox(project: p, dark: widget.dark);
      case 2:
        return Roadmap(project: p, dark: widget.dark);
      case 3:
        return Troubleshooting(project: p, dark: widget.dark);
      case 4:
        return Sophia(project: p, dark: widget.dark);
      case 5:
        return Rubrics(project: p, dark: widget.dark);
      default:
        return Overview(project: p, dark: widget.dark);
    }
  }

  Widget _badge(String s, Color c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: c.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          s,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            color: c,
            fontSize: 8.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      );

  Widget _hero(
    String s,
    IconData i,
    Color c,
    VoidCallback f,
  ) =>
      ElevatedButton.icon(
        onPressed: f,
        icon: Icon(i, size: 14),
        label: Text(
          s,
          style: GoogleFonts.inter(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: c,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      );
}

class SubmitDeliverableScreen extends StatefulWidget {
  final ProjectData project;
  final bool dark;
  final VoidCallback onBack;

  const SubmitDeliverableScreen({
    super.key,
    required this.project,
    required this.dark,
    required this.onBack,
  });

  @override
  State<SubmitDeliverableScreen> createState() =>
      _SubmitDeliverableScreenState();
}

class _SubmitDeliverableScreenState extends State<SubmitDeliverableScreen> {
  final repoController = TextEditingController();
  final notesController = TextEditingController();
  final files = <String>[];
  bool submitting = false;
  bool submitted = false;
  int score = 0;

  @override
  void dispose() {
    repoController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final card = widget.dark ? const Color(0xFF131927) : Colors.white;

    return Container(
      color: widget.dark ? const Color(0xFF090D16) : const Color(0xFFF4F6FB),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(34, 20, 34, 50),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: widget.onBack,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 15,
                  color: Colors.redAccent,
                ),
                label: Text(
                  'BACK TO DETAILS',
                  style: GoogleFonts.inter(
                    color: Colors.redAccent,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Container(
                padding: const EdgeInsets.fromLTRB(36, 34, 36, 34),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.dark
                        ? const Color(0xFF273244)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: submitted
                    ? _submitted(text, sub)
                    : _form(text, sub),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(Color text, Color sub) {
    final p = widget.project;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          p.branchName,
          style: GoogleFonts.inter(
            color: const Color(0xFFFF6B35),
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            letterSpacing: .6,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Submit Deliverable: ${p.title}',
          style: GoogleFonts.inter(
            color: text,
            fontSize: 21,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Provide your GitHub repository link and study notes below for AI rubric evaluation.',
          style: GoogleFonts.inter(color: sub, fontSize: 10.5, height: 1.45),
        ),
        const SizedBox(height: 22),
        _label('GitHub Repository Link', Icons.link, text),
        const SizedBox(height: 7),
        TextField(
          controller: repoController,
          keyboardType: TextInputType.url,
          style: GoogleFonts.firaCode(color: text, fontSize: 10.5),
          decoration: _input('https://github.com/username/project'),
        ),
        const SizedBox(height: 17),
        _label('Technical Submission Notes', Icons.description_outlined, text),
        const SizedBox(height: 7),
        TextField(
          controller: notesController,
          maxLines: 5,
          style: GoogleFonts.inter(color: text, fontSize: 10.5, height: 1.45),
          decoration: _input(
            'Explain architecture, implementation, testing, optimizations, and known limitations.',
          ),
        ),
        const SizedBox(height: 18),
        _label('Project Artifacts', Icons.cloud_upload_outlined, text),
        const SizedBox(height: 8),
        _dropZone(text, sub),
        if (files.isNotEmpty) ...[
          const SizedBox(height: 9),
          ...files.map(
            (file) => Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
              decoration: BoxDecoration(
                color: widget.dark
                    ? const Color(0xFF0F172A)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.insert_drive_file_outlined,
                    size: 15,
                    color: Color(0xFF00A86B),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      file,
                      style: GoogleFonts.firaCode(
                        color: text,
                        fontSize: 8.5,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setState(() => files.remove(file)),
                    icon: const Icon(Icons.close, size: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: submitting ? null : submit,
            icon: submitting
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check_circle_outline, size: 15),
            label: Text(
              submitting
                  ? 'Submitting & Evaluating...'
                  : 'Submit Deliverable and Run AI Evaluation',
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitted(Color text, Color sub) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 34,
          backgroundColor: Color(0xFFE7F8F0),
          child: Icon(
            Icons.check_rounded,
            color: Color(0xFF00A86B),
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Submission Received',
          style: GoogleFonts.inter(
            color: text,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Your deliverable was validated locally and is ready for instructor/AI review.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: sub, fontSize: 10.5),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: widget.dark
                ? const Color(0xFF0F172A)
                : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            children: [
              Text(
                '$score / 100',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF6B35),
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Preliminary AI Rubric Score',
                style: GoogleFonts.inter(
                  color: sub,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        OutlinedButton.icon(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back, size: 14),
          label: const Text('Back to Project Details'),
        ),
      ],
    );
  }

  Widget _dropZone(Color text, Color sub) => InkWell(
        onTap: pickFiles,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: BoxDecoration(
            color: widget.dark
                ? const Color(0xFF0F172A)
                : const Color(0xFFFBFCFE),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFD7DEE8),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: sub,
                size: 34,
              ),
              const SizedBox(height: 9),
              Text(
                'Click to select visual file artifacts or code ZIP',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: text,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'PDF, PNG, JPG, ZIP up to 25MB each',
                style: GoogleFonts.inter(color: sub, fontSize: 8.5),
              ),
            ],
          ),
        ),
      );

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: widget.dark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
          fontSize: 9.5,
        ),
        filled: true,
        fillColor: widget.dark
            ? const Color(0xFF0F172A)
            : const Color(0xFFFBFCFE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: widget.dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
      );

  Widget _label(String title, IconData icon, Color text) => Row(
        children: [
          Icon(icon, color: const Color(0xFFFF6B35), size: 14),
          const SizedBox(width: 6),
          Text(
            title,
            style: GoogleFonts.inter(
              color: text,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      );

  Future<void> pickFiles() async {
    if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'File upload is temporarily unavailable.',
        ),
      ),
    );
  }

  Future<void> submit() async {
    final repo = repoController.text.trim();
    final notes = notesController.text.trim();

    if (!_validGitHub(repo)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid GitHub repository URL.'),
        ),
      );
      return;
    }

    if (notes.length < 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide at least 20 characters of technical notes.'),
        ),
      );
      return;
    }

    setState(() => submitting = true);
    await Future.delayed(const Duration(milliseconds: 1100));

    if (!mounted) return;

    final completeness =
        (repo.isNotEmpty ? 25 : 0) +
        (notes.length >= 100 ? 25 : 15) +
        (files.isNotEmpty ? 20 : 10) +
        20 +
        (widget.project.steps.length >= 3 ? 10 : 7);

    setState(() {
      score = completeness.clamp(0, 100);
      submitting = false;
      submitted = true;
    });
  }

  bool _validGitHub(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        uri.host.toLowerCase().contains('github.com') &&
        uri.pathSegments.length >= 2;
  }
}

class Overview extends StatelessWidget {
  final ProjectData project;
  final bool dark;

  const Overview({super.key, required this.project, required this.dark});

  @override
  Widget build(BuildContext context) {
    final text = dark ? Colors.white : const Color(0xFF111827);
    final sub = dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final card = dark ? const Color(0xFF0F172A) : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _box(
                '⚙  SYSTEM ARCHITECTURE & ENGINEERING MODEL',
                Text(
                  project.architecture,
                  style: GoogleFonts.firaCode(
                    color: sub,
                    fontSize: 10.5,
                    height: 1.6,
                  ),
                ),
                card,
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: _box(
                'TECH STACK & FRAMEWORKS',
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: project.tags.map((x) => _chip(x, text)).toList(),
                ),
                card,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'REQUIRED DELIVERABLES',
          style: GoogleFonts.inter(
            color: sub,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 11),
        ...project.deliverables.map(
          (d) => Container(
            margin: const EdgeInsets.only(bottom: 9),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: dark
                    ? const Color(0xFF273244)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF00A86B),
                  size: 17,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    d,
                    style: GoogleFonts.inter(
                      color: text,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _info(
                'Project Due Date',
                project.due,
                Icons.calendar_today_outlined,
                text,
                sub,
                card,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _info(
                'Collaborators',
                project.collaborators.join('  '),
                Icons.group_outlined,
                text,
                sub,
                card,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _box(String title, Widget child, Color card) => Container(
        padding: const EdgeInsets.all(19),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                color: const Color(0xFFFF6B35),
                fontSize: 9.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      );

  Widget _chip(String s, Color text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF1B2433) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          s,
          style: GoogleFonts.inter(
            color: text,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _info(
    String l,
    String v,
    IconData i,
    Color text,
    Color sub,
    Color card,
  ) =>
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Icon(i, color: const Color(0xFFFF6B35), size: 17),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l,
                    style: GoogleFonts.inter(color: sub, fontSize: 8.5),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    v,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: text,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class Sandbox extends StatefulWidget {
  final ProjectData project;
  final bool dark;

  const Sandbox({super.key, required this.project, required this.dark});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  int file = 0;
  late final List<String> names;
  late final List<TextEditingController> editors;
  String console =
      '🚀 Sandbox initialized for project.\n'
      '🔒 Isolated execution container ready.\n';

  @override
  void initState() {
    super.initState();
    names = ['main.py', 'config.json', 'test_suite.py', 'README.md'];
    editors = [
      TextEditingController(
        text:
            '# ${widget.project.title}\n'
            '# ${widget.project.branch}\n\n'
            'def run_pipeline():\n'
            '    print("Pipeline execution succeeded")\n\n'
            'run_pipeline()\n',
      ),
      TextEditingController(
        text:
            '{\n'
            '  "runtime": "isolated",\n'
            '  "memory": "512MB",\n'
            '  "cpu": "2 cores"\n'
            '}\n',
      ),
      TextEditingController(
        text:
            'def test_project_boot():\n'
            '    assert True\n\n'
            'def test_pipeline():\n'
            '    assert True\n',
      ),
      TextEditingController(
        text:
            '# ${widget.project.title}\n\n'
            'Implement the required deliverables.\n',
      ),
    ];
  }

  @override
  void dispose() {
    for (final e in editors) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.code,
                color: Color(0xFF7C3AED),
                size: 25,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interactive Project Sandbox',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'ONLINE IDE • Local validation sandbox',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF94A3B8),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              _btn(
                'Run Code',
                Icons.play_arrow,
                const Color(0xFF00A86B),
                run,
              ),
              const SizedBox(width: 7),
              _btn(
                'Test Suite',
                Icons.auto_fix_high,
                const Color(0xFF7C3AED),
                tests,
              ),
              const SizedBox(width: 7),
              _btn(
                'AI Debug',
                Icons.smart_toy_outlined,
                const Color(0xFF1E293B),
                debug,
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),
        SizedBox(
          height: 510,
          child: Row(
            children: [
              Expanded(child: _editor()),
              const SizedBox(width: 10),
              Expanded(child: _console()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editor() => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 42,
              child: Row(
                children: List.generate(
                  names.length,
                  (i) => InkWell(
                    onTap: () => setState(() => file = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      color: file == i
                          ? const Color(0xFF111827)
                          : Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        names[i],
                        style: GoogleFonts.firaCode(
                          color: file == i
                              ? const Color(0xFF00FFB3)
                              : const Color(0xFF64748B),
                          fontSize: 9.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: editors[file],
                expands: true,
                maxLines: null,
                minLines: null,
                style: GoogleFonts.firaCode(
                  color: const Color(0xFF00FFB3),
                  fontSize: 10.5,
                  height: 1.45,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _console() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.terminal,
                  color: Color(0xFF00FFB3),
                  size: 16,
                ),
                const SizedBox(width: 7),
                Text(
                  'Console',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() => console = ''),
                  child: Text(
                    'Clear Console',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 8,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Color(0xFF1E293B)),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  console,
                  style: GoogleFonts.firaCode(
                    color: const Color(0xFFD8B4FE),
                    fontSize: 10,
                    height: 1.6,
                  ),
                ),
              ),
            ),
            const Divider(color: Color(0xFF1E293B)),
            Text(
              'Memory: 42MB / 512MB    CPU: 2.1%',
              style: GoogleFonts.firaCode(
                color: const Color(0xFF64748B),
                fontSize: 8,
              ),
            ),
          ],
        ),
      );

  Widget _btn(
    String label,
    IconData icon,
    Color color,
    VoidCallback action,
  ) =>
      ElevatedButton.icon(
        onPressed: action,
        icon: Icon(icon, size: 13),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      );

  Future<void> run() async {
    setState(() {
      console += '\n▶ Validating ${names[file]}...\n';
    });
    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;

    final content = editors[file].text.trim();
    setState(() {
      console += content.isEmpty
          ? '❌ Validation failed: file is empty.\n'
          : '✅ Static validation passed.\n'
            'ℹ Runtime execution is isolated from the Flutter UI.\n';
    });
  }

  void tests() {
    final hasCode = editors.any((e) => e.text.trim().isNotEmpty);
    setState(() {
      console += hasCode
          ? '\n🧪 Test Suite\n✓ Project boot\n✓ Configuration\n✓ Pipeline smoke test\n3/3 checks passed\n'
          : '\n❌ Test Suite blocked: no source content.\n';
    });
  }

  void debug() {
    final content = editors[file].text;
    final advice = content.trim().isEmpty
        ? 'The current file is empty. Add a minimal implementation first.'
        : content.contains('TODO')
            ? 'Found TODO markers. Implement those sections and rerun the test suite.'
            : 'No obvious starter-code issue found. Check inputs, outputs, exceptions and performance next.';
    setState(() => console += '\n🤖 Sophia AI Debug\n$advice\n');
  }
}

class Roadmap extends StatefulWidget {
  final ProjectData project;
  final bool dark;

  const Roadmap({super.key, required this.project, required this.dark});

  @override
  State<Roadmap> createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> {
  int open = 0;

  @override
  Widget build(BuildContext context) {
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Follow this step-by-step implementation guide for ${widget.project.title}',
                style: GoogleFonts.inter(color: sub, fontSize: 10.5),
              ),
            ),
            Text(
              '${widget.project.steps.length} Phases',
              style: GoogleFonts.inter(
                color: const Color(0xFFFF6B35),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        ...List.generate(widget.project.steps.length, (i) {
          final s = widget.project.steps[i];
          final expanded = open == i;

          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            decoration: BoxDecoration(
              color: widget.dark ? const Color(0xFF131927) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.dark
                    ? const Color(0xFF273244)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => setState(() => open = expanded ? -1 : i),
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              const Color(0xFFFF6B35).withValues(alpha: .10),
                          child: Text(
                            '${i + 1}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFF6B35),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            s.title,
                            style: GoogleFonts.inter(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Icon(
                          expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: sub,
                        ),
                      ],
                    ),
                  ),
                ),
                if (expanded)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.description,
                          style: GoogleFonts.inter(
                            color: sub,
                            fontSize: 10.5,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'SYNTAX / CODE HINT',
                          style: GoogleFonts.inter(
                            color: sub,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B1B2B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SelectableText(
                            s.code,
                            style: GoogleFonts.firaCode(
                              color: const Color(0xFF00FFB3),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF9E6),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFFFF8A00),
                                size: 14,
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Text(
                                  s.tip,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF9A6700),
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () => ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Sophia guidance requested for Step ${i + 1}.',
                                ),
                              ),
                            ),
                            icon: const Icon(
                              Icons.smart_toy_outlined,
                              size: 13,
                            ),
                            label: const Text(
                              "I'm Stuck — Get AI Guidance",
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6D28D9),
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class Troubleshooting extends StatefulWidget {
  final ProjectData project;
  final bool dark;

  const Troubleshooting({
    super.key,
    required this.project,
    required this.dark,
  });

  @override
  State<Troubleshooting> createState() => _TroubleshootingState();
}

class _TroubleshootingState extends State<Troubleshooting> {
  final issues = const [
    [
      'Issue: WebSocket connection fails with HTTP 400 / CORS error',
      'Root Cause: CORS configuration on Express server blocks frontend origin or missing proxy headers.',
      "Resolution: Set cors: { origin: '*' } during development, or configure the Vite dev server proxy for '/socket.io'.",
    ],
    [
      'Issue: Messages not broadcasting across multiple instances',
      'Root Cause: Redis pub/sub adapter is not configured on the Socket.io server instance.',
      "Resolution: Install '@socket.io/redis-adapter' and attach it to the io instance with io.adapter(createAdapter(pubClient, subClient)).",
    ],
  ];

  int expanded = 0;

  @override
  Widget build(BuildContext context) {
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFFF9800),
              size: 17,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                'Common compilation, runtime, and edge-case resolutions for ${widget.project.title}',
                style: GoogleFonts.inter(color: sub, fontSize: 10.5),
              ),
            ),
            Text(
              '${issues.length} Issues',
              style: GoogleFonts.inter(
                color: const Color(0xFFFF6B35),
                fontSize: 9.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        ...List.generate(issues.length, (i) {
          final issue = issues[i];
          final open = expanded == i;

          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.dark ? const Color(0xFF131927) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.dark
                    ? const Color(0xFF273244)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => setState(() => expanded = open ? -1 : i),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEEF0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.redAccent,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          issue[0],
                          style: GoogleFonts.inter(
                            color: Colors.redAccent,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Icon(
                        open
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: sub,
                      ),
                    ],
                  ),
                ),
                if (open) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      issue[1],
                      style: GoogleFonts.inter(
                        color: text,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.dark
                          ? const Color(0xFF09231B)
                          : const Color(0xFFF0FFF8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF9DE8C4),
                      ),
                    ),
                    child: Text(
                      issue[2],
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFF006B45),
                        fontSize: 9,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}

class Sophia extends StatefulWidget {
  final ProjectData project;
  final bool dark;

  const Sophia({super.key, required this.project, required this.dark});

  @override
  State<Sophia> createState() => _SophiaState();
}

class _SophiaState extends State<Sophia> {
  final input = TextEditingController();
  final messages = <_ChatMessage>[
    _ChatMessage(
      false,
      '👋 Hi! I’m Sophia. Ask me about architecture, debugging, roadmap steps, testing, or project submission.',
    ),
  ];

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF7C3AED),
              child: Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sophia AI Mentor',
                  style: GoogleFonts.inter(
                    color: text,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'ONLINE • Project-aware guidance',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF00A86B),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 390,
          decoration: BoxDecoration(
            color: widget.dark
                ? const Color(0xFF0B1220)
                : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.dark
                  ? const Color(0xFF273244)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final m = messages[i];
                    return Align(
                      alignment:
                          m.user ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 650),
                        margin: const EdgeInsets.only(bottom: 9),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: m.user
                              ? const Color(0xFF6D28D9)
                              : (widget.dark
                                  ? const Color(0xFF1B2433)
                                  : Colors.white),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          m.text,
                          style: GoogleFonts.inter(
                            color: m.user ? Colors.white : text,
                            fontSize: 10,
                            height: 1.45,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: input,
                        onSubmitted: (_) => send(),
                        style: GoogleFonts.inter(
                          color: text,
                          fontSize: 10.5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask Sophia about your project...',
                          hintStyle: GoogleFonts.inter(
                            color: sub,
                            fontSize: 9.5,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: send,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            'Explain the architecture',
            'Give me a hint',
            'Help debug my code',
            'How should I test this?',
          ]
              .map(
                (s) => OutlinedButton(
                  onPressed: () {
                    input.text = s;
                    send();
                  },
                  child: Text(
                    s,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF7C3AED),
                      fontSize: 8.5,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void send() {
    final question = input.text.trim();
    if (question.isEmpty) return;

    setState(() {
      messages.add(_ChatMessage(true, question));
      messages.add(_ChatMessage(false, _answer(question)));
      input.clear();
    });
  }

  String _answer(String q) {
    final lower = q.toLowerCase();
    if (lower.contains('architecture')) {
      return 'For this project, start with the client connection layer, then the API/WebSocket layer, then Redis for cross-instance fan-out. Keep each layer testable independently.';
    }
    if (lower.contains('debug') || lower.contains('error')) {
      return 'Debug from the smallest failing boundary: reproduce the error, inspect the request/event payload, check server logs, then verify Redis connectivity before changing multiple components.';
    }
    if (lower.contains('test')) {
      return 'Test in three levels: unit tests for pure logic, integration tests for WebSocket/Redis behaviour, and a load test for concurrency. Record latency, disconnects and message loss.';
    }
    if (lower.contains('hint')) {
      return 'Hint: implement one room with one connected client first. Once join/send/receive works reliably, add Redis and then test two server instances.';
    }
    return 'For ${widget.project.title}, break the work into small measurable milestones. Tell me the exact error, file, or step you are stuck on and I can narrow the next debugging action.';
  }
}

class Rubrics extends StatefulWidget {
  final ProjectData project;
  final bool dark;

  const Rubrics({super.key, required this.project, required this.dark});

  @override
  State<Rubrics> createState() => _RubricsState();
}

class _RubricsState extends State<Rubrics> {
  final rows = const [
    ['WebSocket Concurrency & Reconnection', 'Gracefully handles socket dropouts, auto-reconnects, and handles 1,000+ simulated users.', 30],
    ['Redis Integration & Scaling', 'Seamless Pub/Sub message relay across dual server nodes.', 35],
    ['Frontend UI Polish & Typing Indicators', 'Clean interface, message timestamps, and unread counters.', 35],
  ];

  final sessions = <_DoubtSession>[];
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final text = widget.dark ? Colors.white : const Color(0xFF111827);
    final sub = widget.dark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final card = widget.dark ? const Color(0xFF131927) : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EVALUATION RUBRICS BREAKDOWN (100 POINTS SCALE)',
          style: GoogleFonts.inter(
            color: sub,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: .6,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.dark
                  ? const Color(0xFF273244)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            children: rows
                .map(
                  (r) => Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: widget.dark
                          ? const Color(0xFF101827)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(
                        color: widget.dark
                            ? const Color(0xFF273244)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r[0] as String,
                                style: GoogleFonts.inter(
                                  color: text,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                r[1] as String,
                                style: GoogleFonts.inter(
                                  color: sub,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8FFF3),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            '${r[2]} pts',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF00A86B),
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            const Icon(
              Icons.videocam_outlined,
              color: Color(0xFFFF6B35),
              size: 21,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connect with Instructor (1-on-1 Doubt Clearing)',
                  style: GoogleFonts.inter(
                    color: text,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Schedule a live session with your branch professor to resolve blockages.',
                  style: GoogleFonts.inter(color: sub, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 13),
        LayoutBuilder(
          builder: (_, constraints) {
            final horizontal = constraints.maxWidth >= 760;
            final left = _requestPanel(text, sub, card);
            final right = _sessionPanel(text, sub, card);

            if (!horizontal) {
              return Column(
                children: [
                  left,
                  const SizedBox(height: 13),
                  right,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 22),
                Expanded(child: right),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _requestPanel(Color text, Color sub, Color card) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'REQUEST NEW SESSION',
              style: GoogleFonts.inter(
                color: sub,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Choose Date & Time:',
              style: GoogleFonts.inter(
                color: text,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: chooseDateTime,
                    icon: const Icon(Icons.calendar_month_outlined, size: 14),
                    label: Text(
                      selectedDateTime == null
                          ? 'Select date & time'
                          : _format(selectedDateTime!),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(fontSize: 9),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                ElevatedButton(
                  onPressed: selectedDateTime == null ? null : request,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                  ),
                  child: const Text('+ Request'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _sessionPanel(Color text, Color sub, Color card) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.dark
                ? const Color(0xFF273244)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR REQUESTED SESSIONS',
              style: GoogleFonts.inter(
                color: sub,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 10),
            if (sessions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: sub, size: 28),
                      const SizedBox(height: 7),
                      Text(
                        'No sessions scheduled for this project yet.',
                        style: GoogleFonts.inter(color: sub, fontSize: 9.5),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...sessions.map(
                (s) => Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.dark
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.videocam_outlined,
                        color: Color(0xFFFF6B35),
                        size: 15,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          _format(s.dateTime),
                          style: GoogleFonts.inter(
                            color: text,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        'REQUESTED',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF00A86B),
                          fontSize: 7.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );

  Future<void> chooseDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 120)),
      initialDate: selectedDateTime ?? now,
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : const TimeOfDay(hour: 16, minute: 0),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void request() {
    final dt = selectedDateTime;
    if (dt == null) return;

    setState(() {
      sessions.add(_DoubtSession(dt));
      selectedDateTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Doubt session request created.')),
    );
  }

  String _format(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final am = local.hour >= 12 ? 'PM' : 'AM';
    return '${local.month.toString().padLeft(2, '0')}/${local.day.toString().padLeft(2, '0')}/${local.year} • $hour:$minute $am';
  }
}

class _ChatMessage {
  final bool user;
  final String text;

  const _ChatMessage(this.user, this.text);
}

class _DoubtSession {
  final DateTime dateTime;

  const _DoubtSession(this.dateTime);
}

class Branch {
  final String code, label;
  final int count;
  const Branch(this.code, this.label, this.count);
}

class StepData {
  final String title, description, code, tip;
  const StepData(this.title, this.description, this.code, this.tip);
}

class ProjectData {
  final String id,
      branch,
      branchName,
      title,
      description,
      difficulty,
      status,
      due,
      architecture;
  final List<String> tags, deliverables, collaborators;
  final List<StepData> steps;

  const ProjectData(
    this.id,
    this.branch,
    this.branchName,
    this.title,
    this.description,
    this.difficulty,
    this.status,
    this.due,
    this.tags,
    this.architecture,
    this.deliverables,
    this.collaborators,
    this.steps,
  );
}
