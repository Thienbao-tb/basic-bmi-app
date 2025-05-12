import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI Calculator" ,
      theme: ThemeData(
        primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto'
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerHeight  = TextEditingController();
  final TextEditingController controllerWeight  = TextEditingController();
  int selectedGender = -1;


  void  selectGender(int index) {
    setState(() {
      selectedGender = index;
    });
  }
  Color? getColor(isSelected,colorIsSelected) {
      if(isSelected) {
        if(colorIsSelected ==1) {
          return Colors.blue[400];
        }else if(colorIsSelected ==3) {
          return  Colors.pink[300];
        }else {
          return  Color(0xFFD1C4E9);
        }
      }else {
        return Colors.grey[300];
      }
  }

  Widget buildGenderBox(int index,String imgPath) {
    bool isSelected = selectedGender == index;
    int colorIsSelected = index;
    return GestureDetector(
      onTap:() => selectGender(index),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: getColor(isSelected,colorIsSelected),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child:
            SvgPicture.asset(
              imgPath,
              width: 24,
              height: 24,
              color: Colors.white,
            )
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      body: SingleChildScrollView (
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/bmi.png',
                            width: 150,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Gender",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B4DB),
                                fontSize: 16
                            ),
                          ),
                          Row(
                            children: [
                              buildGenderBox(1,'assets/images/venus.svg'),
                              buildGenderBox(2,'assets/images/genderless.svg'),
                              buildGenderBox(3,'assets/images/mars.svg'),
                            ],
                          ),
                          const Text("Age",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B4DB),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 6,),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerAge,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),

                          const Text("Height (m)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B4DB),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 6,),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerHeight,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),

                          const Text("Weight (kg)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B4DB),
                                fontSize: 14
                            ),
                          ),
                          const SizedBox(height: 6,),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerWeight,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration:const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50,),
                ElevatedButton(
                    onPressed: () {
                      if (controllerAge.text.isEmpty || controllerHeight.text.isEmpty || controllerWeight.text.isEmpty || selectedGender == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng nhập đủ thông tin!!!')),
                        );
                      } else {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResultPage(gender: selectedGender,age: controllerAge,height: controllerHeight,weight: controllerWeight,)),
                        );
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF00B4DB), Color(0xFF0083B0)]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 300,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child:  const Text("Calculate",style: TextStyle(color: Colors.white, fontSize: 16),),
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


//Result Page

class ResultPage extends StatelessWidget {
  final int gender;
  final TextEditingController age;
  final TextEditingController height;
  final TextEditingController weight;

  const ResultPage({
    super.key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight
  });
  int? get intAge => int.tryParse(age.text);
  double? get doubleHeight => double.tryParse(height.text);
  double? get doubleWeight => double.tryParse(weight.text);

  Map<String, dynamic> classifyBMI(double bmi) {
    if (bmi < 18.5) {
      return {
        'label': 'Underweight',
        'color': Colors.orangeAccent,
        'note': "You are underweight. Consider a balanced diet to reach a healthier weight.",
        'icon': Icons.warning
      };
    } else if (bmi < 25) {
      return {
        'label': 'Normal weight',
        'color': Colors.green, // Bình thường → xanh lá
        'note': "Great! Your weight is in the healthy range. Keep it up!",
        'icon': Icons.check
      };
    } else if (bmi < 30) {
      return {
        'label': 'Overweight',
        'color': Colors.yellow, // Thừa cân → vàng
        'note': "You are slightly overweight. Try to stay active and eat mindfully.",
        'icon': Icons.warning
      };
    } else if (bmi < 35) {
      return {
        'label': 'Obesity Class 1',
        'color': Colors.orange, // Béo phì độ 1 → cam
        'note' : "You are in Obesity Class 1. Consider adopting healthier habits soon.",
        'icon': Icons.warning
      };
    } else if (bmi < 40) {
      return {
        'label': 'Obesity Class 2',
        'color': Colors.deepOrange, // Béo phì độ 2 → cam đậm
        'note': "Obesity Class 2 detected. It's time to take action for your health.",
        'icon': Icons.warning
      };
    } else {
      return {
        'label': 'Obesity Class 3',
        'color': Colors.red, // Béo phì độ 3 → đỏ,
        "note": "Serious obesity risk. Seek professional advice for weight management",
        "icon": Icons.error
      };
    }
  }
  String genderToText(int gender) {
    if(gender == 1) {
      return "Male";
    }else if (gender==3) {
      return "Female";
    }else if(gender == 2){
      return "Other";
    }else {
      return "";
    }
  }
  @override
  Widget build(BuildContext context) {
    double bmi = (doubleWeight! / (doubleHeight! * doubleHeight!));
    Map<String,dynamic > status = classifyBMI(bmi);
    String genderText = genderToText(gender);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculate Result",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
            onPressed:() {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
                const Text("BMI Score",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 30,),
                Text(bmi.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 80,
                    color: status["color"],
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(status["label"],
                  style: TextStyle(
                      fontSize: 20,
                      color: status["color"],
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      children: [
                        Text("Gender:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
            
                          ),
                        ),
                        SizedBox(height: 14,),
                        Text("Age:",
                          style: TextStyle(
                            fontSize: 16,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 14,),
                        Text("Height:",
                          style: TextStyle(
                            fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 14,),
                        Text("Weight:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(genderText,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14,),
                        Text(intAge.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14,),
                        Text(doubleHeight.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14,),
                        Text(doubleWeight.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
            
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  color: status['color'][400],
                  child: Container(
                    width: double.infinity, // Card full width
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(status['icon'],color: Colors.white),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Text(status['note'],
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




