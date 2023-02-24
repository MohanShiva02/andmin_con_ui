// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../provider_page.dart';
// import 'Account_Screen.dart';
// import 'preview_Screen.dart';
//
// class AddItem extends StatefulWidget {
//   const AddItem({Key? key}) : super(key: key);
//
//   @override
//   State<AddItem> createState() => _AddItemState();
// }
//
// class _AddItemState extends State<AddItem> {
//   final date = DateTime.now();
//   TextEditingController itermNameController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController vatController = TextEditingController();
//   TextEditingController fileName = TextEditingController();
//   TextEditingController quotNo = TextEditingController();
//   TextEditingController labAndInstall = TextEditingController();
//   TextEditingController advancePaid = TextEditingController();
//   List productName = [];
//   List productPrice = [];
//   List productQuantity = [];
//   List productVat = [];
//   late SharedPreferences logData;
//   String dropdownValue = 'QUOTATION';
//   String category = 'GA';
//   int advanceAmt = 0;
//   int labCharge = 0;
//   double subTotal = 0.0;
//   bool gstNeed = false;
//   bool labNeed = false;
//   final formKey = GlobalKey<FormState>();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Consumer<TaskData>(
//       builder: (context, taskData,child) {
//         // print("taskData.tasks ${taskData.tasks.length}");
//         final task = taskData.tasks.length == 2 ? taskData.tasks[1]: taskData.tasks[0];
//
//
//        return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xffF7F9FC),
//           elevation: 0,
//           title: Text(
//             "Add Items",
//             style: TextStyle(
//                 fontFamily: 'Nexa',
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//                 fontSize: height * 0.018),
//           ),
//           centerTitle: true,
//           leading:   GestureDetector(
//             child: Image.asset(
//               'assets/back arrow.png',
//               scale: 2.3,
//             ),
//             onTap: () {
//               setState(() {
//                 Navigator.pop(context);
//               });
//             },
//           ),
//           actions: [
//             GestureDetector(
//               child: Icon(
//                 Icons.account_circle_outlined,
//                 color: Colors.deepOrangeAccent,
//                 size: height * 0.03,
//               ),
//               onTap: () {
//                 setState(() {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AccountScreen()));
//                 });
//               },
//             ),
//             SizedBox(width: width*0.05,)
//
//           ],
//         ),
//         backgroundColor: Color(0xffF7F9FC),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: height * 0.90,
//                 color: Color(0xffF7F9FC),
//                 margin: EdgeInsets.symmetric(
//                     vertical: height * 0.01, horizontal: width * 0.05),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Date : ${DateFormat("dd.MM.yyyy").format(date)}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: height * 0.012,
//                             fontFamily: 'Nexa',
//                             color: Colors.black),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         width: width * 0.9,
//                         height: height * 0.04,
//                         decoration: BoxDecoration(
//                             color: Colors.deepOrangeAccent,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                           child: Text(
//                             'Products',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: height * 0.019,
//                                 fontFamily: 'Nexa',
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                         width: width * 0.9,
//                         height: height * 0.05,
//                         decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'To :   ${task.name}',
//
//                             ),
//
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         width: width * 0.9,
//                         height: height * 0.09,
//                         decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Add Item",style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: height * 0.012,
//                               fontFamily: 'Nexa',
//                             ),),
//                             IconButton(
//                               onPressed: () {
//                                 showAnotherAlertDialog(context,height,width);
//                               },
//                               icon: Image.asset(
//                                 'assets/add.png',
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                         width: width * 0.9,
//                         height: height * 0.08,
//                         decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.1),
//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               width: width * 0.15,
//                               child: TextFormField(
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: height * 0.012,
//                                   fontFamily: 'Avenir',
//                                 ),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: ' Name',
//                                   hintStyle: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: height * 0.012,
//                                     fontFamily: 'Nexa',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             VerticalDivider(
//                               color: Colors.black.withOpacity(0.4),
//                               endIndent: 25,
//                               indent: 25,
//                               thickness: 3,
//                             ),
//                             SizedBox(
//                               width: width * 0.16,
//                               child: TextFormField(
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: height * 0.012,
//                                   fontFamily: 'Avenir',
//                                 ),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Quantity',
//                                   hintStyle: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: height * 0.012,
//                                     fontFamily: 'Nexa',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             VerticalDivider(
//                               color: Colors.black.withOpacity(0.4),
//                               endIndent: 25,
//                               indent: 25,
//                               thickness: 3,
//                             ),
//                             SizedBox(
//                               width: width * 0.12,
//                               child: TextFormField(
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: height * 0.012,
//                                   fontFamily: 'Avenir',
//                                 ),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Rate',
//                                   hintStyle: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: height * 0.012,
//                                     fontFamily: 'Nexa',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: height * 0.18,
//                         width: width * 0.9,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.1),
//                           borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight:Radius.circular(20.0) ),
//                         ),
//                         child:ListView.builder(
//                           // shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemCount: productName.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return GestureDetector(
//                               onTap: (){
//                                 showDeleteDialog(context,index);
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                                 child: Table(
//                                   // border: TableBorder.all(),
//                                   children: [
//                                     buildRow([
//                                       '${productName[index]}','${productQuantity[index]}','${productPrice[index]}',]),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                         height: height * 0.27,
//                         width: width * 0.9,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                    Text("Doc-Type",style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),),
//                                   DropdownButton<String>(
//                                     value: dropdownValue,
//                                     icon: const Icon(Icons.arrow_downward),
//                                     elevation: 16,
//                                     style: const TextStyle(color: Colors.black),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         dropdownValue = newValue!;
//                                       });
//                                     },
//                                     items: <String>['QUOTATION','INVOICE']
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                    Text("Category",style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),),
//                                   DropdownButton<String>(
//                                     value: category,
//                                     icon: const Icon(Icons.arrow_downward),
//                                     elevation: 16,
//                                     style: const TextStyle(color: Colors.black),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         category = newValue!;
//                                       });
//                                     },
//                                     items: <String>['GA','SH','IT','DL','SS','WTA','AG']
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                    Text("GST Need : ",style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),),
//                                   Checkbox(
//                                       value: gstNeed,
//                                       onChanged: (val){
//                                         setState((){
//                                           gstNeed = val!;
//                                         });
//                                       }
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("Labour Need : ",style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),),
//                                   Checkbox(
//                                       value: labNeed,
//                                       onChanged: (val){
//                                         setState((){
//                                           labNeed = val!;
//                                         });
//                                       }
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   ((dropdownValue=="INVOICE")||(labNeed))? Text("Labour and installation",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),):const Text(""),
//                                   ((dropdownValue=="INVOICE")||(labNeed))? Container(
//                                     width: width*0.40,
//                                     child: TextFormField(
//                                       onChanged: (val){
//                                         if(val.isNotEmpty)
//                                           {
//                                             setState((){
//                                               labCharge = int.parse(val);
//                                             });
//                                           }
//                                       },
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: height * 0.012,
//                                         fontFamily: 'Avenir',
//                                       ),
//                                       keyboardType: TextInputType.number,
//                                       decoration: const InputDecoration(
//                                         hintText: ' Labour charge',
//                                         border: InputBorder.none,
//                                         hintStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                           fontFamily: 'Nexa',),
//                                       ),
//                                       controller: labAndInstall,
//                                     ),
//                                   ):const Text(""),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   dropdownValue=="INVOICE"? Text("Advance Amount",style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: height * 0.012,
//                                       fontFamily: 'Nexa',
//                                       color: Colors.black),):const Text(""),
//                                   dropdownValue=="INVOICE"? Container(
//                                     width: width*0.40,
//                                     child: TextFormField(
//                                               onChanged: (val){
//                                                 if(val.isNotEmpty)
//                                                 {
//                                                   setState(() {
//                                                     advanceAmt = int.parse(val);
//                                                   });
//                                                 }
//                                               },
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: height * 0.012,
//                                                   fontFamily: 'Avenir',
//                                                 ),
//                                               keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 hintText: ' Advance Paid',
//                                                 border: InputBorder.none,
//                                                 hintStyle: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 12,
//                                                   fontFamily: 'Nexa',),
//                                                 ),
//                                               controller: advancePaid,
//                                     ),
//                                   ):const Text(""),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: height * 0.03,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       SizedBox(
//                         width: width * 0.9,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                  setState(() {
//                                    if(productName.isEmpty){
//                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                                        backgroundColor: Colors.red,
//                                          content: Text('Please select product'),
//                                    duration: Duration(seconds: 1),));
//                                    }else{
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => PreviewScreen(doctype: dropdownValue,
//                                                category: category,advanceAmt: advanceAmt,labAndInstall: labCharge,
//                                               gstValue: gstNeed, labValue: labNeed,
//                                              ))).then((value){
//                                                setState(() {
//                                                  labAndInstall.clear();
//                                                  advancePaid.clear();
//                                                  advanceAmt = 0;
//                                                  labCharge = 0;
//                                                });
//                                              });
//                                    }
//                                  });
//                               },
//                               child: Container(
//                                 width: width * 0.28,
//                                 height: height * 0.05,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFF7E44),
//                                   borderRadius: BorderRadius.circular(15),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.black.withOpacity(0.3),
//                                         offset: const Offset(8, 8),
//                                         blurRadius: 10,
//                                         spreadRadius: 0)
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Next",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: height * 0.013,
//                                         fontFamily: 'Nexa',
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//       }
//     );
//   }
//
//   TableRow buildRow(List<String> cells,{bool isHeader = false}) => TableRow(
//     children: cells.map(
//           (cell) {
//         final style =TextStyle(
//           fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
//         );
//         return Padding(
//           padding: const EdgeInsets.all(10),
//           child: Center(
//             child: Text(cell,style: style,),
//           ),
//         );
//       },
//     ).toList(),
//   );
//
//
//   showDeleteDialog(BuildContext context,int index){
//     Widget okButton = TextButton(
//       child: const Text(" ok "),
//       onPressed: () {
//         setState((){
//           productName.removeAt(index);
//           productQuantity.removeAt(index);
//           productVat.removeAt(index);
//           productPrice.removeAt(index);
//           Provider.of<TaskData>(context,listen: false).deleteTask(index);
//           Provider.of<TaskData>(context,listen: false).clearSubtotal(index);
//           Navigator.pop(context, false);
//         });
//       },
//     );
//     Widget cancelButton = TextButton(
//       child: const Text(" Cancel "),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     // Create AlertDialog
//     AlertDialog alert = AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       content: const Text("Do you want to delete ?"),
//       actions: [
//         cancelButton,
//         okButton,
//       ],
//     );
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//
//   showAnotherAlertDialog(BuildContext context,height,width) {
//     // Create button
//     Widget okButton = TextButton(
//       child: const Text(" ok "),
//       onPressed: () {
//         if(formKey.currentState!.validate()){
//           setState((){
//             productName.add(itermNameController.text);
//             productPrice.add(priceController.text);
//             productQuantity.add(quantityController.text);
//             productVat.add(vatController.text);
//           });
//           Provider.of<TaskData>(context,listen: false).addInvoiceListData(itermNameController.text,int.parse(quantityController.text), double.parse(priceController.text));
//           Provider.of<TaskData>(context,listen: false).addSubTotal(int.parse(quantityController.text),double.parse(priceController.text));
//           Navigator.pop(context, false);
//           itermNameController.clear();
//           priceController.clear();
//           quantityController.clear();
//           vatController.clear();
//         }
//       },
//     );
//     Widget cancelButton = TextButton(
//       child: const Text(" Cancel "),
//       onPressed: () {
//         Navigator.pop(context, false);
//       },
//     );
//     // Create AlertDialog
//     AlertDialog alert = AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       title: const Text(
//         "  Data entry ",
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       ),
//       content: Form(
//         key: formKey,
//         child: Container(
//           height: height*0.40,
//           width: width*1.0,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   child: TextFormField(
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Product name';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(hintText: 'Product name'),
//                     controller: itermNameController,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   child: TextFormField(
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter quantity';
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(hintText: 'quantity'),
//                     controller: quantityController,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   child: TextFormField(
//                     textInputAction: TextInputAction.done,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter amount';
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(hintText: 'amount'),
//                     controller: priceController,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         cancelButton,
//         okButton,
//       ],
//     );
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
