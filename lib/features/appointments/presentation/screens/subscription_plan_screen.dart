import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/programs/data/models/doctor_basic_info.dart';

class SubscriptionPlanScreen extends StatefulWidget {
    final String paymentUrl;
 final DoctorBasicInfo? doctor;
  const SubscriptionPlanScreen({super.key, required this.paymentUrl, this.doctor});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  String selectedPlan = 'monthly';

  final List<Map<String, dynamic>> plans = [
    {
      'id': 'monthly',
      'duration': 'اشتراك شهري',
      'price': 200,
      'originalPrice': 1000,
      'details': 'الاشتراك لمدة شهر واحد بخصم 80%',
      'savings': 'موفر معاك 800 جنيه من قيمة الاشتراك',
      'badge': 'الأكثر مبيعاً',
    },
    {
      'id': '3months',
      'duration': 'اشتراك 3 أشهر',
      'price': 500,
      'originalPrice': 3000,
      'details': 'الاشتراك لمدة 3 أشهر بخصم 83%',
      'savings': 'موفر معاك 2500 جنيه من قيمة الاشتراك',
    },
    {
      'id': '6months',
      'duration': 'اشتراك 6 أشهر',
      'price': 2000,
      'originalPrice': 9000,
      'details': 'الاشتراك لمدة 6 أشهر بخصم 77%',
      'savings': 'موفر معاك 7000 جنيه من قيمة الاشتراك',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
       appBar: AppBar(
        title: AlexText(text: "خطط الدفع"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
             
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      //'د. ${doctor?.firstName ?? ''} ${doctor?.lastName ?? ''}',
                      "تتوفر عدة خطط دفع للجلسات مع \nد.سلمى احمد قم باختيار الخطة التي تناسبك",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  
                    Text("",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Image.asset(
                      'assets/images/download 6.png',
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),

            // الباقات
            ...plans.map((plan) => _buildPlanCard(plan)),

            // الشروط والأحكام
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'بمجرد إتمام عملية الشراء، سيتم خصم قيمة الباقة...',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // فتح الشروط والأحكام
                    },
                    child: const Text(
                      'اقرأ شروط وأحكام إلغاء الاشتراك',
                      style: TextStyle(
                        color: AppColors.primaryColorLavenderLangAndText,
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // زر الموافقة والدفع
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _handlePaymentClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColorLavenderLangAndText,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'الموافقة و الدفع',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_back),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final isSelected = selectedPlan == plan['id'];

    return GestureDetector(
      onTap: () => setState(() => selectedPlan = plan['id']),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryColorLavenderLangAndText : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryColorLavenderLangAndText.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            // Badge
            if (plan['badge'] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 184, 183, 233),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('💎', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      plan['badge'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Radio Button
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.purple400 : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color:AppColors.primaryColorLavenderLangAndText,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
              
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              plan['duration'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'EGP ${plan['originalPrice']}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'EGP ${plan['price']}',
                                  style: const TextStyle(
                                    color: AppColors.primaryColorLavenderLangAndText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          plan['details'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            plan['savings'],
                            style: const TextStyle(
                              color: AppColors.purple900,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentClick() async {
    // احصل على البيانات المختارة
    final selectedPlanData = plans.firstWhere(
      (plan) => plan['id'] == selectedPlan,
    );

    // هنا تعملي API call للـ Backend
    // Backend يرجعلك paymentUrl
    
    // مثال (غيري ده بالـ API call الحقيقي):
    final paymentUrl = widget.paymentUrl;

    // روحي للـ WebView
    Navigator.pushNamed(
      context,
      Routes.paymentViewScreen,
      arguments: {
        'paymentUrl': paymentUrl,
        'amount': selectedPlanData['price'].toDouble(),
        'planName': selectedPlanData['duration'],
      },
    );
  }
}