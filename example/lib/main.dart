import 'package:flutter/material.dart';
import 'package:idkit_toast/idkit_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("消息展示"),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("展示消息"),
          onPressed: () {
            // IDKitToast.showText(context, content: "我是谁,谁是我");
            // IDKitToast.showText(context,
            //     content: "我是谁,谁是我11",
            //     style: ToastStyle(
            //       alignment: ToastAlignment.top,
            //     ));

            // IDKitToast.showRichText(
            //   context,
            //   AssetImage(
            //     "test.jpg",
            //   ),
            //   content: "大美女一枚",
            // );
            // IDKitToast.showRichText(
            //   context,
            //   AssetImage(
            //     "test.jpg",
            //   ),
            //   // content: "大美女一枚",
            //   imageSize: Size(100, 100),
            // );

            // IDKitToast.showCustom(
            //     context,
            //     Container(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [Icon(Icons.ac_unit), Text("我市自定义显示")],
            //       ),
            //     ),
            //     style: ToastStyle(
            //       alignment: ToastAlignment.bottom,
            //     ));

            // IDKitToast.loading(context,
            //     style: ToastStyle(
            //       bgColor: Colors.red,
            //       maskColor: Colors.green,
            //     ));

            // Future.delayed(Duration(seconds: 5), () {
            //   IDKitToast.dismiss();
            // });

            IDKitToast.loadingCustom(
                context, Image(image: AssetImage("load.gif")));
            Future.delayed(Duration(seconds: 5), () {
              IDKitToast.dismiss();
            });
          },
        ),
      ),
    );
  }
}
