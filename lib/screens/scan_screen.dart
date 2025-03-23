import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _showResults = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _analyzeDevice() {
    setState(() {
      _showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Device Scanner',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scanner Section
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 64,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Description Input
              const Text(
                'Enter Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Describe the device condition...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(height: 24),

              // Analyze Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _analyzeDevice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'ANALYZE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Results Section (only shown after clicking Analyze)
              if (_showResults)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.withOpacity(0.1))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Broken Mobile Screen Scan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Scan Result Section
                      _buildSectionTitle(
                          '🔍 Scan Result:', Colors.blue.shade700),
                      _buildBulletPoint(
                        'Device:',
                        'Samsung Galaxy S22 (Detected Model)',
                      ),
                      _buildBulletPoint(
                        'Issue:',
                        'Screen Cracked (Major/Minor Damage)',
                      ),
                      _buildBulletPoint(
                        'Lifespan Impact:',
                        'Reduced durability, risk of further damage',
                      ),
                      const SizedBox(height: 24),

                      // Maintenance Tips Section
                      _buildSectionTitle(
                          '🔧 Maintenance Tips:', Colors.green.shade700),
                      _buildBulletPoint(
                        '',
                        'Use a Temporary Screen Protector to prevent further cracks.',
                      ),
                      _buildBulletPoint(
                        '',
                        'Avoid Using Wet Fingers to prevent touch sensitivity issues.',
                      ),
                      _buildBulletPoint(
                        '',
                        'Lower Screen Brightness to reduce strain on damaged areas.',
                      ),
                      const SizedBox(height: 24),

                      // // Nearby Repair Shops
                      // _buildSectionTitle('📍 Find Nearby Repair Shops:',
                      //     Colors.orange.shade700),
                      // _buildBulletPoint('', 'ABC Mobile Repairs - 1.2 km'),
                      // _buildBulletPoint('', 'QuickFix Center - 2.5 km'),
                      // _buildBulletPoint('', 'BestMobile Care - 3.1 km'),
                      // const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.build_outlined),
                              label: const Text('BOOK REPAIR'),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.share_outlined),
                              label: const Text('SHARE REPORT'),
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side:
                                    const BorderSide(color: AppColors.primary),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  if (label.isNotEmpty)
                    TextSpan(
                      text: label + ' ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
