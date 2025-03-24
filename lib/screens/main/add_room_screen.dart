import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _roomImage;
  int _numberOfAppliances = 5;
  List<Map<String, dynamic>> _appliances = [];

  @override
  void initState() {
    super.initState();
    // Initialize appliances list with empty maps
    _appliances = List.generate(
      _numberOfAppliances,
      (index) => {
        'name': '',
        'type': '',
        'powerRating': '',
        'dailyUsage': '',
        'isSmart': false,
        'notes': '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Room'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload Section
              GestureDetector(
                onTap: () {
                  // TODO: Implement image picker
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: Colors.blue[400],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Upload Your Room Picture for Better Experience',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Supported formats: JPEG, PNG, GIF',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Room Details Section
              const Text(
                'Room Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Room Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Name',
                  hintText: 'What is the name of the room?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Room Type
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  hintText:
                      'What type of room is it? (eg. Bedroom, bathroom, kitchen, etc)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Room Size
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Size',
                  hintText: 'What is the approximate size of the room?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Room Location
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Room Location',
                  hintText: 'Where is the room located?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Appliances Section
              const Text(
                'Appliances Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Number of Appliances
              TextFormField(
                initialValue: '5',
                decoration: const InputDecoration(
                  labelText: 'Number of Appliances Detected',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 24),

              // Appliances List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _numberOfAppliances,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appliance no.${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Appliance Name
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Appliance Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _appliances[index]['name'] = value;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Appliance Type and Power Rating Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Appliance Type',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                _appliances[index]['type'] = value;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Power Rating (in watts)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _appliances[index]['powerRating'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Daily Usage and Smart Appliance Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Daily Usage',
                                hintText: 'optional',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                _appliances[index]['dailyUsage'] = value;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<bool>(
                              decoration: const InputDecoration(
                                labelText: 'Smart Appliance (y/n)',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: true,
                                  child: Text('Yes'),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text('No'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _appliances[index]['isSmart'] = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Additional Notes
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Additional Notes (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        onChanged: (value) {
                          _appliances[index]['notes'] = value;
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Handle form submission
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
