import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ua_app_secu/controllers/entrance.dart';
import 'package:ua_app_secu/controllers/repo.dart' as repo;
import 'package:ua_app_secu/controllers/settings.dart';
import 'package:ua_app_secu/icons.dart';
import 'package:ua_app_secu/screens/login.dart';
import 'package:ua_app_secu/theme.dart';
import 'package:flutter/services.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UA Secu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().get(),
      home: const MainPageState(title: 'UA Secu Scanner'),
    );
  }
}

class MainPageState extends StatefulWidget {
  const MainPageState({super.key, required this.title});
  final String title;

  @override
  State<MainPageState> createState() => _MainPage();
}

class _MainPage extends State<MainPageState> {
  int selectedPageIndex = 1;
  List<Widget>? pages;
  PageController? pageController;

  @override
  void initState() {
    super.initState();

    pages = [
      GetBuilder<SettingsController>(
        builder: (tx) => tx.page,
      ),
      GetBuilder<repo.RepoController>(
        builder: (tx) => tx.currentPage!,
      ),
      GetBuilder<EntranceController>(
        builder: (tx) => tx.currentPage!,
      ),
    ];

    pageController = PageController(initialPage: selectedPageIndex);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    repo.RepoController repoController = Get.put(repo.RepoController());
    EntranceController entranceController = Get.put(EntranceController());
    SettingsController settingsController = Get.put(SettingsController());

    return GetBuilder<SettingsController>(
      builder: (settings) {
        return settings.bearerToken == null
            ? const LoginPage()
            : Scaffold(
                body: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pages ?? [],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  enableFeedback: true,
                  fixedColor: const Color.fromARGB(255, 41, 45, 50),
                  currentIndex: selectedPageIndex,
                  onTap: (index) {
                    setState(() {
                      if (index != 1 && selectedPageIndex == 1) {
                        if (repoController.selectedPage ==
                                repo.Page.playerQRCode ||
                            repoController.selectedPage ==
                                repo.Page.playerRepoAdd ||
                            repoController.selectedPage ==
                                repo.Page.playerRepoRemove) {
                          repoController.changePage(repo.Page.blank);
                        }
                      }

                      if (index != 2 && selectedPageIndex == 2) {
                        if (entranceController.selectedIndex == 0) {
                          entranceController.changePage(2);
                        }
                      }

                      selectedPageIndex = index;

                      if (index == 1 &&
                          repoController.selectedPage == repo.Page.blank) {
                        repoController.changePage(repo.Page.playerQRCode);
                      }

                      if (index == 2 && entranceController.selectedIndex == 2) {
                        entranceController.changePage(0);
                      }

                      pageController!.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      activeIcon: Icon(Iconsax.settingsBold),
                      icon: Icon(Iconsax.settings),
                      label: 'Paramètres',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(Iconsax.boxBold),
                      icon: Icon(Iconsax.box),
                      label: 'Repo',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(Iconsax.fingerScanBold),
                      icon: Icon(Iconsax.fingerScan),
                      label: 'Entrée',
                    ),
                  ],
                ),
              );
      },
    );
  }
}
