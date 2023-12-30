import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/result.dart';

const bgColor= Color(0xfffafafa);
class firstScreen extends StatefulWidget {
  
  
  const firstScreen({super.key});

  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  bool isScanCompleted= false;
  bool isFlashOn= false;
  bool isFrontCamera= false;
  MobileScannerController controller=MobileScannerController();
  
  void closeScreen(){
    isScanCompleted=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isFlashOn=!isFlashOn;
            });
           controller.toggleTorch();
          },
           icon: Icon(Icons.flash_on,color: isFlashOn ? Colors.blue : Colors.grey)),
           IconButton(onPressed: (){
            setState(() {
              isFrontCamera=!isFrontCamera;
            });
            controller.switchCamera();
           }, icon: Icon(Icons.photo_camera_front_outlined,color:isFrontCamera ? Colors.blue: Colors.white))
        ],
        iconTheme: IconThemeData(color: 
        Colors.black),
        centerTitle: true,
        title: const Text(
            "QR Scanner",
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1) ,
        )
      ),
       body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(" place the QR code in the area"),
                Text(" Scanning will be started automatically",
                style: TextStyle(
                  fontSize: 18
                ),
                )
              ],
              )
              ),
               Expanded(
              flex: 4,
              child:
              Stack(
                children: [
                  MobileScanner(
                    controller: controller,
              onDetect: (capture) {
            
               if(!isScanCompleted){
                List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                   String code= barcodes.first.rawValue ?? '---'; 
                       isScanCompleted=true;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen(closeScreen: closeScreen,code: code,)
                        )
               );
                }
               }
              }
              ),
       
              
              
                ],
              )
              ),
            //   Expanded(
            //   flex: 4,
            //   child: QRScannerOverlay(),
            // ),
              

      //       Expanded(
      //         flex: 4,
      //         child: MobileScanner(
      //         onDetect: (capture) {

      //          if(!isScanCompleted){String code= barcode.rawValue ?? '---';
      //          isScanCompleted=true;
      //          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultScreen())
      //          );
      //          }

      //          // final List<Barcode> barcodes = capture.barcodes;
      //     //final Uint8List? image = capture.image;
      //     //for (final barcode in barcodes) {
      //       //debugPrint('Barcode found! ${barcode.rawValue}');
      // //    }
      //         },
      //         ),
      //       ),
            Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text("Developed by Mee",style: TextStyle(
              fontSize: 14
            ),),
            
            )
            )
          ],
        ),
      ),
    );
  }
}


