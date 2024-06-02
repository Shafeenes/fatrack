// import "package:flutter/material.dart";

// class LoginCard {

//   <div _ngcontent-aop-c147="" class="w-full surface-card py-8 px-5 sm:px-8" style="border-radius: 53px;"><div _ngcontent-aop-c147="" class="text-center mb-5">
//   <span _ngcontent-aop-c147="" class="pi pi-user" style="font-size: 2.5rem; font-weight: bolder; color: var(--primary-color);"></span>
//   <img _ngcontent-aop-c147="" ngclass="p-component p-avatar-circle p-avatar-xl" alt="Image" height="50" class="mb-3 hidden p-component p-avatar-circle p-avatar-xl" src="assets/system/images/avatar/default.png">
//   <div _ngcontent-aop-c147="" class="text-900 text-3xl font-medium mb-3">Welcome to Flora Support System Portal</div><span _ngcontent-aop-c147="" class="text-600 font-medium">Sign in to continue</span></div><div _ngcontent-aop-c147="">
//   <div _ngcontent-aop-c147="" class="input-containter"><span _ngcontent-aop-c147="" class="block text-700 text-l font-medium mb-2" style="color: red !important;"> &nbsp; </span><br _ngcontent-aop-c147=""><div _ngcontent-aop-c147="" class="block text-900 text-xl font-medium mb-2 email1Div"><label _ngcontent-aop-c147="" for="email1" id="email1Label" title="Enter your Domain / LDAP Username" class="email1Label" style="opacity: 1;">Username (Domain / LDAP Username)</label></div><input _ngcontent-aop-c147="" id="email1" placeholder=" " type="email" pinputtext="" autofocus="true" class="p-inputtext p-component p-element w-full mb-5 email1 loginInput ng-pristine ng-valid ng-touched"></div><label _ngcontent-aop-c147="" class="block text-700 text-l font-medium mb-2" style="color: red !important;"> &nbsp; </label><div _ngcontent-aop-c147="" class="input-containter"><div _ngcontent-aop-c147="" class="block text-900 font-medium text-xl mb-2"><label _ngcontent-aop-c147="" for="password1" class="password1Label">Password</label></div><p-password _ngcontent-aop-c147="" inputid="password1" placeholder=" " styleclass="w-full mb-5 " inputstyleclass="w-full p-3 loginInput" class="p-element p-inputwrapper ng-tns-c104-0 p-password-mask ng-untouched ng-pristine ng-valid ng-star-inserted"><div class="ng-tns-c104-0 w-full mb-5 p-password p-component p-inputwrapper p-input-icon-right"><input pinputtext="" class="p-inputtext p-component p-element ng-tns-c104-0 w-full p-3 loginInput p-password-input" id="password1" type="password" placeholder=" " style="border-top:none !important; border-left:none !important;border-right:none !important; border-radius:0 !important;box-shadow: none !important;"><!----><i class="ng-tns-c104-0 pi pi-eye ng-star-inserted"></i><!----><!----></div></p-password><span _ngcontent-aop-c147="" class="block text-700 text-l font-medium mb-2" style="color: red !important;"> &nbsp; </span></div><div _ngcontent-aop-c147="" class="flex align-items-center justify-content-between mb-5 gap-5"><!----><!----></div><button _ngcontent-aop-c147="" pbutton="" pripple="" label="Sign In" icon="pi pi-sign-in" class="p-element w-full p-3 text-xl p-button p-component" tabindex="0"><span class="p-button-icon p-button-icon-left pi pi-sign-in" aria-hidden="true"></span><span class="p-button-label">Sign In</span></button></div></div>


//   void _changePassword() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _changeUsername() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     TextEditingController _usernameController = TextEditingController();
//     TextEditingController _passwordController = TextEditingController();
//     return Column(children:[
//       Container(decoration: BoxDecoration(border:Border.all(), borderRadius: BorderRadius.circular(53)), children:Padding(padding:EdgeInsets.symmetric(vertical: 16, horizontal: 20,)
//       child: Column(children: [
//         Container(margin: EdgeInsets.only(bottom:height * 0.0206985,
//           height:height * 0.021875,
//           width:height * 0.021875,
//         ),child: [AssetImage("user.png")],),
//         Container(margin:EdgeInsets.only(bottom: height * 0.0206985, child:[Text("Welcome to flora support system portal")]),),
//         Container(margin:EdgeInsets.only(bottom: height * 0.0206985 * 2, child:[Text("Sign into continue")]),
//         Container(children:[TextFormField(
//                   decoration: InputDecoration(,
//                     label: Text("Username (Domain / LDAP Username)"),
//                     contentPadding: EdgeInsetsDirectional.all(5.0),
//                     focusedBorder: InputBorder(
//                       borderSide: BorderSide(
//                         color: Color.fromRGBO(99, 102, 241, 1),
//                         // borderRadius: BorderRadius.circular(8.5)),
//                       ),
//                     ),
//                   ),
//                 ),]),
//         Container(children:[TextFormField(
//           obscureText: true,
//                   decoration: InputDecoration(,
//                     label: Text("Password"),
//                     contentPadding: EdgeInsetsDirectional.all(5.0),
//                     focusedBorder: InputBorder(
//                       borderSide: BorderSide(
//                         color: Color.fromRGBO(99, 102, 241, 1),
//                         // borderRadius: BorderRadius.circular(8.5)),
//                       ),
//                     ),
//                   ),
//                 ),])
//                 ),
//     ],),),)]);
//   }

// }
