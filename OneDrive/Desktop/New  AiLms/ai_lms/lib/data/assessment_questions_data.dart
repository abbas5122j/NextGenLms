class AssessmentQuestionData {
  static Map<String, dynamic> getQuestionsForCourse(String courseTitle) {
    final Map<String, Map<String, dynamic>> dataset = {
      // -----------------------------------------------------------------------
      // 1. CSE COURSES
      // -----------------------------------------------------------------------
      'Full-Stack Web Development': {
        'reasoning': [
          {
            'title': 'CSS Box Model & Flexbox Calculation',
            'question': 'A div has `width: 200px`, `padding: 20px`, `border: 5px solid black`, and `box-sizing: border-box`. What is the total rendered width of this element on the web page?',
            'options': ['200px', '250px', '225px', '150px'],
            'correct': '200px',
            'explanation': 'Because `box-sizing: border-box` includes padding (20px * 2) and border (5px * 2) inside the specified width, the total rendered width remains strictly 200px.'
          },
          {
            'title': 'Asynchronous Event Loop Queue Priority',
            'question': 'In JavaScript, if a `Promise.resolve().then()` (Microtask) and a `setTimeout(..., 0)` (Macrotask) are scheduled simultaneously, which executes first?',
            'options': ['Promise microtask executes first', 'setTimeout macrotask executes first', 'Executes randomly', 'Executes synchronously together'],
            'correct': 'Promise microtask executes first',
            'explanation': 'The JS Event Loop processes the entire Microtask Queue (Promises, MutationObserver) completely before pulling the next job from the Macrotask Queue (setTimeout).'
          },
          {
            'title': 'React State Immutability Reasoning',
            'question': 'Why should state in React never be mutated directly (e.g., `state.count = 5`) instead of using `setState` or `setCount`?',
            'options': [
              'Direct mutation bypasses re-rendering triggers and virtual DOM diffing',
              'JavaScript throws a syntax error',
              'It destroys local storage',
              'React automatically converts it anyway'
            ],
            'correct': 'Direct mutation bypasses re-rendering triggers and virtual DOM diffing',
            'explanation': 'React relies on shallow object reference comparison to detect state changes. Direct mutation mutates values in place without altering object references, preventing necessary re-renders.'
          },
        ],
        'coding': {
          'title': 'Find Target Sum Pairs',
          'problem': 'Implement a function `findSumPairs(arr, target)` that returns an array of integer pairs from `arr` whose sum equals `target`.',
          'sample': 'findSumPairs([2, 7, 11, 15], 9) ➔ [[2, 7]]',
          'initialCode': '''function findSumPairs(arr, target) {
  const pairs = [];
  const seen = new Set();

  for (let num of arr) {
    const complement = target - num;
    if (seen.has(complement)) {
      pairs.push([complement, num]);
    }
    seen.add(num);
  }
  return pairs;
}''',
        },
        'conceptual': 'How do you typically approach performance optimization, caching strategies, and asynchronous state management in modern web architectures?'
      },

      'Data Structures & Algorithms': {
        'reasoning': [
          {
            'title': 'Hash Table Collision Resolution',
            'question': 'When using Chaining for collision resolution in a Hash Table with N keys and M slots, what is the worst-case lookup time complexity?',
            'options': ['O(N)', 'O(1)', 'O(log N)', 'O(N log N)'],
            'correct': 'O(N)',
            'explanation': 'If all keys hash to the exact same slot, the hash table degrades into a single linked list of length N, resulting in an O(N) worst-case search time.'
          },
          {
            'title': 'Binary Search Tree Balancing Logic',
            'question': 'In an AVL Tree, what is the maximum permissible difference in height between the left and right subtrees of any node?',
            'options': ['1', '0', '2', 'Unbounded'],
            'correct': '1',
            'explanation': 'An AVL tree is a self-balancing binary search tree where the balance factor of every node (height(left) - height(right)) must strictly be -1, 0, or 1.'
          },
          {
            'title': 'Graph Traversal Space Complexity',
            'question': 'Which graph traversal algorithm uses a Queue data structure and has a worst-case space complexity of O(V) for storing vertices?',
            'options': ['Breadth-First Search (BFS)', 'Depth-First Search (DFS)', 'Dijkstra Algorithm', 'Kruskal Algorithm'],
            'correct': 'Breadth-First Search (BFS)',
            'explanation': 'BFS explores level-by-level using a FIFO Queue, requiring up to O(V) space to keep track of all visited and queued vertices.'
          },
        ],
        'coding': {
          'title': 'Reverse Linked List',
          'problem': 'Write an algorithm to reverse a singly linked list in O(N) time and O(1) auxiliary memory.',
          'sample': '1 ➔ 2 ➔ 3 ➔ 4 ➔ NULL  ===>  4 ➔ 3 ➔ 2 ➔ 1 ➔ NULL',
          'initialCode': '''function reverseLinkedList(head) {
  let prev = null;
  let current = head;
  while (current !== null) {
    let nextNode = current.next;
    current.next = prev;
    prev = current;
    current = nextNode;
  }
  return prev;
}''',
        },
        'conceptual': 'Explain how you evaluate time versus space trade-offs when deciding between Dynamic Programming and Greedy algorithmic approaches.'
      },

      'Cross-Platform Mobile Apps': {
        'reasoning': [
          {
            'title': 'Flutter Widget Tree Lifecycle',
            'question': 'In a Flutter StatefulWidget, which method is called exactly once when the widget is inserted into the element tree?',
            'options': ['initState()', 'build()', 'didUpdateWidget()', 'dispose()'],
            'correct': 'initState()',
            'explanation': '`initState()` is invoked exactly once per state object lifecycle when the widget is first created and mounted into the Framework tree.'
          },
          {
            'title': 'Dart Event Loop Architecture',
            'question': 'How does Dart execute asynchronous code like Futures and Streams single-threaded?',
            'options': ['Using an Event Loop with Microtask and Event Queues', 'By spawning OS threads automatically', 'Using multi-core native preemptive scheduling', 'Through synchronous blocking calls'],
            'correct': 'Using an Event Loop with Microtask and Event Queues',
            'explanation': 'Dart operates on a single-threaded isolate model driven by an event loop that continuously drains the Microtask Queue followed by the Event Queue.'
          },
          {
            'title': 'Flutter Keys & Element Reconciliation',
            'question': 'When dynamically reordering or swapping widgets of the same type within a ListView, what Flutter mechanism preserves state across rebuilds?',
            'options': ['Assigning unique Keys (e.g. ValueKey)', 'Using StatefulBuilder', 'Calling setState() inside build()', 'Using InheritedWidget'],
            'correct': 'Assigning unique Keys (e.g. ValueKey)',
            'explanation': 'Keys preserve state when widgets swap or reorder by helping the framework match new widget configurations to existing element trees.'
          },
        ],
        'coding': {
          'title': 'Dart Stream Data Filter',
          'problem': 'Write a Dart function `filterEvenNumbers(Stream<int> stream)` that listens to an integer stream and yields only even numbers.',
          'sample': 'Stream[1, 2, 3, 4, 5] ➔ Stream[2, 4]',
          'initialCode': '''Stream<int> filterEvenNumbers(Stream<int> stream) async* {
  await for (int value in stream) {
    if (value % 2 == 0) {
      yield value;
    }
  }
}''',
        },
        'conceptual': 'How do you handle state management, reactive stream subscriptions, and background task isolates in high-performance Flutter mobile apps?'
      },

      // -----------------------------------------------------------------------
      // 2. AIML COURSES
      // -----------------------------------------------------------------------
      'Applied Machine Learning': {
        'reasoning': [
          {
            'title': 'Bias-Variance Tradeoff Analysis',
            'question': 'A model achieves 99% accuracy on training data but only 58% accuracy on test data. Which issue does this indicate?',
            'options': ['High Variance (Overfitting)', 'High Bias (Underfitting)', 'Optimal Convergence', 'Data Leakage'],
            'correct': 'High Variance (Overfitting)',
            'explanation': 'A huge disparity between high training performance and poor generalization on test data is the classic symptom of High Variance / Overfitting.'
          },
          {
            'title': 'Gradient Descent Learning Rate',
            'question': 'What happens if the learning rate (alpha) in Gradient Descent is set excessively high?',
            'options': ['The optimization may overshoot the minimum and diverge', 'Convergence occurs in 1 epoch', 'The loss stops changing', 'It turns into Logistic Regression'],
            'correct': 'The optimization may overshoot the minimum and diverge',
            'explanation': 'An overly large step size causes the parameter updates to overshoot the global loss minimum, taking increasingly larger steps and diverging.'
          },
          {
            'title': 'Imbalanced Classification Metric Evaluation',
            'question': 'When evaluating an imbalanced dataset (99% non-fraud, 1% fraud), why is Accuracy a misleading metric?',
            'options': [
              'A naive classifier predicting all non-fraud gets 99% accuracy while failing completely',
              'Accuracy requires GPU acceleration',
              'F1-Score is only for regression',
              'ROC-AUC cannot handle binary labels'
            ],
            'correct': 'A naive classifier predicting all non-fraud gets 99% accuracy while failing completely',
            'explanation': 'In severe class imbalance, accuracy measures majority class dominance. Metrics like Precision, Recall, and ROC-AUC are required to measure minority detection ability.'
          },
        ],
        'coding': {
          'title': 'Min-Max Feature Scaling',
          'problem': 'Implement a Python function `minMaxScale(data)` to scale numbers in a list between 0.0 and 1.0.',
          'sample': 'minMaxScale([10, 20, 30, 40, 50]) ➔ [0.0, 0.25, 0.5, 0.75, 1.0]',
          'initialCode': '''def min_max_scale(data):
    min_val = min(data)
    max_val = max(data)
    if max_val == min_val:
        return [0.0 for _ in data]
    return [(x - min_val) / (max_val - min_val) for x in data]''',
        },
        'conceptual': 'How do you handle missing data imputation, feature selection, and outlier detection before feeding features into an ML model?'
      },

      'Deep Learning & Neural Networks': {
        'reasoning': [
          {
            'title': 'Vanishing Gradient Problem',
            'question': 'Which activation function is most prone to causing vanishing gradients in deep backpropagation neural networks?',
            'options': ['Sigmoid / Tanh', 'ReLU', 'Leaky ReLU', 'ELU'],
            'correct': 'Sigmoid / Tanh',
            'explanation': 'The derivative of Sigmoid caps at 0.25. Multiplying small fractions repeatedly across deep layers during backpropagation causes gradients to vanish toward 0.'
          },
          {
            'title': 'CNN Convolution Parameter Calculation',
            'question': 'A 32x32 image is convolved with a 5x5 filter with stride=1 and padding=0. What is the output spatial dimension?',
            'options': ['28x28', '30x30', '32x32', '27x27'],
            'correct': '28x28',
            'explanation': 'Formula: Output = ((W - F + 2P) / S) + 1 ➔ ((32 - 5 + 0) / 1) + 1 = 28. Output dimension is 28x28.'
          },
          {
            'title': 'Dropout Regularization Mechanism',
            'question': 'How does Dropout regularization prevent neural networks from overfitting during training?',
            'options': ['By randomly setting a fraction of neuron outputs to zero during forward pass', 'By clamping weights to zero', 'By doubling the learning rate', 'By decreasing batch size'],
            'correct': 'By randomly setting a fraction of neuron outputs to zero during forward pass',
            'explanation': 'Dropping random activation nodes prevents neurons from co-adapting too strongly, forcing the network to learn redundant representations.'
          },
        ],
        'coding': {
          'title': 'Softmath Normalization Function',
          'problem': 'Implement a Python function `softmax(logits)` that converts a list of raw numerical scores into a valid probability distribution.',
          'sample': 'softmax([1.0, 2.0, 3.0]) ➔ [0.09, 0.24, 0.67]',
          'initialCode': '''import math

def softmax(logits):
    exps = [math.exp(x) for x in logits]
    sum_exps = sum(exps)
    return [e / sum_exps for e in exps]''',
        },
        'conceptual': 'Explain the architectural differences between CNNs, LSTMs, and Self-Attention Transformers when modeling high-dimensional data.'
      },

      // -----------------------------------------------------------------------
      // 3. ECE & EE COURSES
      // -----------------------------------------------------------------------
      'VLSI & Chip Design Fundamentals': {
        'reasoning': [
          {
            'title': 'CMOS Inverter Switching Logic',
            'question': 'In a standard CMOS Inverter, when the input voltage is high (VDD), which transistor state is active?',
            'options': ['NMOS is ON, PMOS is OFF', 'PMOS is ON, NMOS is OFF', 'Both transistors are ON', 'Both transistors are OFF'],
            'correct': 'NMOS is ON, PMOS is OFF',
            'explanation': 'A high input turns the NMOS pull-down transistor ON and turns the PMOS pull-up transistor OFF, pulling the output down to Ground (0V).'
          },
          {
            'title': 'Static Timing Analysis Setup Time',
            'question': 'If Setup Time is violated in a Sequential Flip-Flop, what risk does the digital circuit face?',
            'options': ['Metastability and incorrect data capture', 'Frequency doubling', 'Voltage collapse', 'Clock frequency automatic speedup'],
            'correct': 'Metastability and incorrect data capture',
            'explanation': 'Data must remain stable for a minimum setup time before the active clock edge. Violation causes output to hover metastably between 0 and 1.'
          },
          {
            'title': 'Verilog Non-Blocking Assignment',
            'question': 'In Verilog HDL, which assignment operator should be used inside sequential `always @(posedge clock)` blocks?',
            'options': ['<= (Non-blocking)', '= (Blocking)', '== (Equality)', ':= (Assign)'],
            'correct': '<= (Non-blocking)',
            'explanation': 'Non-blocking assignments (`<=`) evaluate expressions simultaneously at clock edges, modeling true parallel hardware flip-flop registers.'
          },
        ],
        'coding': {
          'title': 'Bitwise Register Operations',
          'problem': 'Write a C function `setRegisterBit(registerVal, bitPosition)` that sets the N-th bit of a register to 1 using bitwise OR.',
          'sample': 'setRegisterBit(0b00000000, 3) ➔ 0b00001000 (8)',
          'initialCode': '''unsigned char setRegisterBit(unsigned char reg, int bitPos) {
    // Bitwise OR with left shift mask
    return reg | (1 << bitPos);
}''',
        },
        'conceptual': 'Explain how you handle power dissipation constraints (Dynamic switching vs Static leakage) in modern sub-micron chip design flows.'
      },

      'Electric Vehicle (EV) Technology': {
        'reasoning': [
          {
            'title': 'Battery Pack Series vs Parallel Configurations',
            'question': 'Connecting four 3.7V 2500mAh Lithium-ion battery cells in Series results in what total voltage and capacity rating?',
            'options': ['14.8V and 2500mAh', '3.7V and 10000mAh', '14.8V and 10000mAh', '7.4V and 5000mAh'],
            'correct': '14.8V and 2500mAh',
            'explanation': 'Series connections add individual cell voltages (3.7V * 4 = 14.8V) while overall amp-hour capacity remains equal to a single cell (2500mAh).'
          },
          {
            'title': 'Regenerative Braking Power Conversion',
            'question': 'During EV regenerative braking, how does the electric traction motor operate?',
            'options': ['As a Generator converting mechanical energy to electrical energy', 'As a step-down transformer', 'As a mechanical friction pad', 'As a DC choke resistor'],
            'correct': 'As a Generator converting mechanical energy to electrical energy',
            'explanation': 'Vehicle kinetic momentum spins the motor rotor, converting kinetic energy into electrical AC/DC power to recharge the battery pack.'
          },
          {
            'title': 'BMS Cell Balancing Purpose',
            'question': 'Why is active or passive Cell Balancing essential in a multi-cell Lithium Battery Management System (BMS)?',
            'options': ['To prevent single cell overcharging or deep discharging that degrades pack capacity', 'To increase battery weight', 'To convert DC to AC', 'To balance wheel speed'],
            'correct': 'To prevent single cell overcharging or deep discharging that degrades pack capacity',
            'explanation': 'Cells degrade unevenly over time. Unbalanced cells limit total usable capacity to the weakest cell and risk thermal runaway during overcharge.'
          },
        ],
        'coding': {
          'title': 'State of Charge (SOC) Estimator',
          'problem': 'Write a C function `estimateSOC(currentVoltage, minVoltage, maxVoltage)` that calculates the percentage charge remaining.',
          'sample': 'estimateSOC(3.7, 3.0, 4.2) ➔ 100% relative calculation',
          'initialCode': '''float estimateSOC(float vCurr, float vMin, float vMax) {
    if (vCurr <= vMin) return 0.0;
    if (vCurr >= vMax) return 100.0;
    return ((vCurr - vMin) / (vMax - vMin)) * 100.0;
}''',
        },
        'conceptual': 'Describe the thermal management and power inverter control strategies used to maximize battery longevity and motor efficiency in EVs.'
      },

      // -----------------------------------------------------------------------
      // 4. DEFAULT FALLBACK FOR ANY OTHER TRACK
      // -----------------------------------------------------------------------
      'Default': {
        'reasoning': [
          {
            'title': 'Algorithmic Efficiency Evaluation',
            'question': 'If doubling the input size N increases execution steps from 100 to 400, what is the asymptotic time complexity class of the algorithm?',
            'options': ['O(N^2) Quadratic', 'O(N) Linear', 'O(log N) Logarithmic', 'O(1) Constant'],
            'correct': 'O(N^2) Quadratic',
            'explanation': 'When scaling factor k = 2 produces a runtime multiplier of k^2 = 4 (400/100), the growth relationship is Quadratic O(N^2).'
          },
          {
            'title': 'Modular System Design Principle',
            'question': 'In software and hardware systems engineering, high cohesion and low coupling promote what primary advantage?',
            'options': ['System maintainability, isolation of bugs, and modular reusability', 'Maximum CPU memory usage', 'Slower execution speeds', 'Higher operational cost'],
            'correct': 'System maintainability, isolation of bugs, and modular reusability',
            'explanation': 'High cohesion ensures a module focuses on a single task, while low coupling minimizes dependencies between components.'
          },
          {
            'title': 'System Resource Contention',
            'question': 'What structural condition occurs when two process threads hold resources while waiting for each other to release additional resources?',
            'options': ['Deadlock', 'Race Condition', 'Starvation', 'Memory Leak'],
            'correct': 'Deadlock',
            'explanation': 'Deadlock occurs when circular wait conditions arise among threads holding mutually exclusive locks.'
          },
        ],
        'coding': {
          'title': 'Find Maximum Value',
          'problem': 'Implement a function `findMax(arr)` that scans an array of numbers and returns the largest value.',
          'sample': 'findMax([3, 9, 1, 24, 5]) ➔ 24',
          'initialCode': '''function findMax(arr) {
  if (arr.length === 0) return null;
  let maxVal = arr[0];
  for (let i = 1; i < arr.length; i++) {
    if (arr[i] > maxVal) {
      maxVal = arr[i];
    }
  }
  return maxVal;
}''',
        },
        'conceptual': 'How do you approach debugging complex edge cases and architectural failures when deploying engineering projects?'
      },
    };

    return dataset[courseTitle] ?? dataset['Default']!;
  }
}