import 'package:get/get.dart';

// AUTH
import '../../features/auth/bindings/forgot_password_binding.dart';
import '../../features/auth/bindings/login_binding.dart';
import '../../features/auth/bindings/register_binding.dart';
import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/register_view.dart';

// HOME
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';

// TASK
import '../../features/task/bindings/task_binding.dart';
import '../../features/task/views/task_view.dart';

// ADD TASK
import '../../features/task/bindings/add_task_binding.dart';
import '../../features/task/views/add_task_view.dart';

// TASK DETAILS
import '../../features/task/bindings/task_details_binding.dart';
import '../../features/task/views/task_details_view.dart';

// PROFILE
import '../../features/profile/bindings/profile_binding.dart';
import '../../features/profile/views/profile_view.dart';

// SPLASH
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';

// ROUTES
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [

    // SPLASH
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    // LOGIN
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // REGISTER
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    // FORGOT PASSWORD
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),

    // HOME
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    // TASKS
    GetPage(
      name: AppRoutes.tasks,
      page: () => const TaskView(),
      binding: TaskBinding(),
    ),

    // ADD TASK
    GetPage(
      name: AppRoutes.addTask,
      page: () => const AddTaskView(),
      binding: AddTaskBinding(),
    ),

    // TASK DETAILS ✅
    GetPage(
      name: AppRoutes.taskDetails,
      page: () => const TaskDetailsView(),
      binding: TaskDetailsBinding(),
    ),

    // PROFILE ✅
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}