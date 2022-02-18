cd ~/development/flutter/rapid_react_scouting/
flutter build web --web-renderer=html
rm -rf ~/development/backends/rapid_react_scouting/static/*
cp -R build/web/* ~/development/backends/rapid_react_scouting/static
cd ~/development/backends/rapid_react_scouting
git add *
git commit -m "new version of flutter web app deployed"
git push heroku master