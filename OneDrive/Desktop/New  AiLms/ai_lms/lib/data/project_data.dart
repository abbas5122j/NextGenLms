import '"C:UsersabhijOneDriveDesktopNew  AiLmsai_lmslibmodelsproject_model.dart""C:UsersabhijOneDriveDesktopNew  AiLmsai_lmslibmodelsproject_model.dart"';

final List<EngineeringProject> allEngineeringProjects = [
  // 1. CSE - Real-time Multi-Room Chat
  EngineeringProject(
    id: 'proj_cse_1',
    title: 'Real-time Multi-Room Chat Engine with WebSockets & Redis',
    branchCode: 'CSE',
    branchName: 'CSE • COMPUTER SCIENCE & ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Intermediate',
    dueDate: 'Oct 28, 2026',
    summary:
        'Design and implement a high-concurrency, multi-room chat server using Node.js WebSockets (ws/Socket.io), backed by Redis Pub/Sub for horizontal scaling and message replay.',
    tags: ['React 18', 'TypeScript', 'Node.js', 'Socket.io', 'Redis', 'Tailwind CSS'],
    systemArchitecture:
        'Client UI connects via persistent WebSocket connections. Express handles initial auth and HTTP handshakes. Messages are published to Redis channels, enabling multi-node scalability across Cloud Run instances.',
    deliverables: [
      ProjectDeliverable(title: 'WebSocket Server Source Code', isCompleted: true),
      ProjectDeliverable(title: 'Redis Pub/Sub Connector Module', isCompleted: true),
      ProjectDeliverable(title: 'React Chat UI Component', isCompleted: true),
      ProjectDeliverable(title: 'Load Testing Benchmarks (10k conns)', isCompleted: false),
    ],
    techStack: ['React 18', 'TypeScript', 'Node.js', 'Socket.io', 'Redis', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'WebSocket Server Setup & Heartbeat Ping/Pong',
        description: 'Initialize an Express HTTP server integrated with `ws` or `Socket.io`. Implement ping/pong heartbeat logic to drop broken TCP connections within 30 seconds.',
        codeHint: '''// Server socket initialization
import { Server } from 'socket.io';
const io = new Server(server, { cors: { origin: '*' } });
io.on('connection', (socket) => {
  socket.on('join_room', (room) => socket.join(room));
});''',
        tip: 'Heartbeat timers prevent silent memory leaks from dead TCP sockets.',
      ),
      RoadmapStep(
        stepNumber: '2',
        title: 'Redis Pub/Sub Integration for Multi-Node Scaling',
        description: 'Attach `@socket.io/redis-adapter` using dual Redis clients (`pubClient` & `subClient`) to enable message broadcasting across distributed container nodes.',
        codeHint: '''import { createAdapter } from '@socket.io/redis-adapter';
import { createClient } from 'redis';
const pubClient = createClient({ url: 'redis://localhost:6379' });
const subClient = pubClient.duplicate();
io.adapter(createAdapter(pubClient, subClient));''',
        tip: 'Redis adapters ensure room events reach clients connected to different server pods.',
      ),
      RoadmapStep(
        stepNumber: '3',
        title: 'React Chat UI with Optimistic UI Updates & Scrolling',
        description: 'Build a responsive React chat interface with message timestamps, auto-scroll to bottom, typing indicators, and optimistic message rendering.',
        codeHint: '''const sendMessage = (text) => {
  setMessages(prev => [...prev, { text, status: 'sending', id: Date.now() }]);
  socket.emit('send_msg', { text, room });
};''',
        tip: 'Optimistic UI rendering improves user perception of instant messaging responsiveness.',
      ),
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: WebSocket connection fails with HTTP 400 or CORS error',
        rootCause: 'CORS configuration on Express server blocks frontend origin or missing proxy headers.',
        resolution: 'Set `cors: { origin: "*" }` during development, or configure Vite dev server proxy for `/socket.io`.',
      ),
      DebugIssue(
        title: 'Issue: Messages not broadcasting across multiple instances',
        rootCause: 'Redis pub/sub adapter is not configured on Socket.io server instance.',
        resolution: 'Install `@socket.io/redis-adapter` and attach it to the `io` instance using `io.adapter(createAdapter(pubClient, subClient))`.',
      ),
    ],
    rubrics: [
      RubricItem(title: 'WebSocket Concurrency & Reconnection', description: 'Gracefully handles socket dropouts, auto-reconnects, and handles 1,000+ simulated users.', points: 30),
      RubricItem(title: 'Redis Integration & Scaling', description: 'Seamless Pub/Sub message relay across dual server nodes.', points: 35),
      RubricItem(title: 'Frontend UI Polish & Typing Indicators', description: 'Clean Tailwind interface, message timestamps, and unread counters.', points: 35),
    ],
    initialCode: '''# Project: Real-time Multi-Room Chat Engine with WebSockets & Redis
# Branch: Computer Science & Engineering (CSE)
import time
import random

def initialize_project_environment():
    print("🚀 [SANDBOX ENGINE] Booting isolated container runtime...")
    print("📦 [DEPS] Loaded PyTorch, FastAPI, NumPy, and AsyncIO dependencies.")
    print("🔒 [CONTAINER] Memory cap: 512MB | CPU Quota: 2.0 Cores")

def run_pipeline():
    print("\\n--- Executing Real-time Multi-Room Chat Engine with WebSockets & Redis ---")
    start_time = time.time()
    
    samples = 12500
    print(f"📊 [DATASET] Loading {samples} validation vectors into tensor memory...")
    time.sleep(0.05)
    
    accuracy = 95.2 + random.uniform(0.1, 3.5)
    latency_ms = round(random.uniform(1.2, 3.8), 2)
    
    print("✅ [CHECK] WebSocket Server Source Code: PASSED")
    print("✅ [CHECK] Redis Pub/Sub Connector Module: PASSED")
    print("✅ [CHECK] React Chat UI Component: PASSED")
    print("⏳ [CHECK] Load Testing Benchmarks (10k conns): IN PROGRESS")
    print(f"\\n🎯 Benchmark Execution Succeeded! Latency: {latency_ms}ms | Reliability: {round(accuracy, 2)}%")

if __name__ == "__main__":
    initialize_project_environment()
    run_pipeline()
''',
  ),

  // 2. CSE - AI-Powered Vector Search & RAG
  EngineeringProject(
    id: 'proj_cse_2',
    title: 'AI-Powered Vector Search & RAG Engine',
    branchCode: 'CSE',
    branchName: 'CSE • COMPUTER SCIENCE & ENGINEERING',
    status: 'IN REVIEW',
    difficulty: 'Advanced',
    dueDate: 'Nov 05, 2026',
    summary:
        'Build a Retrieval-Augmented Generation (RAG) system that chunks documents, generates text embeddings using Google Gemini API, stores vectors in a high-density index, and synthesizes grounded answers.',
    tags: ['Google Gemini API', 'Python / TypeScript', 'Vector Store', 'React'],
    systemArchitecture:
        'Documents are parsed into 500-token chunks with 50-token overlaps. Google Gemini embedding models produce 768-dim embeddings stored in Qdrant/Pinecone. User queries query nearest neighbors cosine similarity before passing retrieved context into Gemini 1.5 Flash.',
    deliverables: [
      ProjectDeliverable(title: 'Document Parser & Recursive Chunking Pipeline', isCompleted: true),
      ProjectDeliverable(title: 'Gemini Embedding Generation Adapter', isCompleted: true),
      ProjectDeliverable(title: 'Vector DB Index & Cosine Similarity Query Engine', isCompleted: true),
      ProjectDeliverable(title: 'Grounded RAG Response Evaluator', isCompleted: true),
    ],
    techStack: ['Python 3.11', 'Google Gemini API', 'Qdrant Vector DB', 'FastAPI', 'LangChain'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Recursive Text Chunking & Tokenizer Setup',
        description: 'Parse raw PDFs/Markdown files and split text using overlapping token windows to preserve semantic continuity.',
        codeHint: '''from langchain.text_splitter import RecursiveCharacterTextSplitter
splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
chunks = splitter.split_text(raw_document)''',
        tip: 'Overlapping chunk boundaries prevent splitting key facts across adjacent vectors.',
      ),
      RoadmapStep(
        stepNumber: '2',
        title: 'Gemini Text Embeddings & Vector Storage',
        description: 'Generate embedding vectors via Gemini text-embedding-004 API and upsert vectors with metadata payloads into Qdrant.',
        codeHint: '''import google.generativeai as genai
embedding = genai.embed_content(
    model="models/text-embedding-004",
    content="User text chunk here",
    task_type="retrieval_document"
)''',
        tip: 'Specify task_type parameter to optimize vector projection for retrieval search.',
      ),
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Cosine similarity returns irrelevant context chunks',
        rootCause: 'Chunk size is either too large (diluting semantics) or embedding task type is misconfigured.',
        resolution: 'Reduce chunk_size to 300-500 tokens and ensure `task_type="retrieval_query"` is set during user search query encoding.',
      ),
    ],
    rubrics: [
      RubricItem(title: 'Embedding Retrieval Accuracy', description: 'Cosine similarity recall score > 88% on benchmark test questions.', points: 40),
      RubricItem(title: 'Gemini Hallucination Safeguards', description: 'Prompt enforces strict fallback when vector context does not contain answer.', points: 30),
      RubricItem(title: 'Query Latency Performance', description: 'End-to-end response generated in < 1.8 seconds.', points: 30),
    ],
    initialCode: '''# Project: AI-Powered Vector Search & RAG Engine
# Branch: Computer Science & Engineering (CSE)
import time

def run_rag_pipeline():
    print("⚡ [RAG PIPELINE] Initializing Gemini embedding model...")
    print("🔍 [VECTOR DB] Connecting to Qdrant cluster index...")
    time.sleep(0.08)
    print("✅ Vector Search Recall: 94.2% | Context retrieval: 310ms")

if __name__ == "__main__":
    run_rag_pipeline()
''',
  ),

  // 3. CSE - E-Commerce Microservices
  EngineeringProject(
    id: 'proj_cse_3',
    title: 'E-Commerce Microservices Architecture with Redis & Docker',
    branchCode: 'CSE',
    branchName: 'CSE • COMPUTER SCIENCE & ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Advanced',
    dueDate: 'Nov 12, 2026',
    summary:
        'Design a decoupled microservices platform with separate Product Catalog, Order Processing, and Payment Gateways communicating asynchronously via gRPC / REST.',
    tags: ['Docker', 'Node.js / Express', 'Redis', 'PostgreSQL'],
    systemArchitecture:
        'API Gateway routes incoming client traffic. Order Service publishes payment events to Redis streams. Worker containers consume messages asynchronously, ensuring ACID transactions in PostgreSQL with idempotent retry keys.',
    deliverables: [
      ProjectDeliverable(title: 'API Gateway & JWT Auth Middleware', isCompleted: true),
      ProjectDeliverable(title: 'Order Processing gRPC Service', isCompleted: true),
      ProjectDeliverable(title: 'Redis Event Queue Consumer', isCompleted: false),
    ],
    techStack: ['Docker Compose', 'Node.js', 'gRPC', 'Redis', 'PostgreSQL'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Docker Compose Container Orchestration',
        description: 'Define multi-container network links across API Gateway, Redis, PostgreSQL, and microservice containers.',
        codeHint: '''version: '3.8'
services:
  gateway:
    build: ./gateway
    ports: ["3000:3000"]
  postgres:
    image: postgres:15-alpine''',
        tip: 'Use Docker volume mounts for database persistent storage during container restarts.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Duplicate order processing during event consumer retries',
        rootCause: 'Missing idempotency key check in PostgreSQL transaction.',
        resolution: 'Store request UUIDs in Redis with a 24-hour TTL and reject repeated message IDs.',
      ),
    ],
    rubrics: [
      RubricItem(title: 'Decoupled Service Isolation', description: 'Services communicate strictly over gRPC without direct database access cross-talk.', points: 50),
      RubricItem(title: 'Container Resilience', description: 'Docker healthchecks automatically restart failing containers.', points: 50),
    ],
    initialCode: '''# Project: E-Commerce Microservices Architecture
print("🐳 [DOCKER] Microservices containers online!")
''',
  ),

  // 4. IT - Cyber Threat Detection
  EngineeringProject(
    id: 'proj_it_1',
    title: 'Cyber Threat Detection & Packet Inspection Firewall Engine',
    branchCode: 'IT',
    branchName: 'IT • INFORMATION TECHNOLOGY',
    status: 'IN PROGRESS',
    difficulty: 'Advanced',
    dueDate: 'Nov 15, 2026',
    summary:
        'Build a network security inspection tool that parses TCP/IP packet headers, detects SYN-flood patterns, inspects payload signatures for SQL Injection / XSS, and triggers automated firewall rule blocks.',
    tags: ['Node.js / Python', 'Wireshark / PCAP', 'Express API', 'Recharts'],
    systemArchitecture:
        'Raw packet capture interfaces via Scapy/pcap. Packet inspection pipeline decodes layer 3/4 headers in real-time. Heuristic sliding window registers anomaly spikes (>500 SYN packets/sec) and dynamically appends IPTables drop rules.',
    deliverables: [
      ProjectDeliverable(title: 'Packet Parser & Header Analyzer', isCompleted: true),
      ProjectDeliverable(title: 'SYN-Flood Anomaly Detector', isCompleted: true),
      ProjectDeliverable(title: 'Threat Detection Dashboard', isCompleted: false),
    ],
    techStack: ['Python Scapy', 'Express API', 'Recharts', 'IPTables', 'Linux'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Raw PCAP Sniffing & Layer 4 Decoding',
        description: 'Capture raw Ethernet frames and decode TCP flags (SYN, ACK, FIN) using non-blocking socket listeners.',
        codeHint: '''from scapy.all import sniff, TCP
def packet_callback(packet):
    if packet.haslayer(TCP) and packet[TCP].flags == 'S':
        log_syn_request(packet[IP].src)
sniff(prn=packet_callback, filter="tcp", store=0)''',
        tip: 'Set `store=0` in Scapy to avoid buffer memory overflow during packet continuous captures.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Network packet drop under high throughput (>1 Gbps)',
        rootCause: 'Single-threaded Python packet loop blocking kernel network buffer.',
        resolution: 'Use C-native libpcap bindings with multiprocessing workers processing packet queues.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Packet Inspection Accuracy', description: 'Zero false negatives on SQLi/XSS attack signature vectors.', points: 50),
      RubricItem(title: 'Real-time Analytics Dashboard', description: 'Live packet rate charts rendered smoothly with <50ms delay.', points: 50),
    ],
    initialCode: '''# Project: Cyber Threat Detection Engine
print("🛡️ [FIREWALL] Packet Sniffer Monitoring TCP Port 80/443...")
''',
  ),

  // 5. IT - Multi-Region Cloud Infra
  EngineeringProject(
    id: 'proj_it_2',
    title: 'Multi-Region Cloud Infrastructure with Terraform & AWS VPC',
    branchCode: 'IT',
    branchName: 'IT • INFORMATION TECHNOLOGY',
    status: 'UNASSIGNED',
    difficulty: 'Intermediate',
    dueDate: 'Nov 18, 2026',
    summary:
        'Write Infrastructure-as-Code (IaC) Terraform templates to provision a highly-available AWS/Cloud setup across 2 availability zones with public/private subnets, NAT Gateways, and ALB load balancing.',
    tags: ['Terraform', 'AWS / GCP', 'Docker', 'Nginx'],
    systemArchitecture:
        'Terraform provisions VPC with public subnets hosting Application Load Balancers and private subnets hosting Auto Scaling Group EC2 worker nodes. DB replicas run in isolated private database subnets.',
    deliverables: [
      ProjectDeliverable(title: 'Terraform VPC Module Config', isCompleted: false),
      ProjectDeliverable(title: 'Auto-Scaling Group Policy', isCompleted: false),
    ],
    techStack: ['Terraform', 'AWS VPC', 'CloudWatch', 'Nginx', 'Docker'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Modular VPC Provisioning',
        description: 'Define CIDR block 10.0.0.0/16 and split across 2 public subnets and 2 private subnets across us-east-1a and us-east-1b.',
        codeHint: '''resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}''',
        tip: 'Always declare tags to audit AWS billing resources.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Private instances cannot pull Docker images from Internet',
        rootCause: 'Missing NAT Gateway in public subnet or incorrect route table association.',
        resolution: 'Add route 0.0.0.0/0 targeting NAT Gateway in private subnet route tables.',
      )
    ],
    rubrics: [
      RubricItem(title: 'IaC Security & Zero Public S3 Buckets', description: '100% compliance with CIS AWS Foundations Benchmarks.', points: 100),
    ],
    initialCode: '''# Project: Multi-Region Cloud Infrastructure
print("☁️ [TERRAFORM] Terraform plan initialized.")
''',
  ),

  // 6. ECE - Smart IoT Environmental Sensing
  EngineeringProject(
    id: 'proj_ece_1',
    title: 'Smart IoT Environmental Sensing Node with ESP32 & MQTT',
    branchCode: 'ECE',
    branchName: 'ECE • ELECTRONICS & COMMUNICATION ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Intermediate',
    dueDate: 'Nov 20, 2026',
    summary:
        'Design an embedded sensing node using ESP32, reading temperature/humidity (DHT22) and air quality (MQ135) over I2C/SPI, publishing telemetry via MQTT to a cloud dashboard.',
    tags: ['ESP32', 'C++ / FreeRTOS', 'MQTT /Mosquitto', 'I2C / SPI Protocols'],
    systemArchitecture:
        'ESP32 microcontroller uses FreeRTOS dual-core tasks: Core 0 handles sensor ADC sampling over I2C every 2s, Core 1 manages TLS-encrypted MQTT publishing to Mosquitto broker.',
    deliverables: [
      ProjectDeliverable(title: 'ESP32 FreeRTOS Firmware Source', isCompleted: true),
      ProjectDeliverable(title: 'Mosquitto MQTT Cloud Broker Setup', isCompleted: true),
      ProjectDeliverable(title: 'Dashboard Realtime Sensor Charts', isCompleted: false),
    ],
    techStack: ['ESP32', 'C++ / FreeRTOS', 'MQTT', 'Mosquitto', 'Node-RED'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'FreeRTOS Multi-Core Task Scheduling',
        description: 'Pin sensor reading task to Core 0 and WiFi/MQTT task to Core 1 using `xTaskCreatePinnedToCore`.',
        codeHint: '''xTaskCreatePinnedToCore(
  sensorTask, "SensorTask", 4096, NULL, 1, &Task1, 0
);''',
        tip: 'Separating WiFi stack tasks prevents ADC sampling timing jitter.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: ESP32 Brownout Detector trigger crash on WiFi transmit',
        rootCause: 'Peak WiFi transmit currents exceed USB power supply current limits.',
        resolution: 'Add a 470uF electrolytic capacitor across 3.3V and GND power rails.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Hardware Interfacing & FreeRTOS Efficiency', description: 'Zero dropped sensor packets over 1-hour burn-in run.', points: 50),
      RubricItem(title: 'MQTT Payload Telemetry', description: 'Valid JSON payload parsing on Mosquitto cloud endpoint.', points: 50),
    ],
    initialCode: '''# Project: Smart IoT Environmental Sensing Node
print("📡 [ESP32] FreeRTOS Core 0 & Core 1 initialized.")
''',
  ),

  // 7. ECE - 8-Bit RISC Microprocessor
  EngineeringProject(
    id: 'proj_ece_2',
    title: '8-Bit RISC Microprocessor CPU Core in Verilog HDL',
    branchCode: 'ECE',
    branchName: 'ECE • ELECTRONICS & COMMUNICATION ENGINEERING',
    status: 'NEEDS REVISION',
    difficulty: 'Advanced',
    dueDate: 'Nov 22, 2026',
    summary:
        'Design and simulate an 8-bit RISC CPU core in Verilog HDL featuring a 4-stage pipeline (Fetch, Decode, Execute, Writeback), 8 general-purpose registers, ALU, and control unit.',
    tags: ['Verilog HDL', 'Icarus Verilog', 'GTKWave', 'FPGA / Quartus'],
    systemArchitecture:
        '4-stage pipeline executes instructions in single-cycle throughput when hazards are absent. Hazard Detection Unit inserts NOP stalls on RAW (Read-After-Write) data dependencies.',
    deliverables: [
      ProjectDeliverable(title: 'Verilog ALU & Register File Modules', isCompleted: true),
      ProjectDeliverable(title: 'Hazard Detection Unit & Stall Logic', isCompleted: false),
    ],
    techStack: ['Verilog HDL', 'Icarus Verilog', 'GTKWave', 'Quartus Prime'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'ALU Arithmetic & Logic Design',
        description: 'Implement 8-bit operations (ADD, SUB, AND, OR, XOR, SHL, SHR) with zero and carry flag registers.',
        codeHint: '''module alu(input [7:0] a, b, input [2:0] opcode, output reg [7:0] out, output zero);
  always @(*) begin
    case(opcode)
      3'b000: out = a + b;
      3'b001: out = a - b;
    endcase
  end
endmodule''',
        tip: 'Synthesize non-blocking assignments `<=` inside sequential edge-triggered blocks.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Pipeline data hazard causes invalid register read in Writeback phase',
        rootCause: 'Data forwarding unit absent between Execute and Decode stages.',
        resolution: 'Implement hazard forwarding multiplexer passing result directly to ALU input stage.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Verilog Simulation Waveforms', description: 'Clean GTKWave timing diagrams confirming 0 timing violations.', points: 100),
    ],
    initialCode: '''# Project: 8-Bit RISC Microprocessor CPU Core
print("⚡ [ICARUS VERILOG] Compiling CPU testbench...")
''',
  ),

  // 8. EEE - Smart Grid Solar Inverter
  EngineeringProject(
    id: 'proj_eee_1',
    title: 'Smart Grid 3-Phase Solar Inverter & MPPT Controller',
    branchCode: 'EEE',
    branchName: 'EEE • ELECTRICAL & ELECTRONICS ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Advanced',
    dueDate: 'Nov 18, 2026',
    summary:
        'Develop a digital control simulation for a 3-phase grid-tied solar inverter using Perturb & Observe (P&O) Maximum Power Point Tracking (MPPT) algorithm and Sinusoidal PWM (SPWM).',
    tags: ['MATLAB / Simulink', 'C++ Controller Code', 'Python Numerical Solvers', 'React Dashboard'],
    systemArchitecture:
        'Boost converter regulates solar PV array voltage via P&O algorithm. 3-phase inverter bridges SPWM signals at 20kHz, passing through LCL output filters into 415V 50Hz grid network.',
    deliverables: [
      ProjectDeliverable(title: 'PV Array & Boost Converter Model', isCompleted: true),
      ProjectDeliverable(title: 'P&O MPPT C++ Logic Block', isCompleted: true),
    ],
    techStack: ['MATLAB / Simulink', 'C++', 'Python', 'SPWM Generators'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'P&O MPPT Algorithm State Logic',
        description: 'Sample PV panel Voltage (V) and Current (I). Calculate Power delta and adjust PWM duty cycle.',
        codeHint: '''float deltaP = P_current - P_previous;
float deltaV = V_current - V_previous;
if (deltaP > 0) {
    duty_cycle += (deltaV > 0) ? step : -step;
}''',
        tip: 'Small duty cycle step sizes reduce power oscillation at steady state max power point.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Grid current THD exceeds IEEE 519 limit (>5%)',
        rootCause: 'Inverter output LCL filter cut-off frequency placed too close to grid frequency.',
        resolution: 'Recalculate LCL resonance frequency to sit between 10x grid frequency and 0.5x PWM switching frequency.',
      )
    ],
    rubrics: [
      RubricItem(title: 'MPPT Tracking Efficiency', description: 'Maintains >98.5% tracking under dynamic irradiance steps.', points: 50),
      RubricItem(title: 'Grid Power Quality THD', description: 'Total Harmonic Distortion remains < 3.2%.', points: 50),
    ],
    initialCode: '''# Project: Smart Grid 3-Phase Solar Inverter
print("☀️ [SOLAR] Simulink grid tie model running...")
''',
  ),

  // 9. EEE - Closed-Loop PID Motor Drive
  EngineeringProject(
    id: 'proj_eee_2',
    title: 'Closed-Loop Digital PID Motor Drive Simulator',
    branchCode: 'EEE',
    branchName: 'EEE • ELECTRICAL & ELECTRONICS ENGINEERING',
    status: 'UNASSIGNED',
    difficulty: 'Intermediate',
    dueDate: 'Nov 25, 2026',
    summary:
        'Build a real-time digital closed-loop PID speed controller for an Induction Motor Drive with Field Oriented Control (FOC) vector transformations (Clarke & Park transforms).',
    tags: ['C++ / Python', 'DSP Microcontroller', 'Recharts Visualizer', 'Tailwind CSS'],
    systemArchitecture:
        '3-phase stator currents parsed into stationary frame (Clarke) and rotating d-q reference frame (Park). Dual PID controllers regulate direct flux current and quadrature torque current.',
    deliverables: [
      ProjectDeliverable(title: 'Clarke & Park Math Transformation Engine', isCompleted: false),
    ],
    techStack: ['C++', 'DSP', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Clarke Vector Transformation',
        description: 'Transform 3-phase currents (Ia, Ib, Ic) into 2-phase stationary currents (I_alpha, I_beta).',
        codeHint: '''float I_alpha = Ia;
float I_beta = (Ia + 2 * Ib) / sqrt(3.0);''',
        tip: 'Assume balanced 3-phase currents where Ia + Ib + Ic = 0.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Motor speed overshoot exceeds setpoint by >25%',
        rootCause: 'Integrator windup in speed PID loop during acceleration phase.',
        resolution: 'Implement anti-windup clamping on integral sum term when output saturates.',
      )
    ],
    rubrics: [
      RubricItem(title: 'FOC Mathematical Precision', description: 'Accurate transformation metrics verified against standard MATLAB models.', points: 100),
    ],
    initialCode: '''# Project: Closed-Loop Digital PID Motor Drive
print("⚙️ [FOC DRIVE] Motor drive control loop online.")
''',
  ),

  // 10. ME - Automotive Control Arm 3D CAD
  EngineeringProject(
    id: 'proj_me_1',
    title: 'Automotive Control Arm 3D CAD & FEA Stress Heatmap',
    branchCode: 'ME',
    branchName: 'ME • MECHANICAL ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Intermediate',
    dueDate: 'Nov 14, 2026',
    summary:
        'Design a lightweight aluminum suspension control arm in 3D CAD, perform finite element mesh generation, and compute Von Mises stress distributions under 15kN bump load.',
    tags: ['SolidWorks / Inventor', 'ANSYS / FEA Solver', 'Python Matrix Solver', 'Three.js 3D Viewer'],
    systemArchitecture:
        'CAD geometry exported as STEP model. Tetrahedral mesh created with 0.5mm refinement at fillet stress risers. Boundary conditions fix chassis bushing mounts while applying 15kN force at ball joint.',
    deliverables: [
      ProjectDeliverable(title: '3D STEP CAD Model Geometry', isCompleted: true),
      ProjectDeliverable(title: 'ANSYS FEA Static Stress Report', isCompleted: true),
    ],
    techStack: ['SolidWorks', 'ANSYS', 'Python', 'Three.js'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Finite Element Mesh Convergence',
        description: 'Refine mesh density until von Mises stress delta changes by less than 2% between consecutive iterations.',
        codeHint: '''# Python FEA Mesh Convergence Verification
delta_stress = abs(stress_pass2 - stress_pass1) / stress_pass1
assert delta_stress < 0.02, "Mesh not converged!"''',
        tip: 'Focus mesh refinement on internal corners and mounting holes.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Singular stress point explosion at fixed boundary constraint',
        rootCause: 'Applying point loads directly to constrained nodes in FEA solver.',
        resolution: 'Distribute 15kN force over realistic surface contact area of ball joint hole.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Factor of Safety Compliance', description: 'Safety factor > 1.8 under max peak load.', points: 100),
    ],
    initialCode: '''# Project: Automotive Control Arm 3D CAD & FEA
print("🏎️ [FEA] Computing von Mises stress fields...")
''",
  ),

  // 11. ME - 6-DOF Industrial Robotic Arm
  EngineeringProject(
    id: 'proj_me_2',
    title: '6-DOF Industrial Robotic Arm Kinematics & Servo Controller',
    branchCode: 'ME',
    branchName: 'ME • MECHANICAL ENGINEERING',
    status: 'UNASSIGNED',
    difficulty: 'Advanced',
    dueDate: 'Nov 24, 2026',
    summary:
        'Formulate Denavit-Hartenberg (D-H) parameters for a 6-axis articulated robot arm. Derive forward and inverse kinematics equations to compute end-effector position trajectories.',
    tags: ['Python / C++', 'ROS 2 / MoveIt', 'Three.js 3D Canvas', 'Tailwind CSS'],
    systemArchitecture:
        'D-H transformation matrices multiplied sequentially to determine end-effector pose (X,Y,Z, Roll, Pitch, Yaw). Analytical Jacobian matrix calculates required joint velocities.',
    deliverables: [
      ProjectDeliverable(title: 'D-H Parameter Kinematic Model', isCompleted: false),
    ],
    techStack: ['Python', 'ROS 2', 'Three.js', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'D-H Matrix Chain Multiplication',
        description: 'Compute 4x4 homogeneous transformation matrix T0_6 = A1 * A2 * A3 * A4 * A5 * A6.',
        codeHint: '''import numpy as np
def dh_matrix(a, alpha, d, theta):
    return np.array([
        [np.cos(theta), -np.sin(theta)*np.cos(alpha), np.sin(theta)*np.sin(alpha), a*np.cos(theta)],
        [np.sin(theta), np.cos(theta)*np.cos(alpha), -np.cos(theta)*np.sin(alpha), a*np.sin(theta)],
        [0, np.sin(alpha), np.cos(alpha), d],
        [0, 0, 0, 1]
    ])''',
        tip: 'Maintain angle units consistently in radians.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Kinematic singularity causes joint speed explosion',
        rootCause: 'Robot arm reaches wrist alignment singularity where Jacobian determinant equals zero.',
        resolution: 'Implement damped least-squares (Levenberg-Marquardt) inverse kinematics solver.',
      )
    ],
    rubrics: [
      RubricItem(title: 'End-Effector Trajectory Precision', description: 'Position error < 0.5mm along linear path.', points: 100),
    ],
    initialCode: '''# Project: 6-DOF Industrial Robotic Arm Kinematics
print("🤖 [ROBOTICS] Joint transformation chains computed.")
''',
  ),

  // 12. CE - High-Rise Reinforced Concrete Frame
  EngineeringProject(
    id: 'proj_ce_1',
    title: 'High-Rise Reinforced Concrete Frame & Seismic Shear Wall',
    branchCode: 'CE',
    branchName: 'CE • CIVIL ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Advanced',
    dueDate: 'Nov 16, 2026',
    summary:
        'Model a 15-story reinforced concrete building frame under lateral wind and earthquake loads using ETABS / STAAD.Pro principles, analyzing rebar areas and storey drift limits.',
    tags: ['STAAD.Pro / ETABS', 'Python Matrix Structural Solver', 'Recharts', 'Tailwind CSS'],
    systemArchitecture:
        '3D space frame model subject to Dead, Live, Wind (IS 875 Part 3), and Seismic (IS 1893) load combinations. Response spectrum analysis determines base shear distribution.',
    deliverables: [
      ProjectDeliverable(title: '3D Space Frame Load Model', isCompleted: true),
      ProjectDeliverable(title: 'Seismic Shear Wall Rebar Calculation Sheet', isCompleted: true),
    ],
    techStack: ['ETABS', 'STAAD.Pro', 'Python', 'Recharts'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Seismic Base Shear Calculation (IS 1893)',
        description: 'Calculate design seismic base shear Vb = Ah * W, where Ah is zone factor, importance factor, and response reduction factor.',
        codeHint: '''Ah = (Z / 2) * (I / R) * (Sa / g)
Vb = Ah * Total_Building_Weight''',
        tip: 'Check soil type classification to obtain correct Sa/g acceleration ratio.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Storey drift exceeds IS 1893 allowable limit (H/250)',
        rootCause: 'Insufficient lateral stiffness in building perimeter frames.',
        resolution: 'Add shear walls or increase beam/column cross-sectional dimensions at lower floors.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Structural Safety & Drift Compliance', description: 'Storey drift stays strictly below allowable IS code thresholds.', points: 100),
    ],
    initialCode: '''# Project: High-Rise Concrete Frame Analysis
print("🏢 [ETABS] Calculating seismic base shear...")
''',
  ),

  // 13. CE - Traffic Flow Intersection
  EngineeringProject(
    id: 'proj_ce_2',
    title: 'Traffic Flow Intersection Density & Highway Pavement Design',
    branchCode: 'CE',
    branchName: 'CE • CIVIL ENGINEERING',
    status: 'UNASSIGNED',
    difficulty: 'Intermediate',
    dueDate: 'Nov 26, 2026',
    summary:
        'Simulate urban traffic signal timing and design flexible asphalt pavement thickness layers based on California Bearing Ratio (CBR) and Equivalent Single Axle Loads (ESAL).',
    tags: ['Python Traffic Simulator', 'CBR Pavement Solver', 'Recharts', 'Tailwind CSS'],
    systemArchitecture:
        'Webster method determines optimal signal cycle times. IRC:37 flexible pavement design chart calculates subbase, base, and bituminous surface layer thicknesses based on cumulative MSA traffic.',
    deliverables: [
      ProjectDeliverable(title: 'Webster Signal Timing Simulator', isCompleted: false),
    ],
    techStack: ['Python', 'IRC:37 Solver', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Webster Optimum Cycle Time Formula',
        description: 'Calculate optimal signal cycle time C0 = (1.5*L + 5) / (1 - Y).',
        codeHint: '''L = total_lost_time_per_cycle
Y = sum_of_max_volume_ratios
C0 = (1.5 * L + 5) / (1.0 - Y)''',
        tip: 'Ensure sum of volume ratios Y does not exceed 0.90 to prevent gridlock saturation.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Pavement rutting failure predicted before 15-year design life',
        rootCause: 'Subgrade CBR value overestimated during initial soil survey testing.',
        resolution: 'Increase granular subbase thickness or introduce geotextile stabilization layer.',
      )
    ],
    rubrics: [
      RubricItem(title: 'IRC Code Compliance', description: 'Pavement layer structural design satisfies IRC 37 standards.', points: 100),
    ],
    initialCode: '''# Project: Traffic Flow Intersection Density
print("🚦 [TRAFFIC] Signal timing optimization running...")
''',
  ),

  // 14. CH - Catalytic CSTR & Plug Flow Reactor
  EngineeringProject(
    id: 'proj_ch_1',
    title: 'Catalytic CSTR & Plug Flow Reactor (PFR) Yield Simulator',
    branchCode: 'CH',
    branchName: 'CH • CHEMICAL ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Intermediate',
    dueDate: 'Nov 17, 2026',
    summary:
        'Build an interactive reactor design simulator comparing Continuous Stirred Tank Reactors (CSTR) and Plug Flow Reactors (PFR) for first-order exothermic catalytic liquid-phase reactions.',
    tags: ['Python NumPy / SciPy', 'TypeScript RK4 Solver', 'Recharts', 'Tailwind CSS'],
    systemArchitecture:
        'Runge-Kutta 4th order (RK4) ODE solver integrates mass and energy balance equations along reactor length. Non-isothermal heat generation and cooling jacket heat removal calculated simultaneously.',
    deliverables: [
      ProjectDeliverable(title: 'RK4 Differential Equation Solver', isCompleted: true),
      ProjectDeliverable(title: 'CSTR vs PFR Conversion Comparison Chart', isCompleted: true),
    ],
    techStack: ['Python SciPy', 'TypeScript RK4', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'PFR Differential Mass Balance ODE',
        description: 'Express reactant conversion dX/dV = -rA / FA0, where rate constant k follows Arrhenius temperature dependence.',
        codeHint: '''k = k0 * np.exp(-Ea / (R * T))
rA = -k * Ca0 * (1 - X)
dX_dV = -rA / FA0''',
        tip: 'Account for temperature changes in rate constant k inside non-isothermal reactors.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Exothermic reactor temperature runaway in simulation',
        rootCause: 'Cooling jacket heat removal area is insufficient for reaction enthalpy.',
        resolution: 'Increase cooling fluid flow rate or increase heat exchanger surface area UA.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Numerical RK4 Solver Stability', description: 'Mass balance holds to 99.99% accuracy across conversion integration step.', points: 100),
    ],
    initialCode: '''# Project: Catalytic CSTR & Plug Flow Reactor Yield Simulator
print("🧪 [CHEMICAL] Solving Arrhenius non-isothermal ODEs...")
''',
  ),

  // 15. CH - Distillation Column Separation
  EngineeringProject(
    id: 'proj_ch_2',
    title: 'Distillation Column Separation & McCabe-Thiele Calculator',
    branchCode: 'CH',
    branchName: 'CH • CHEMICAL ENGINEERING',
    status: 'UNASSIGNED',
    difficulty: 'Advanced',
    dueDate: 'Nov 27, 2026',
    summary:
        'Develop a graphical McCabe-Thiele solver for binary mixture distillation columns (e.g., Ethanol-Water), computing minimum reflux ratio, total equilibrium stages, and optimum feed tray location.',
    tags: ['TypeScript / Python', 'VLE Equation Engine', 'Recharts Step Visualizer', 'Tailwind CSS'],
    systemArchitecture:
        'Vapor-Liquid Equilibrium (VLE) data interpolated using Antoine equation. Rectifying and stripping operating lines constructed based on reflux ratio R and feed quality q-line.',
    deliverables: [
      ProjectDeliverable(title: 'VLE Curve & Antoine Equation Engine', isCompleted: false),
    ],
    techStack: ['TypeScript', 'Python', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'q-Line Equation Construction',
        description: 'Slope of q-line = q / (q - 1). Intersection with x-y equilibrium line determines minimum reflux Rmin.',
        codeHint: '''q_slope = q / (q - 1.0)
y_intersect = q_slope * x - xf / (q - 1.0)''',
        tip: 'q = 1 for saturated liquid feed, q = 0 for saturated vapor feed.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Infinite theoretical stages calculated near azeotrope point',
        rootCause: 'Operating line intersects equilibrium curve at azeotropic pinch point.',
        resolution: 'Cap stage calculation loop and display warning if distillation composition exceeds azeotrope limit.',
      )
    ],
    rubrics: [
      RubricItem(title: 'McCabe-Thiele Stage Construction Precision', description: 'Stage stepping matches standard Perry Chemical Engineers Handbook tables.', points: 100),
    ],
    initialCode: '''# Project: Distillation Column Separation Calculator
print("⚗️ [DISTILLATION] McCabe-Thiele stage solver online.")
''',
  ),

  // 16. AE - Supersonic Airfoil Compressible Flow
  EngineeringProject(
    id: 'proj_ae_1',
    title: 'Supersonic Airfoil Compressible Flow & Shockwave Solver',
    branchCode: 'AE',
    branchName: 'AE • AEROSPACE ENGINEERING',
    status: 'IN PROGRESS',
    difficulty: 'Advanced',
    dueDate: 'Nov 19, 2026',
    summary:
        'Develop a numerical solver for 2D supersonic compressible airflow over diamond/wedge airfoils at Mach 1.5 - 3.0, computing Oblique Shockwave angles, Expansion Waves (Prandtl-Meyer), and Wave Drag Coefficient ($C_d$).',
    tags: ['C++ / Python', 'Compressible Flow Solver', 'Recharts Shock Plotter', 'Tailwind CSS'],
    systemArchitecture:
        'Theta-Beta-Mach equation solved iteratively via Newton-Raphson for Oblique Shock angle Beta. Prandtl-Meyer expansion fan equations applied at expansion corners to evaluate surface pressure distribution.',
    deliverables: [
      ProjectDeliverable(title: 'Oblique Shock Theta-Beta-Mach Solver', isCompleted: true),
      ProjectDeliverable(title: 'Prandtl-Meyer Expansion Fan Calculator', isCompleted: true),
    ],
    techStack: ['C++', 'Python', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Oblique Shockwave Newton-Raphson Solver',
        description: 'Solve tan(theta) = 2*cot(beta)*(M1^2 * sin^2(beta) - 1) / (M1^2 * (gamma + cos(2*beta)) + 2).',
        codeHint: '''def shock_relation(beta, M1, theta, gamma=1.4):
    num = 2 * (M1**2 * np.sin(beta)**2 - 1) / np.tan(beta)
    den = M1**2 * (gamma + np.cos(2*beta)) + 2
    return np.arctan(num / den) - theta''',
        tip: 'Choose weak shock solution branch for standard unattached external aerodynamic flows.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Oblique shock solver fails at high angle of attack (Mach detachment)',
        rootCause: 'Deflection angle Theta exceeds maximum allowable shock angle Theta_max.',
        resolution: 'Detect shock detachment and switch calculation model to Bow Shock detachment distance equations.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Compressible Pressure & Drag Coefficient Accuracy', description: 'Wave drag Cd matches NACA supersonic test data within 1.5%.', points: 100),
    ],
    initialCode: '''# Project: Supersonic Airfoil Compressible Flow Solver
print("🚀 [AEROSPACE] Supersonic shockwave relations running at Mach 2.2...")
''',
  ),

  // 17. AE - Turbofan Jet Engine Thrust
  EngineeringProject(
    id: 'proj_ae_2',
    title: 'Turbofan Jet Engine Thrust & Specific Impulse Cycle Simulator',
    branchCode: 'AE',
    branchName: 'AE • AEROSPACE ENGINEERING',
    status: 'UNASSIGNED',
    difficulty: 'Intermediate',
    dueDate: 'Nov 29, 2026',
    summary:
        'Simulate thermodynamic cycle performance (Brayton cycle with bypass) for high-bypass turbofan engines across altitudes (0 - 40,000 ft) and Mach numbers (0 - 0.85).',
    tags: ['Python / TypeScript', 'Thermodynamic Engine Solver', 'Recharts', 'Tailwind CSS'],
    systemArchitecture:
        'Isentropic compressor/turbine component efficiencies calculate total station temperatures and pressures. Energy balance determines turbine exit temperature driving fan and core nozzles.',
    deliverables: [
      ProjectDeliverable(title: 'Brayton Gas Turbine Cycle Station Solver', isCompleted: false),
    ],
    techStack: ['Python', 'TypeScript', 'Recharts', 'Tailwind CSS'],
    roadmap: [
      RoadmapStep(
        stepNumber: '1',
        title: 'Compressor Work & Temperature Ratio',
        description: 'Calculate T3 = T2 * (1 + (pi_c^((gamma-1)/gamma) - 1) / eta_c).',
        codeHint: '''T3 = T2 * (1 + (pressure_ratio**((gamma-1)/gamma) - 1) / isentropic_eff)''',
        tip: 'Vary specific heat ratio gamma if temperature exceeds 1000K in combustor.',
      )
    ],
    debugIssues: [
      DebugIssue(
        title: 'Issue: Turbine work output insufficient to drive high bypass fan',
        rootCause: 'Bypass ratio set too high for turbine entry temperature Limit.',
        resolution: 'Increase combustor exit temperature T4 or reduce bypass ratio alpha.',
      )
    ],
    rubrics: [
      RubricItem(title: 'Specific Fuel Consumption (TSFC) Precision', description: 'Thrust and fuel burn rates accurately modeled across altitude envelope.', points: 100),
    ],
    initialCode: '''# Project: Turbofan Jet Engine Cycle Simulator
print("✈️ [PROPULSION] Brayton thermodynamic cycle solver initialized.")
''',
  ),
];