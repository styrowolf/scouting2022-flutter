cd build/ios/iphoneos
rm -rf .
flutter build ios
mkdir Payload
mv Runner.app ./Payload/
ditto -c -k --sequesterRsrc --keepParent Payload Payload.zip
mv Payload.zip Payload.ipa
