import 'package:get/get.dart';
import '../../features/auth/bindings/forgot_password_binding.dart';
import '../../features/auth/bindings/login_binding.dart';
import '../../features/auth/bindings/register_binding.dart';

import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';
import '../../features/task/bindings/task_binding.dart';
import '../../features/task/views/task_view.dart';
import '../../features/task/bindings/add_task_binding.dart';
import '../../features/task/views/add_task_view.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.tasks,
      page: () => const TaskView(),
      binding: TaskBinding(),
      preventDuplicates: false,
    ),
    // ADD TASK
    GetPage(
      name: AppRoutes.addTask,
      page: () => const AddTaskView(),
      binding: AddTaskBinding(),
    ),
  ];
}