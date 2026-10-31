import 'package:flutter/material.dart';

void main() => runApp(const MyCricket11App());

const gold = Color(0xFFFFC928);
const bg = Color(0xFF090909);
const panel = Color(0xFF191919);

class MyCricket11App extends StatelessWidget {
  const MyCricket11App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY CRICKET 11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: gold,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFF554315)),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

class Match {
  final String teamA, teamB, tournament, starts;
  const Match(this.teamA, this.teamB, this.tournament, this.starts);
}

const matches = [
  Match('IND', 'AUS', 'International T20', 'Today • 7:30 PM'),
  Match('MI', 'CSK', 'League Match', 'Tomorrow • 3:30 PM'),
];

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;
  final List<String> team = [];

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onCreate: (m) => setState(() => tab = 1)),
      TeamPage(team: team, onChanged: (v) => setState(() {
        team
          ..clear()
          ..addAll(v);
      })),
      const LeaderboardPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Icon(Icons.sports_cricket, color: gold, size: 28),
          const SizedBox(width: 9),
          const Text('MY CRICKET 11',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
        ]),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            ),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: gold.withOpacity(.18),
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'My Team'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: 'Ranks'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<Match> onCreate;
  const HomePage({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF3A2B08), Color(0xFF17130A), Color(0xFF101010)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: gold.withOpacity(.65)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PLAY • CREATE TEAM • COMPETE',
                  style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1)),
              SizedBox(height: 12),
              Text('Your Cricket.\\nYour Fantasy XI.',
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
              SizedBox(height: 8),
              Text('Build your best playing XI and climb the leaderboard.',
                  style: TextStyle(color: Colors.white70)),
              SizedBox(height: 14),
              Chip(
                avatar: Icon(Icons.stars, color: gold),
                label: Text('Free-to-play • Practice points'),
                backgroundColor: Color(0xFF28200C),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Upcoming Matches'),
        const SizedBox(height: 10),
        ...matches.map((m) => MatchCard(match: m, onCreate: () => onCreate(m))),
        const SizedBox(height: 18),
        const SectionTitle('How to play'),
        const SizedBox(height: 10),
        const Card(child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HelpLine(Icons.group_add, 'Select 11 players', 'Choose your fantasy team from the player list.'),
            Divider(color: Colors.white12),
            HelpLine(Icons.military_tech, 'Pick captain and vice-captain', 'Set your leadership choices.'),
            Divider(color: Colors.white12),
            HelpLine(Icons.leaderboard, 'Earn practice points', 'Track performance on the leaderboard.'),
          ]),
        )),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback onCreate;
  const MatchCard({super.key, required this.match, required this.onCreate});

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(match.tournament, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const Icon(Icons.sports_cricket, color: gold),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TeamMark(match.teamA),
          const Text('VS', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
          TeamMark(match.teamB),
        ]),
        const SizedBox(height: 12),
        Text(match.starts, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, child: FilledButton(
          style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
          onPressed: onCreate,
          child: const Text('CREATE PRACTICE TEAM', style: TextStyle(fontWeight: FontWeight.bold)),
        )),
      ]),
    ),
  );
}

class TeamMark extends StatelessWidget {
  final String name;
  const TeamMark(this.name, {super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
    CircleAvatar(radius: 25, backgroundColor: const Color(0xFF30260D),
      child: Text(name.substring(0, 1), style: const TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 22))),
    const SizedBox(height: 6),
    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
  ]);
}

class TeamPage extends StatefulWidget {
  final List<String> team;
  final ValueChanged<List<String>> onChanged;
  const TeamPage({super.key, required this.team, required this.onChanged});
  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final players = const [
    'Rohit Sharma', 'Shubman Gill', 'Virat Kohli', 'Suryakumar Yadav',
    'Hardik Pandya', 'Ravindra Jadeja', 'KL Rahul', 'Jasprit Bumrah',
    'Mohammed Siraj', 'Kuldeep Yadav', 'Rishabh Pant', 'Yashasvi Jaiswal',
    'Axar Patel', 'Arshdeep Singh', 'Sanju Samson',
  ];
  String captain = '';
  String vice = '';

  @override
  Widget build(BuildContext context) {
    final selected = widget.team;
    return ListView(padding: const EdgeInsets.all(16), children: [
      const SectionTitle('Create Your Practice XI'),
      const SizedBox(height: 6),
      Text('${selected.length}/11 players selected', style: const TextStyle(color: gold)),
      const SizedBox(height: 10),
      LinearProgressIndicator(value: selected.length / 11, color: gold, backgroundColor: panel),
      const SizedBox(height: 12),
      ...players.map((p) => Card(
        child: CheckboxListTile(
          activeColor: gold,
          checkColor: Colors.black,
          title: Text(p),
          subtitle: Text(p == captain ? 'Captain' : p == vice ? 'Vice-captain' : 'Player'),
          value: selected.contains(p),
          onChanged: (v) {
            final next = [...selected];
            if (v == true && next.length < 11) next.add(p);
            if (v == false) next.remove(p);
            widget.onChanged(next);
            setState(() {});
          },
          secondary: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (v) => setState(() {
              if (v == 'Captain') { captain = p; if (vice == p) vice = ''; }
              if (v == 'Vice-captain') { vice = p; if (captain == p) captain = ''; }
            }),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Captain', child: Text('Set Captain')),
              PopupMenuItem(value: 'Vice-captain', child: Text('Set Vice-captain')),
            ],
          ),
        ),
      )),
      const SizedBox(height: 10),
      Text('Captain: ${captain.isEmpty ? "Not selected" : captain}'),
      Text('Vice-captain: ${vice.isEmpty ? "Not selected" : vice}'),
      const SizedBox(height: 12),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
        onPressed: selected.length == 11 && captain.isNotEmpty && vice.isNotEmpty
          ? () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Practice team saved on this device.')))
          : null,
        child: const Text('SAVE PRACTICE TEAM'),
      ),
      const SizedBox(height: 8),
      const Text('Demo player list only. Live squads, credits, roles and team-combination rules must be connected to a licensed cricket data provider.',
        style: TextStyle(color: Colors.white54, fontSize: 12)),
    ]);
  }
}

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    const SectionTitle('Practice Leaderboard'),
    const SizedBox(height: 8),
    const Text('Sample rankings for the prototype', style: TextStyle(color: Colors.white60)),
    const SizedBox(height: 12),
    ...[
      ('1', 'CricketStar', '980 pts'),
      ('2', 'CoverDrive11', '920 pts'),
      ('3', 'SuperBowler', '875 pts'),
      ('4', 'You', '— pts'),
    ].map((e) => Card(child: ListTile(
      leading: CircleAvatar(backgroundColor: const Color(0xFF30260D), child: Text(e.$1, style: const TextStyle(color: gold))),
      title: Text(e.$2),
      trailing: Text(e.$3, style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
    ))),
  ]);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    const CircleAvatar(radius: 42, backgroundColor: Color(0xFF30260D), child: Icon(Icons.person, size: 42, color: gold)),
    const SizedBox(height: 12),
    const Center(child: Text('Guest Player', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    const Center(child: Text('MY CRICKET 11 member', style: TextStyle(color: Colors.white60))),
    const SizedBox(height: 20),
    const Card(child: Column(children: [
      ListTile(leading: Icon(Icons.account_circle_outlined, color: gold), title: Text('Sign in'), subtitle: Text('OTP login will be connected in the next phase')),
      Divider(height: 1, color: Colors.white12),
      ListTile(leading: Icon(Icons.privacy_tip_outlined, color: gold), title: Text('Privacy & rules'), subtitle: Text('Terms, privacy policy and eligibility')),
      Divider(height: 1, color: Colors.white12),
      ListTile(leading: Icon(Icons.support_agent, color: gold), title: Text('Help & support')),
    ])),
  ]);
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: gold));
}

class HelpLine extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const HelpLine(this.icon, this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(children: [
      Icon(icon, color: gold, size: 26),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ])),
    ]),
  );
}
