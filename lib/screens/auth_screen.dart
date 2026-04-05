import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isObscured = true;
  bool isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(isLogin ? 'Login Success!' : 'Registration Success!'),
                backgroundColor: Colors.green),
          );
          // Navigate to Home or next screen here
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed! Check your data or connection.'),
                backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1E0B36),
                Color(0xFF000000),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Custom Top Menu Icon
              Positioned(
                top: 50,
                left: 24,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.menu, color: Colors.black, size: 24),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      // Top Icon with Glow
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6A1B9A).withOpacity(0.3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6A1B9A).withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_person_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        isLogin ? 'WELCOME BACK' : 'CREATE ACCOUNT',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Main Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(28),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            // Tabs
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => isLogin = true),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: isLogin
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: isLogin
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      if (isLogin) const SizedBox(height: 4),
                                      if (isLogin)
                                        Container(
                                            height: 2,
                                            width: 40,
                                            color: Colors.purpleAccent),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => isLogin = false),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: !isLogin
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: !isLogin
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      if (!isLogin) const SizedBox(height: 4),
                                      if (!isLogin)
                                        Container(
                                            height: 2,
                                            width: 40,
                                            color: Colors.purpleAccent),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            // Email Field
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email_outlined,
                                    color: Colors.grey),
                                hintText: 'Email Address',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.08),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Password Field
                            TextField(
                              controller: _passwordController,
                              obscureText: isObscured,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline,
                                    color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      isObscured
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.grey),
                                  onPressed: () => setState(
                                      () => isObscured = !isObscured),
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.08),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.purpleAccent, fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Login Button
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Container(
                                  width: double.infinity,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFF9C27B0),
                                      Color(0xFF6A1B9A)
                                    ]),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6A1B9A)
                                            .withOpacity(0.4),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: state is AuthLoadingState
                                        ? null
                                        : () {
                                            if (isLogin) {
                                              context
                                                  .read<AuthCubit>()
                                                  .loginWithEmailAndPassword(
                                                    emailAddress:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController.text,
                                                  );
                                            } else {
                                              context
                                                  .read<AuthCubit>()
                                                  .registerWithEmailAndPassword(
                                                    emailAddress:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController.text,
                                                  );
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: state is AuthLoadingState
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : Text(isLogin ? 'LOG IN' : 'SIGN UP',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Footer
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                  color: Colors.white.withOpacity(0.1))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or connect with',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                                  color: Colors.white.withOpacity(0.1))),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Social Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialButton(
                              icon: Icons.g_mobiledata_rounded,
                              color: Colors.white,
                              onTap: () {
                                context.read<AuthCubit>().signInWithGoogle();
                              }),
                          const SizedBox(width: 20),
                          _SocialButton(
                              icon: Icons.apple,
                              color: Colors.white,
                              onTap: () {}),
                          const SizedBox(width: 20),
                          _SocialButton(
                              icon: Icons.facebook,
                              color: Colors.white,
                              onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  const _SocialButton(
      {required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Center(
          child: Icon(icon, color: color, size: 28),
        ),
      ),
    );
  }
}
