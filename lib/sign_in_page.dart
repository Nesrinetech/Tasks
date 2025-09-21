import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;


  @override
  void dispose() {
     _emailController.dispose();
     _passwordController.dispose();
     super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;



      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/homepage');
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login error: $e')),
      );
       
    }  finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

// placeholder forgot password

void _handleForgotPassword() {
  showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Forgot Password'),
    content: const Text('Implement forgot password flow (send reset email).'),
    actions: [
      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
    ],
  ),
  );
}

  //  google sign in
  Future<void> _signInWithGoogle() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Google sign-in not implemented')));
  }

  // apple sign in 
    Future<void> _signInWithApple() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Apple sign-in not implemented')));
  }



  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
//  back arrow

  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
      ),
    ],
),
   const SizedBox(height: 10),

  //  title + subtitle
      const Text(
        'Welcome Back!👋',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 6),
        const Text(
          'Sign in to your account',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 24),
       

      // The form (email password)
      Form(
        key: _formKey,
        child: Column(
          children: [
            // email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@example.com',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),

              ),
              validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Please enter your email';
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) return 'Enter a valid email';
              return null; 
              },
            ),

            const SizedBox(height: 12),

             // Password field with show/hide
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your password';
                        if (value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 8),

                    // Forgot Password aligned right
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        child: const Text('Forgot Password?'),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: _isLoading
                            ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Don't have account? Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/signup'),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Or with separator
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('Or with', style: TextStyle(color: Colors.grey.shade600)),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Social sign-in buttons: Google and Apple
                    Row(
                      children: [
                        // Google button
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _signInWithGoogle,
                            icon: Image.asset(
                              'assets/icons/google.png', // optional: provide a small google icon asset
                              height: 20,
                              width: 20,
                              errorBuilder: (context, error, st) => const Icon(Icons.g_mobiledata),
                            ),
                            label: const Text('Google'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Apple button
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _signInWithApple,
                            icon: const Icon(Icons.apple, size: 20),
                            label: const Text('Apple'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
         ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}