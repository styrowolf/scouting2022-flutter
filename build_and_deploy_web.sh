cd ~/development/flutter/rapid_react_scouting/
flutter build web --base-href /static/
rm -rf ~/development/backends/rapid_react_scouting/static
mv build/web/* ~/development/backends/rapid_react_scouting/static
cd ~/development/backends/rapid_react_scouting/static
git add *
git commit -m "new version of flutter web app deployed"
git push heroku master