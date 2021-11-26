/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  Text,
  View,
  Button,
  Alert,
  NativeModules,
} from 'react-native';

const App = () => {
  return (
    <SafeAreaView style={[styles.container, {
      // Try setting `flexDirection` to `"row"`.
      flexDirection: "column"
    }]}>
      <View style={{ flex: 1, backgroundColor: "blue", justifyContent: "center"}}>
        <Text style={{ textAlign: "center", color: "white", fontSize: 16,}}>RMS Example APP</Text>
      </View>
      <View style={{ flex: 10, backgroundColor: "white", justifyContent: "center" }}>
        <Button
          onPress={() => {
            // alert('You tapped the button!');
            console.log(NativeModules.RMSXdkPaymentModule);
            var paymentDetails = {
              // Mandatory String. A value more than '1.00'
              'mp_amount': '1.10',

              // Mandatory String. Values obtained from MOLPay
              'mp_username': '',
              'mp_password': '',
              'mp_merchant_ID': '',
              'mp_app_name': '',
              'mp_verification_key': '',

              // Mandatory String. Payment values
              'mp_order_ID': '1528478556',
              'mp_currency': 'MYR',
              'mp_country': 'MY',

              // Optional String.
              'mp_channel': 'multi',
              'mp_bill_description': 'description',
              'mp_bill_name': 'biller name',
              'mp_bill_email': 'example@gmail.com',
              'mp_bill_mobile': '+60123456789',

              // Enabled Sandbox account
              'mp_dev_mode': true,
            };
            NativeModules.RMSXdkPaymentModule.startPaymentEvent(paymentDetails,
              (result) => {
                console.log(`Result ${result}`);
                Alert.alert(
                  'Result',
                  `${JSON.stringify(result)}`,
                  [
                    { text: "OK", onPress: () => console.log("OK Pressed") }
                  ]
                );
              }
            );
          }}
          title="Start XDK"
        />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
