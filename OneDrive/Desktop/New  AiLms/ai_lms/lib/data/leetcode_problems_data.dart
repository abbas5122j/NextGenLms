class LeetCodeProblem {
  final int id;
  final String title;
  final String category;
  final String difficulty; // Easy, Medium, Hard
  final String acceptance;
  final bool isBlind75;
  final bool isTop150;
  final bool isSolved;
  final String solutionCppUrl;
  final String solutionPythonUrl;
  final String initialCode;

  LeetCodeProblem({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.acceptance,
    this.isBlind75 = false,
    this.isTop150 = false,
    this.isSolved = false,
    required this.solutionCppUrl,
    required this.solutionPythonUrl,
    required this.initialCode,
  });
}

class LeetCodeProblemsData {
  static final List<LeetCodeProblem> problems = [
    // -------------------------------------------------------------------------
    // ARRAYS & HASHING
    // -------------------------------------------------------------------------
    LeetCodeProblem(
      id: 217,
      title: 'Contains Duplicate',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '61.3%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/contains-duplicate.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/contains-duplicate.py',
      initialCode: '''bool containsDuplicate(vector<int>& nums) {
    unordered_set<int> seen;
    for (int num : nums) {
        if (seen.count(num)) return true;
        seen.insert(num);
    }
    return false;
}''',
    ),
    LeetCodeProblem(
      id: 242,
      title: 'Valid Anagram',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '63.2%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/valid-anagram.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/valid-anagram.py',
      initialCode: '''bool isAnagram(string s, string t) {
    if (s.length() != t.length()) return false;
    unordered_map<char, int> counts;
    for (char c : s) counts[c]++;
    for (char c : t) {
        if (--counts[c] < 0) return false;
    }
    return true;
}''',
    ),
    LeetCodeProblem(
      id: 1,
      title: 'Two Sum',
      category: 'Arrays & Hashing',
      difficulty: 'Easy',
      acceptance: '52.4%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/two-sum.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/two-sum.py',
      initialCode: '''vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> mp;
    for (int i = 0; i < nums.size(); ++i) {
        if (mp.count(target - nums[i])) return {mp[target - nums[i]], i};
        mp[nums[i]] = i;
    }
    return {};
}''',
    ),
    LeetCodeProblem(
      id: 49,
      title: 'Group Anagrams',
      category: 'Arrays & Hashing',
      difficulty: 'Medium',
      acceptance: '67.8%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/group-anagrams.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/group-anagrams.py',
      initialCode: '''vector<vector<string>> groupAnagrams(vector<string>& strs) {
    unordered_map<string, vector<string>> mp;
    for (string s : strs) {
        string t = s;
        sort(t.begin(), t.end());
        mp[t].push_back(s);
    }
    vector<vector<string>> res;
    for (auto p : mp) res.push_back(p.second);
    return res;
}''',
    ),
    LeetCodeProblem(
      id: 347,
      title: 'Top K Frequent Elements',
      category: 'Arrays & Hashing',
      difficulty: 'Medium',
      acceptance: '63.5%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/top-k-frequent-elements.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/top-k-frequent-elements.py',
      initialCode: '''vector<int> topKFrequent(vector<int>& nums, int k) {
    unordered_map<int, int> count;
    for (int n : nums) count[n]++;
    priority_queue<pair<int, int>> pq;
    for (auto const& [val, freq] : count) pq.push({freq, val});
    vector<int> res;
    while (k--) {
        res.push_back(pq.top().second);
        pq.pop();
    }
    return res;
}''',
    ),

    // -------------------------------------------------------------------------
    // TWO POINTERS
    // -------------------------------------------------------------------------
    LeetCodeProblem(
      id: 125,
      title: 'Valid Palindrome',
      category: 'Two Pointers',
      difficulty: 'Easy',
      acceptance: '46.9%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/valid-palindrome.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/valid-palindrome.py',
      initialCode: '''bool isPalindrome(string s) {
    int l = 0, r = s.length() - 1;
    while (l < r) {
        while (l < r && !isalnum(s[l])) l++;
        while (l < r && !isalnum(s[r])) r--;
        if (tolower(s[l]) != tolower(s[r])) return false;
        l++; r--;
    }
    return true;
}''',
    ),
    LeetCodeProblem(
      id: 15,
      title: '3Sum',
      category: 'Two Pointers',
      difficulty: 'Medium',
      acceptance: '33.1%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/3sum.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/3sum.py',
      initialCode: '''vector<vector<int>> threeSum(vector<int>& nums) {
    sort(nums.begin(), nums.end());
    vector<vector<int>> res;
    for (int i = 0; i < nums.size(); ++i) {
        if (i > 0 && nums[i] == nums[i-1]) continue;
        int l = i + 1, r = nums.size() - 1;
        while (l < r) {
            int sum = nums[i] + nums[l] + nums[r];
            if (sum < 0) l++;
            else if (sum > 0) r--;
            else {
                res.push_back({nums[i], nums[l], nums[r]});
                while (l < r && nums[l] == nums[l+1]) l++;
                while (l < r && nums[r] == nums[r-1]) r--;
                l++; r--;
            }
        }
    }
    return res;
}''',
    ),
    LeetCodeProblem(
      id: 11,
      title: 'Container With Most Water',
      category: 'Two Pointers',
      difficulty: 'Medium',
      acceptance: '54.2%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/container-with-most-water.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/container-with-most-water.py',
      initialCode: '''int maxArea(vector<int>& height) {
    int l = 0, r = height.size() - 1;
    int max_w = 0;
    while (l < r) {
        max_w = max(max_w, min(height[l], height[r]) * (r - l));
        if (height[l] < height[r]) l++;
        else r--;
    }
    return max_w;
}''',
    ),

    // -------------------------------------------------------------------------
    // SLIDING WINDOW
    // -------------------------------------------------------------------------
    LeetCodeProblem(
      id: 121,
      title: 'Best Time to Buy and Sell Stock',
      category: 'Sliding Window',
      difficulty: 'Easy',
      acceptance: '53.6%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/best-time-to-buy-and-sell-stock.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/best-time-to-buy-and-sell-stock.py',
      initialCode: '''int maxProfit(vector<int>& prices) {
    int min_price = INT_MAX;
    int max_profit = 0;
    for (int p : prices) {
        min_price = min(min_price, p);
        max_profit = max(max_profit, p - min_price);
    }
    return max_profit;
}''',
    ),
    LeetCodeProblem(
      id: 3,
      title: 'Longest Substring Without Repeating Characters',
      category: 'Sliding Window',
      difficulty: 'Medium',
      acceptance: '34.2%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/longest-substring-without-repeating-characters.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/longest-substring-without-repeating-characters.py',
      initialCode: '''int lengthOfLongestSubstring(string s) {
    unordered_set<char> chars;
    int l = 0, max_len = 0;
    for (int r = 0; r < s.length(); ++r) {
        while (chars.count(s[r])) {
            chars.erase(s[l]);
            l++;
        }
        chars.insert(s[r]);
        max_len = max(max_len, r - l + 1);
    }
    return max_len;
}''',
    ),

    // -------------------------------------------------------------------------
    // LINKED LIST
    // -------------------------------------------------------------------------
    LeetCodeProblem(
      id: 206,
      title: 'Reverse Linked List',
      category: 'Linked List',
      difficulty: 'Easy',
      acceptance: '75.1%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/reverse-linked-list.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/reverse-linked-list.py',
      initialCode: '''ListNode* reverseList(ListNode* head) {
    ListNode* prev = nullptr;
    ListNode* curr = head;
    while (curr) {
        ListNode* nextTemp = curr->next;
        curr->next = prev;
        prev = curr;
        curr = nextTemp;
    }
    return prev;
}''',
    ),
    LeetCodeProblem(
      id: 141,
      title: 'Linked List Cycle',
      category: 'Linked List',
      difficulty: 'Easy',
      acceptance: '48.9%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/linked-list-cycle.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/linked-list-cycle.py',
      initialCode: '''bool hasCycle(ListNode *head) {
    if (!head || !head->next) return false;
    ListNode *slow = head, *fast = head->next;
    while (slow != fast) {
        if (!fast || !fast->next) return false;
        slow = slow->next;
        fast = fast->next->next;
    }
    return true;
}''',
    ),

    // -------------------------------------------------------------------------
    // DYNAMIC PROGRAMMING
    // -------------------------------------------------------------------------
    LeetCodeProblem(
      id: 70,
      title: 'Climbing Stairs',
      category: 'Dynamic Programming',
      difficulty: 'Easy',
      acceptance: '52.3%',
      isBlind75: true,
      isTop150: true,
      isSolved: true,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/climbing-stairs.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/climbing-stairs.py',
      initialCode: '''int climbStairs(int n) {
    if (n <= 2) return n;
    int a = 1, b = 2;
    for (int i = 3; i <= n; ++i) {
        int temp = a + b;
        a = b;
        b = temp;
    }
    return b;
}''',
    ),
    LeetCodeProblem(
      id: 322,
      title: 'Coin Change',
      category: 'Dynamic Programming',
      difficulty: 'Medium',
      acceptance: '42.7%',
      isBlind75: true,
      isTop150: true,
      isSolved: false,
      solutionCppUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/C++/coin-change.cpp',
      solutionPythonUrl: 'https://github.com/black-shadows/LeetCode-Topicwise-Solutions/blob/master/Python/coin-change.py',
      initialCode: '''int coinChange(vector<int>& coins, int amount) {
    vector<int> dp(amount + 1, amount + 1);
    dp[0] = 0;
    for (int i = 1; i <= amount; ++i) {
        for (int coin : coins) {
            if (i - coin >= 0) dp[i] = min(dp[i], 1 + dp[i - coin]);
        }
    }
    return dp[amount] > amount ? -1 : dp[amount];
}''',
    ),
  ];
}