import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sera_shop/bloc/auth_bloc.dart';
import 'package:sera_shop/bloc/cart_bloc.dart';
import 'package:sera_shop/bloc/product_bloc.dart';
import 'package:sera_shop/model/product_model.dart';
import 'package:sera_shop/screens/cart_screen.dart';
import 'package:sera_shop/screens/home_screen.dart';
import 'package:sera_shop/screens/login_screen.dart';
import 'package:sera_shop/screens/product_detail.dart';
import 'package:sera_shop/screens/splash_screen.dart';
import 'package:sera_shop/service/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:sera_shop/service/product_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const HomeScreen();
            }
            return const SplashScreen();
          },
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); 
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              final duration = CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 1.0, curve: Curves.linear), // Full duration
              );

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = duration.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 1),
          );
        },
      ),
      GoRoute(
        path: '/home',
         pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: '/product/:id',
        pageBuilder: (context, state) {
          final product = state.extra as Product;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductDetail(product: product),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const CartScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool isLogin = context.read<AuthBloc>().state is AuthenticatedState;
      final bool goLogin = state.uri.toString() == '/login';

      if (!isLogin && !goLogin) {
        return '/';
      }
      if (isLogin && goLogin) {
        return '/home';
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authService: AuthService(
              client: http.Client(),
              baseUrl: 'https://api.escuelajs.co/api/v1',
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productService: ProductService(
              client: http.Client(),
              baseUrl: 'https://fakestoreapi.com',
            ),
          ),
        ),
        BlocProvider(create: (context) => CartBloc()), 
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Shop IT',
        theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: Colors.teal,
          colorScheme: const ColorScheme.light(primary: Colors.teal),
        ),
        routerConfig: router,
        // home: BlocBuilder<AuthBloc, AuthState>(
        //   builder: (context, state) {
        //     if (state is AuthenticatedState) {
        //       return const HomeScreen();
        //     }
        //     return const SplashScreen();
        //   },
        // ),
      ),
    );
  }
}
