import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnhancedUserSelectionScreen extends StatefulWidget {
  const EnhancedUserSelectionScreen({super.key});
  @override
  State<EnhancedUserSelectionScreen> createState() =>
      _EnhancedUserSelectionScreenState();
}
class _EnhancedUserSelectionScreenState
    extends State<EnhancedUserSelectionScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isDoctorSelected = false;
  bool _isPatientSelected = false;
  bool _isAdminSelected = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // Set system UI overlay style for a more immersive experience
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    // Initialize animation controller with slightly faster animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    // Define scale and fade animation with a smoother curve
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // Simulate navigation with loading
  Future<void> _navigateToLogin(String routeName, String role) async {
    setState(() {
      _isLoading = true;
      _isDoctorSelected = role == 'doctor';
      _isPatientSelected = role == 'patient';
      _isAdminSelected = role == 'admin';
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      Navigator.pushNamed(context, routeName);
      setState(() {
        _isLoading = false;
        _isDoctorSelected = false;
        _isPatientSelected = false;
        _isAdminSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Choose Your Role',
          style: TextStyle(
            fontSize: screenWidth * 0.04, // Dynamic font size
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3671E9),
                  Color(0xFF446BED),
                  Color(0xFF7B4AE2),
                ],
                stops: [0.1, 0.5, 0.9],
              ),
            ),
          ),
          // Subtle pattern overlay
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.02),
                ],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/subtle_pattern.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
          // Decorative elements
          Positioned(
            top: -screenWidth * 0.4,
            right: -screenWidth * 0.4,
            child: Container(
              height: screenWidth * 0.5,
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.04),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -screenWidth * 0.4,
            left: -screenWidth * 0.4,
            child: Container(
              height: screenWidth * 0.6,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
            ),
          ),
          // Floating particles effect
          ...List.generate(
            10,
                (index) => Positioned(
              top: screenHeight * 0.05 * (index % 5),
              left: screenWidth * 0.05 * (index % 7),
              child: Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  // Title and subtitle
                  FadeTransition(
                    opacity: _animation,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: Text(
                            'Select your role to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Role cards in a Column (stacked vertically)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Doctor card
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.2, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.1, 0.6,
                              curve: Curves.easeOutCubic),
                        )),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _controller,
                            curve:
                            const Interval(0.1, 0.6, curve: Curves.easeIn),
                          ),
                          child: _buildRoleCard(
                            title: 'Doctor',
                            iconData: Icons.medical_services_rounded,
                            description:
                            'Access patient records, manage appointments, and provide consultations',
                            imagePath: 'assets/img_1.png',
                            isSelected: _isDoctorSelected,
                            onTap: _isLoading
                                ? null
                                : () => _navigateToLogin('/doctor-login', 'doctor'),
                            gradientColors: const [
                              Color(0xFF4694FF),
                              Color(0xFF377AFE),
                            ],
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Patient card
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.2, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.3, 0.8,
                              curve: Curves.easeOutCubic),
                        )),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _controller,
                            curve:
                            const Interval(0.3, 0.8, curve: Curves.easeIn),
                          ),
                          child: _buildRoleCard(
                            title: 'Patient',
                            iconData: Icons.favorite_rounded,
                            description:
                            'Book appointments, access your medical records, and consult with healthcare professionals',
                            imagePath: 'assets/img_2.png',
                            isSelected: _isPatientSelected,
                            onTap: _isLoading
                                ? null
                                : () =>
                                _navigateToLogin('/patient-login', 'patient'),
                            gradientColors: const [
                              Color(0xFF8B65D9),
                              Color(0xFF7A4DCE),
                            ],
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Admin button (minimal version)
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.2, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.5, 1.0,
                              curve: Curves.easeOutCubic),
                        )),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _controller,
                            curve:
                            const Interval(0.5, 1.0, curve: Curves.easeIn),
                          ),
                          child: _buildMinimalAdminButton(
                            isSelected: _isAdminSelected,
                            onTap: _isLoading
                                ? null
                                : () => _navigateToLogin('/admin-login', 'admin'),
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Security badge
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            'Your health information is protected',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Standard role card widget for Doctor and Patient
  Widget _buildRoleCard({
    required String title,
    required IconData iconData,
    required String description,
    required String imagePath,
    required bool isSelected,
    required List<Color> gradientColors,
    VoidCallback? onTap,
    required double screenWidth,
    required double screenHeight,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.8,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
              Colors.white.withOpacity(0.22),
              Colors.white.withOpacity(0.12),
            ]
                : [
              Colors.white.withOpacity(0.16),
              Colors.white.withOpacity(0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.5)
                : Colors.white.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icon container
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                // Title and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.2,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            // Image container
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  child: Image.asset(
                    imagePath,
                    height: screenHeight * 0.12,
                    width: screenWidth * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            // Button
            Container(
              width: double.infinity,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  onTap: onTap,
                  splashColor: Colors.white.withOpacity(0.1),
                  highlightColor: Colors.white.withOpacity(0.05),
                  child: Center(
                    child: isSelected
                        ? SizedBox(
                      width: screenWidth * 0.04,
                      height: screenWidth * 0.04,
                      child: const CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Continue as $title',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.008),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Minimal admin button (no image, just text)
  Widget _buildMinimalAdminButton({
    required bool isSelected,
    VoidCallback? onTap,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      width: screenWidth * 0.4, // Much smaller width
      height: screenHeight * 0.040, // Smaller height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFF3671E9),
            Color(0xFF3671E9),
          ],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF24148C).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Center(
            child: isSelected
                ? SizedBox(
              width: screenWidth * 0.03,
              height: screenWidth * 0.03,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 1.5,
              ),
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue as Admin',
                  style: TextStyle(
                    fontSize: screenWidth * 0.025, // Smaller font
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Icon(
                  Icons.admin_panel_settings_rounded,
                  color: Colors.white,
                  size: screenWidth * 0.025, // Smaller icon
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}