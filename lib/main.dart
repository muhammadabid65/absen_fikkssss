import 'package:flutter/material.dart';

void main() => runApp(const SisgoApp());

const orange = Color(0xFFF18743);
const blue = Color(0xFF347FA4);
const green = Color(0xFF429B78);
const ink = Color(0xFF263746);
const muted = Color(0xFF778692);
const bg = Color(0xFFF3F4F6);
const line = Color(0xFFE7E9EC);

class SisgoApp extends StatelessWidget {
  const SisgoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SISGO',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: orange),
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 16),
        bodyLarge: TextStyle(fontSize: 16),
        labelSmall: TextStyle(fontSize: 16),
        labelMedium: TextStyle(fontSize: 16),
        labelLarge: TextStyle(fontSize: 16),
      ),
    ),
    home: const LoginPage(),
  );
}

class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 46, height: 46,
      decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(15)),
      child: const Icon(Icons.fingerprint_rounded, color: Colors.white, size: 30)),
    const SizedBox(width: 11),
    const Text('SISGO', style: TextStyle(color: ink, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
  ]);
}

InputDecoration decoration(String hint, IconData icon) => InputDecoration(
  hintText: hint,
  hintStyle: const TextStyle(color: muted, fontSize: 16),
  prefixIcon: Icon(icon, color: muted, size: 22),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(17),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: line)),
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: line)),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: orange, width: 1.5)),
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 440),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Logo(),
          const SizedBox(height: 58),
          const Text('Welcome Back!', style: TextStyle(color: ink, fontSize: 32, fontWeight: FontWeight.w900)),
          const SizedBox(height: 9),
          const Text('Masuk untuk melanjutkan ke SISGO.', style: TextStyle(color: muted, fontSize: 16)),
          const SizedBox(height: 34),
          const Label('Email'),
          const SizedBox(height: 9),
          TextField(controller: email, keyboardType: TextInputType.emailAddress, style: const TextStyle(fontSize: 16), decoration: decoration('Masukkan email', Icons.email_outlined)),
          const SizedBox(height: 20),
          const Label('Password'),
          const SizedBox(height: 9),
          TextField(controller: password, obscureText: obscure, style: const TextStyle(fontSize: 16),
            decoration: decoration('Masukkan password', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(onPressed: () => setState(() => obscure = !obscure),
                icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
          const SizedBox(height: 28),
          SizedBox(width: double.infinity, height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell())),
              child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 26),
          const Center(child: Text('SISGO Employee Attendance', style: TextStyle(color: muted, fontSize: 16))),
        ]),
      ),
    ))),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  // Home berada di posisi tengah pada navigasi.
  int selected = 2;
  bool checkedIn = false, checkedOut = false;
  void navigate(int page) => setState(() => selected = page);

  @override
  Widget build(BuildContext context) {
    final pages = [
      AttendancePage(
        checkedIn: checkedIn,
        checkedOut: checkedOut,
        onCheckIn: () => setState(() => checkedIn = true),
        onCheckOut: () => setState(() => checkedOut = true),
      ),
      const HistoryPage(),
      HomePage(
        checkedIn: checkedIn,
        checkedOut: checkedOut,
        onNavigate: navigate,
      ),
      const LeavePage(),
      const MorePage(),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final tablet = constraints.maxWidth >= 720;
      return Scaffold(
        body: Row(children: [
          if (tablet)
            NavigationRail(
              minWidth: 190,
              selectedIndex: selected,
              onDestinationSelected: navigate,
              backgroundColor: Colors.white,
              labelType: NavigationRailLabelType.all,
              indicatorColor: const Color(0xFFFFEEE5),
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 26),
                child: Logo(),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text('Absensi'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_rounded),
                  label: Text('Riwayat'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home_filled, size: 27),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.event_available_outlined),
                  label: Text('Pengajuan'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.more_horiz_rounded),
                  label: Text('Lainnya'),
                ),
              ],
            ),
          Expanded(
            child: SafeArea(
              child: IndexedStack(index: selected, children: pages),
            ),
          ),
        ]),
        bottomNavigationBar: tablet
            ? null
            : NavigationBar(
                height: 76,
                selectedIndex: selected,
                onDestinationSelected: navigate,
                backgroundColor: Colors.white,
                indicatorColor: const Color(0xFFFFEEE5),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.camera_alt_outlined),
                    selectedIcon: Icon(Icons.camera_alt_rounded, color: orange),
                    label: 'Absen',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.history_rounded),
                    selectedIcon: Icon(Icons.history, color: orange),
                    label: 'Riwayat',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home_filled, size: 27),
                    selectedIcon: Icon(Icons.home_filled, color: orange, size: 29),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.event_available_outlined),
                    selectedIcon: Icon(Icons.event_available_rounded, color: orange),
                    label: 'Cuti',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.more_horiz_rounded),
                    selectedIcon: Icon(Icons.more_horiz_rounded, color: orange),
                    label: 'Lainnya',
                  ),
                ],
              ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  final bool checkedIn, checkedOut;
  final ValueChanged<int> onNavigate;
  const HomePage({super.key, required this.checkedIn, required this.checkedOut, required this.onNavigate});

  void accountAction(BuildContext context, String value) {
    if (value == 'profile') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    }
    if (value == 'logout') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
    final tablet = constraints.maxWidth >= 720;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(tablet ? 30 : 20, 20, tablet ? 30 : 20, 28),
      child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1080),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hello, Abid', style: TextStyle(color: orange, fontSize: 17, fontWeight: FontWeight.bold)),
              Text('Home', style: TextStyle(color: ink, fontSize: 34, fontWeight: FontWeight.w900)),
              Text('Selasa, 3 November 2026', style: TextStyle(color: orange, fontSize: 16, fontWeight: FontWeight.w600)),
            ])),
            CircleAction(icon: Icons.notifications_none_rounded, color: orange, onTap: () => message(context, 'Belum ada notifikasi.')),
            const SizedBox(width: 12),
            PopupMenuButton<String>(
              tooltip: 'Menu akun', offset: const Offset(0, 52), color: Colors.white, elevation: 7,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              onSelected: (value) => accountAction(context, value),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'profile', child: Row(children: [
                  Icon(Icons.person_outline, color: blue), SizedBox(width: 12),
                  Text('Profil Akun', style: TextStyle(color: ink, fontSize: 16)),
                ])),
                PopupMenuItem(value: 'logout', child: Row(children: [
                  Icon(Icons.logout_rounded, color: orange), SizedBox(width: 12),
                  Text('Logout', style: TextStyle(color: ink, fontSize: 16)),
                ])),
              ],
              child: const CircleAvatar(radius: 25, backgroundColor: Color(0xFFFFE6D7),
                child: Icon(Icons.person_rounded, color: orange, size: 31)),
            ),
          ]),
          const SizedBox(height: 30),
          GridView.count(
            crossAxisCount: tablet ? 3 : 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: tablet ? 20 : 14, mainAxisSpacing: tablet ? 20 : 14,
            childAspectRatio: tablet ? 1.4 : 1.02,
            children: [
              MenuCard(title: 'Absensi', icon: Icons.face_retouching_natural_rounded, color: blue, onTap: () => onNavigate(0)),
              MenuCard(title: 'Riwayat', icon: Icons.history_rounded, color: green, onTap: () => onNavigate(1)),
              MenuCard(title: 'Pengajuan Cuti', icon: Icons.event_available_rounded, color: orange, onTap: () => onNavigate(3)),
              MenuCard(title: 'Laporan', icon: Icons.description_rounded, color: blue, onTap: () => onNavigate(1)),
            ]),
          const SizedBox(height: 18),
          WideCard(icon: Icons.fingerprint_rounded, color: orange, title: 'Status Kehadiran',
            subtitle: checkedOut ? 'Sudah melakukan check-out.' : checkedIn ? 'Sudah melakukan check-in.' : 'Silakan lakukan check-in hari ini.',
            onTap: () => onNavigate(0)),
          const SizedBox(height: 14),
          WideCard(icon: Icons.assignment_outlined, color: blue, title: 'Lihat Laporan',
            subtitle: 'Lihat ringkasan kehadiran kamu.', onTap: () => onNavigate(1)),
          const SizedBox(height: 24),
          const Center(child: Text('SISGO Employee App • Version 1.0.0', style: TextStyle(color: muted, fontSize: 16))),
        ]),
      )),
    );
  });
}

class AttendancePage extends StatelessWidget {
  final bool checkedIn, checkedOut;
  final VoidCallback onCheckIn, onCheckOut;
  const AttendancePage({super.key, required this.checkedIn, required this.checkedOut, required this.onCheckIn, required this.onCheckOut});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(22), children: [
    const Heading('Absensi', 'Catat kehadiran harian kamu.'), const SizedBox(height: 22),
    Panel(child: Column(children: [
      const Icon(Icons.access_time_filled_rounded, size: 48, color: orange), const SizedBox(height: 12),
      const Text('08:00', style: TextStyle(color: ink, fontSize: 40, fontWeight: FontWeight.w900)),
      const Text('Jam kerja hari ini', style: TextStyle(color: muted, fontSize: 16)), const SizedBox(height: 15),
      Text(
        checkedOut ? 'Sudah Check-out' : checkedIn ? 'Sudah Check-in' : 'Check-in',
        style: TextStyle(
          color: checkedIn ? green : Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ])),
    const SizedBox(height: 18),
    Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Selfie Attendance', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 14),
      Container(height: 220, width: double.infinity, decoration: BoxDecoration(color: const Color(0xFFEAF0F3), borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(checkedIn ? Icons.check_circle_rounded : Icons.camera_front_rounded, color: checkedIn ? green : blue, size: 58),
          const SizedBox(height: 12),
          Text(checkedIn ? 'Foto berhasil disimulasikan' : 'Camera Preview', style: const TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 7), const Text('Area foto dummy', style: TextStyle(color: muted, fontSize: 16)),
        ])),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, height: 54, child: FilledButton.icon(
        onPressed: checkedIn ? null : () { onCheckIn(); message(context, 'Check-in dummy berhasil!'); },
        icon: const Icon(Icons.camera_alt_rounded), label: const Text('Ambil Foto & Check-in', style: TextStyle(fontSize: 16)),
        style: FilledButton.styleFrom(backgroundColor: orange))),
      const SizedBox(height: 10),
      SizedBox(width: double.infinity, height: 54, child: OutlinedButton.icon(
        onPressed: checkedIn && !checkedOut ? onCheckOut : null,
        icon: const Icon(Icons.logout_rounded), label: const Text('Check-out', style: TextStyle(fontSize: 16)))),
    ])),
    const SizedBox(height: 18),
    const Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Informasi Lokasi', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 12), Icon(Icons.location_on_outlined, color: blue, size: 32),
      Text('Lokasi kantor (dummy)', style: TextStyle(color: muted, fontSize: 16)),
    ])),
  ]);
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  static const records = [
    ('03 Nov 2026', 'Selasa', 'Hadir', '07:55', green),
    ('02 Nov 2026', 'Senin', 'Hadir', '07:54', green),
    ('01 Nov 2026', 'Minggu', 'WFA', '08:02', blue),
    ('31 Okt 2026', 'Sabtu', 'Cuti', '-', orange),
    ('30 Okt 2026', 'Jumat', 'Sakit', '-', blue),
    ('29 Okt 2026', 'Kamis', 'Hadir', '07:58', green),
    ('28 Okt 2026', 'Rabu', 'Izin', '-', orange),
    ('27 Okt 2026', 'Selasa', 'Alpha', '-', muted),
  ];
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(22), children: [
    const Heading('Riwayat Absensi', 'Pantau seluruh catatan kehadiran.'), const SizedBox(height: 20),
    const Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('November 2026', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 17), AttendanceCalendar(), SizedBox(height: 16),
      Wrap(spacing: 14, runSpacing: 10, children: [Legend(green, 'Hadir'), Legend(blue, 'WFA / Sakit'), Legend(orange, 'Izin / Cuti')]),
    ])),
    const SizedBox(height: 20),
    const Text('Aktivitas Terbaru', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 18)),
    const SizedBox(height: 12),
    ...records.map((r) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Panel(child: Row(children: [
      Icon(Icons.calendar_today_rounded, color: r.$5, size: 25), const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(r.$1, style: const TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5), Text('${r.$2} • ${r.$4}', style: const TextStyle(color: muted, fontSize: 16)),
      ])),
      BadgeStatus(r.$3, r.$5),
    ])))),
  ]);
}

class AttendanceCalendar extends StatelessWidget {
  const AttendanceCalendar({super.key});
  @override
  Widget build(BuildContext context) {
    const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    const present = [2,3,4,5,6,9,10,11,12,13,16,17,18,19,20,23,24,25,26,27];
    return Column(children: [
      GridView.count(crossAxisCount: 7, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        children: days.map((d) => Center(child: Text(d, style: const TextStyle(color: muted, fontSize: 16, fontWeight: FontWeight.bold)))).toList()),
      GridView.count(crossAxisCount: 7, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 5,
        children: List.generate(35, (i) {
          final day = i - 5;
          if (day < 1 || day > 30) return const SizedBox();
          final today = day == 3;
          return Container(alignment: Alignment.center,
            decoration: BoxDecoration(color: today ? orange : present.contains(day) ? green.withOpacity(.13) : Colors.transparent, borderRadius: BorderRadius.circular(9)),
            child: Text('$day', style: TextStyle(color: today ? Colors.white : ink, fontSize: 16, fontWeight: FontWeight.bold)));
        })),
    ]);
  }
}

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});
  @override
  State<LeavePage> createState() => _LeavePageState();
}
class _LeavePageState extends State<LeavePage> {
  String type = 'Cuti', status = 'Belum ada pengajuan';
  DateTime? start, end;
  final reason = TextEditingController();
  @override
  void dispose() { reason.dispose(); super.dispose(); }
  Future<void> pickDate(bool isStart) async {
    final date = await showDatePicker(context: context, initialDate: DateTime(2026, 11, 3), firstDate: DateTime(2026), lastDate: DateTime(2027, 12, 31));
    if (date != null) setState(() { if (isStart) { start = date; } else { end = date; } });
  }
  String dateText(DateTime? d) => d == null ? 'Pilih tanggal' : '${d.day}/${d.month}/${d.year}';
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(22), children: [
    const Heading('Pengajuan Cuti', 'Buat pengajuan izin, sakit, atau cuti.'), const SizedBox(height: 20),
    Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Label('Jenis Pengajuan'), const SizedBox(height: 9),
      DropdownButtonFormField<String>(value: type, style: const TextStyle(color: ink, fontSize: 16), decoration: decoration('Pilih jenis', Icons.category_outlined),
        items: ['Cuti','Izin','Sakit','WFA'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 16)))).toList(),
        onChanged: (v) { if (v != null) setState(() => type = v); }),
      const SizedBox(height: 18), const Label('Tanggal Mulai'), const SizedBox(height: 9),
      DateButton(text: dateText(start), onTap: () => pickDate(true)),
      const SizedBox(height: 18), const Label('Tanggal Selesai'), const SizedBox(height: 9),
      DateButton(text: dateText(end), onTap: () => pickDate(false)),
      const SizedBox(height: 18), const Label('Alasan'), const SizedBox(height: 9),
      TextField(controller: reason, maxLines: 4, style: const TextStyle(fontSize: 16), decoration: decoration('Masukkan alasan pengajuan', Icons.edit_note_rounded)),
      const SizedBox(height: 20),
      SizedBox(width: double.infinity, height: 54, child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: orange),
        onPressed: () { setState(() => status = 'Menunggu Persetujuan'); message(context, 'Pengajuan dummy berhasil dibuat.'); },
        child: const Text('Kirim Pengajuan', style: TextStyle(fontSize: 16)))),
    ])),
    const SizedBox(height: 18),
    Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Status Pengajuan', style: TextStyle(color: ink, fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 13), BadgeStatus(status, orange), const SizedBox(height: 10),
      const Text('Informasi ini merupakan data simulasi.', style: TextStyle(color: muted, fontSize: 16)),
    ])),
  ]);
}


class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const Heading('Lainnya', 'Informasi dan bantuan aplikasi SISGO.'),
          const SizedBox(height: 20),
          Panel(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.info_outline_rounded, color: blue),
                  title: const Text('Tentang SISGO', style: TextStyle(fontSize: 16)),
                  trailing: const Icon(Icons.chevron_right, color: muted),
                  onTap: () => message(context, 'SISGO Employee App • Version 1.0.0'),
                ),
                const Divider(color: line),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.help_outline_rounded, color: blue),
                  title: const Text('Pusat Bantuan', style: TextStyle(fontSize: 16)),
                  trailing: const Icon(Icons.chevron_right, color: muted),
                  onTap: () => message(context, 'Pusat Bantuan dummy'),
                ),
              ],
            ),
          ),
        ],
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(22), children: [
    const Heading('Profil Staf', 'Informasi akun karyawan SISGO.'), const SizedBox(height: 20),
    const Panel(child: Column(children: [
      CircleAvatar(radius: 46, backgroundColor: Color(0xFFFFE8DA), child: Icon(Icons.person_rounded, color: orange, size: 54)),
      SizedBox(height: 14),
      Text('Muhammad Abid Amirullah', textAlign: TextAlign.center, style: TextStyle(color: ink, fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 7), Text('Mobile Developer', style: TextStyle(color: muted, fontSize: 16)),
      SizedBox(height: 12), BadgeStatus('Karyawan Aktif', green),
    ])),
    const SizedBox(height: 18),
    const Panel(child: Column(children: [
      ProfileRow('ID Karyawan', 'SIS-00128'), Divider(color: line),
      ProfileRow('Departemen', 'Technology'), Divider(color: line),
      ProfileRow('Email', 'abid@sisgo.co.id'), Divider(color: line),
      ProfileRow('Jabatan', 'Mobile Developer'), Divider(color: line),
      ProfileRow('Status', 'Aktif'),
    ])),
    const SizedBox(height: 16),
    Panel(child: Column(children: [
      ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.settings_outlined, color: blue),
        title: const Text('Pengaturan', style: TextStyle(fontSize: 16)), trailing: const Icon(Icons.chevron_right, color: muted),
        onTap: () => message(context, 'Pengaturan dummy')),
      const Divider(color: line),
      ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.help_outline, color: blue),
        title: const Text('Pusat Bantuan', style: TextStyle(fontSize: 16)), trailing: const Icon(Icons.chevron_right, color: muted),
        onTap: () => message(context, 'Pusat Bantuan dummy')),
    ])),
  ]);
}

class Label extends StatelessWidget {
  final String text;
  const Label(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 16, color: ink, fontWeight: FontWeight.bold));
}
class Heading extends StatelessWidget {
  final String title, subtitle;
  const Heading(this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: ink, fontSize: 27, fontWeight: FontWeight.w900)),
    const SizedBox(height: 7), Text(subtitle, style: const TextStyle(color: muted, fontSize: 16)),
  ]);
}
class MenuCard extends StatelessWidget {
  final String title; final String? subtitle; final IconData icon; final Color color; final VoidCallback onTap;
  const MenuCard({super.key, required this.title, this.subtitle, required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(color: Colors.white, borderRadius: BorderRadius.circular(25),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(25),
      child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: line),
        boxShadow: [BoxShadow(color: ink.withOpacity(.035), blurRadius: 12, offset: const Offset(0,5))]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: color.withOpacity(.18), blurRadius: 13, offset: const Offset(0,5))]),
            child: Icon(icon, color: Colors.white, size: 33)),
          const SizedBox(height: 15),
          Text(title, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: ink, fontSize: 17, fontWeight: FontWeight.w800)),
          if (subtitle != null) ...[const SizedBox(height: 6), Text(subtitle!, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 16))],
        ]))));
}
class WideCard extends StatelessWidget {
  final IconData icon; final Color color; final String title, subtitle; final VoidCallback onTap;
  const WideCard({super.key, required this.icon, required this.color, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(color: Colors.white, borderRadius: BorderRadius.circular(23),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(23),
      child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), border: Border.all(color: line)),
        child: Row(children: [
          Container(width: 58, height: 58, decoration: BoxDecoration(color: color.withOpacity(.14), borderRadius: BorderRadius.circular(17)), child: Icon(icon, color: color, size: 30)),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: ink, fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6), Text(subtitle, style: const TextStyle(color: muted, fontSize: 16)),
          ])),
          const Icon(Icons.chevron_right_rounded, color: muted),
        ]))));
}
class CircleAction extends StatelessWidget {
  final IconData icon; final Color color; final VoidCallback onTap;
  const CircleAction({super.key, required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(50),
    child: Container(width: 49, height: 49, decoration: BoxDecoration(color: color, shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: color.withOpacity(.2), blurRadius: 12, offset: const Offset(0,5))]),
      child: Icon(icon, color: Colors.white, size: 25)));
}
class BadgeStatus extends StatelessWidget {
  final String text; final Color color;
  const BadgeStatus(this.text, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(30)),
    child: Text(text, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)));
}
class Panel extends StatelessWidget {
  final Widget child;
  const Panel({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(21), border: Border.all(color: line),
      boxShadow: [BoxShadow(color: ink.withOpacity(.025), blurRadius: 10, offset: const Offset(0,4))]),
    child: child);
}
class Legend extends StatelessWidget {
  final Color color; final String text;
  const Legend(this.color, this.text, {super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    CircleAvatar(radius: 5, backgroundColor: color), const SizedBox(width: 7),
    Text(text, style: const TextStyle(fontSize: 16, color: muted)),
  ]);
}
class DateButton extends StatelessWidget {
  final String text; final VoidCallback onTap;
  const DateButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(13),
    child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFFAFBFC), borderRadius: BorderRadius.circular(13), border: Border.all(color: line)),
      child: Row(children: [
        const Icon(Icons.calendar_month_outlined, color: blue), const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: ink, fontSize: 16))),
        const Icon(Icons.keyboard_arrow_down, color: muted),
      ])));
}
class ProfileRow extends StatelessWidget {
  final String label, value;
  const ProfileRow(this.label, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 13),
    child: Row(children: [
      Expanded(child: Text(label, style: const TextStyle(color: muted, fontSize: 16))),
      Flexible(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.bold))),
    ]));
}
void message(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text, style: const TextStyle(fontSize: 16))));
}
