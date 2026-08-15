import '../models/course_model.dart';

final Map<String, List<Map<String, String>>>
    branchCourseSuggestions = {

  // ==========================================================
  // CSE
  // ==========================================================

  'B.Tech - Computer Science & Eng. (CSE)': [
    {
      'title':
          'Modern Web Development with React 18 & Vite',
      'tags':
          'JSX • Vite • React 18',
      'type':
          'computer',
    },
    {
      'title':
          'Python for Data Science, Machine Learning & AI',
      'tags':
          'PyTorch • Pandas • LLMs',
      'type':
          'computer',
    },
    {
      'title':
          'Enterprise Java 21, Spring Boot & Docker',
      'tags':
          'Java 21 • Spring Boot • Docker',
      'type':
          'computer',
    },
    {
      'title':
          'Low-Level C++ Systems & Memory Management',
      'tags':
          'C++ • Memory • Systems',
      'type':
          'computer',
    },
    {
      'title':
          'Cross-Platform Mobile Apps with Flutter & Dart',
      'tags':
          'Flutter • Dart • Mobile',
      'type':
          'computer',
    },
    {
      'title':
          'High-Performance Backend APIs with Go & Node',
      'tags':
          'Go • Node • REST • gRPC',
      'type':
          'computer',
    },
  ],

  // ==========================================================
  // IT
  // ==========================================================

  'B.Tech - Information Technology (IT)': [
    {
      'title':
          'Cyber Security, Ethical Hacking & Cryptography',
      'tags':
          'Ethical Hacking • Networks • Cryptography',
      'type':
          'information',
    },
    {
      'title':
          'Database Systems & Distributed Query Architecture',
      'tags':
          'SQL • B-Trees • Distributed Databases',
      'type':
          'information',
    },
    {
      'title':
          'Cloud Solutions Architecting with AWS & Kubernetes',
      'tags':
          'AWS • Kubernetes • CI/CD',
      'type':
          'information',
    },
    {
      'title':
          'Full-Stack Web Architecture & DevOps',
      'tags':
          'React • Express • DevOps',
      'type':
          'information',
    },
    {
      'title':
          'Cross-Platform Mobile Apps with Flutter',
      'tags':
          'Flutter • REST • State Management',
      'type':
          'information',
    },
    {
      'title':
          'Computer Networks & Wireshark Packet Auditing',
      'tags':
          'TCP/IP • Routing • Wireshark',
      'type':
          'information',
    },
  ],

  // ==========================================================
  // ECE
  // ==========================================================

  'B.Tech - Electronics & Comm. (ECE)': [
    {
      'title':
          'Embedded Systems & IoT Sensor Networks',
      'tags':
          'ESP32 • STM32 • IoT • Sensors',
      'type':
          'electronics',
    },
    {
      'title':
          'VLSI Design, CMOS & Verilog HDL Simulation',
      'tags':
          'Verilog • CMOS • RTL',
      'type':
          'electronics',
    },
    {
      'title':
          'Digital Signal Processing & Filter Design',
      'tags':
          'FFT • FIR/IIR • Signals',
      'type':
          'electronics',
    },
    {
      'title':
          'Embedded Systems C++ Programming',
      'tags':
          'C++ • Embedded • Hardware',
      'type':
          'electronics',
    },
    {
      'title':
          '5G & Wireless Communication Systems',
      'tags':
          '5G • OFDM • Wireless',
      'type':
          'electronics',
    },
    {
      'title':
          'Real-Time Operating Systems (FreeRTOS)',
      'tags':
          'RTOS • Tasks • Scheduling',
      'type':
          'electronics',
    },
  ],

  // ==========================================================
  // EEE
  // ==========================================================

  'B.Tech - Electrical Engineering (EE)': [
    {
      'title':
          'Power Electronics & Smart Grid Systems',
      'tags':
          'Power Electronics • Smart Grid • SCADA',
      'type':
          'electrical',
    },
    {
      'title':
          'Control Systems Engineering & PID Tuning',
      'tags':
          'Control • PID • Feedback',
      'type':
          'electrical',
    },
    {
      'title':
          'Electrical Machines & Induction Motor Drives',
      'tags':
          'AC/DC • Motors • VFD',
      'type':
          'electrical',
    },
    {
      'title':
          'Renewable Energy Microgrids & SCADA Control',
      'tags':
          'Solar • Wind • Battery • SCADA',
      'type':
          'electrical',
    },
    {
      'title':
          'C++ for Electrical Circuit Numerical Solvers',
      'tags':
          'C++ • Numerical Methods',
      'type':
          'electrical',
    },
    {
      'title':
          'Analog Circuit Design & SPICE Simulation',
      'tags':
          'Op-Amps • Filters • LTSpice',
      'type':
          'electrical',
    },
  ],

  // ==========================================================
  // ME
  // ==========================================================

  'B.Tech - Mechanical Engineering (ME)': [
    {
      'title':
          '3D CAD Modelling & FEA Structural Stress Analysis',
      'tags':
          'SolidWorks • CAD • FEA',
      'type':
          'mechanical',
    },
    {
      'title':
          'Thermodynamics & Heat Transfer Operations',
      'tags':
          'Thermodynamics • Heat Transfer',
      'type':
          'mechanical',
    },
    {
      'title':
          'Industrial Robotics, Kinematics & Automation',
      'tags':
          'Robotics • Kinematics • PLC',
      'type':
          'mechanical',
    },
    {
      'title':
          'Computational Fluid Dynamics (CFD) Simulation',
      'tags':
          'ANSYS • CFD • Fluid Dynamics',
      'type':
          'mechanical',
    },
    {
      'title':
          'Mechatronics & Actuator Control Systems',
      'tags':
          'Sensors • Motors • Controllers',
      'type':
          'mechanical',
    },
    {
      'title':
          'Python for Mechanical Engineering Computations',
      'tags':
          'Python • Numerical Methods • Simulation',
      'type':
          'mechanical',
    },
  ],

  // ==========================================================
  // CE
  // ==========================================================

  'B.Tech - Civil Engineering (CE)': [
    {
      'title':
          'Structural Engineering & Reinforced Concrete Design',
      'tags':
          'RCC • Steel • Structural Analysis',
      'type':
          'civil',
    },
    {
      'title':
          'Geotechnical Engineering & Soil Mechanics',
      'tags':
          'Soil • Foundations • Bearing Capacity',
      'type':
          'civil',
    },
    {
      'title':
          'Transportation Engineering & Highway Design',
      'tags':
          'Traffic • Asphalt • Highway Design',
      'type':
          'civil',
    },
    {
      'title':
          'Building Information Modeling (BIM) & Autodesk Revit',
      'tags':
          'BIM • Revit • Architecture',
      'type':
          'civil',
    },
    {
      'title':
          'Environmental Engineering & Water Treatment',
      'tags':
          'Water • Treatment • Environment',
      'type':
          'civil',
    },
    {
      'title':
          'Surveying, GIS & Satellite Remote Sensing',
      'tags':
          'GIS • GPS • QGIS • Surveying',
      'type':
          'civil',
    },
  ],

  // ==========================================================
  // CH
  // ==========================================================

  'B.Tech - Chemical Engineering (CH)': [
    {
      'title':
          'Chemical Reaction Engineering & Kinetics',
      'tags':
          'Batch • CSTR • PFR • Kinetics',
      'type':
          'chemical',
    },
    {
      'title':
          'Heat & Mass Transfer Unit Operations',
      'tags':
          'Distillation • Heat Exchangers',
      'type':
          'chemical',
    },
    {
      'title':
          'Process Control & Chemical Instrumentation',
      'tags':
          'P&ID • Control • Instrumentation',
      'type':
          'chemical',
    },
    {
      'title':
          'Fluid Mechanics & Chemical Piping Systems',
      'tags':
          'Fluid Flow • Pumps • Piping',
      'type':
          'chemical',
    },
    {
      'title':
          'Chemical Engineering Thermodynamics',
      'tags':
          'VLE • Fugacity • Equilibrium',
      'type':
          'chemical',
    },
    {
      'title':
          'Python for Chemical Process Simulation',
      'tags':
          'Python • NumPy • SciPy',
      'type':
          'chemical',
    },
  ],

  // ==========================================================
  // AE
  // ==========================================================

  'B.Tech - Aerospace Engineering (AE)': [
    {
      'title':
          'Aerodynamics & Supersonic Flight Mechanics',
      'tags':
          'Airfoil • Mach • Wind Tunnel',
      'type':
          'aerospace',
    },
    {
      'title':
          'Aircraft Jet & Rocket Propulsion Systems',
      'tags':
          'Turbofan • Rockets • Propulsion',
      'type':
          'aerospace',
    },
    {
      'title':
          'Avionics & Autonomous Flight Control',
      'tags':
          'Avionics • INS • Autopilot',
      'type':
          'aerospace',
    },
    {
      'title':
          'Spacecraft Dynamics & Orbital Mechanics',
      'tags':
          'Orbit • Kepler • Spacecraft',
      'type':
          'aerospace',
    },
    {
      'title':
          'Aerospace Structural Analysis & Carbon Composites',
      'tags':
          'Structures • Carbon Fiber • Composites',
      'type':
          'aerospace',
    },
    {
      'title':
          'Python for Aerodynamic Computations',
      'tags':
          'Python • CFD • Aerodynamics',
      'type':
          'aerospace',
    },
  ],
};

List<Course> getCoursesFromSuggestions({
  String? selectedBranch,
}) {
  final List<Course> courses = [];

  int index = 0;

  branchCourseSuggestions.forEach(
    (branch, suggestionList) {
      if (selectedBranch == null ||
          selectedBranch == 'ALL' ||
          branch == selectedBranch) {
        for (final item
            in suggestionList) {
          index++;

          courses.add(
            Course.fromSuggestionMap(
              branch,
              item,
              'course_$index',
            ),
          );
        }
      }
    },
  );

  return courses;
}