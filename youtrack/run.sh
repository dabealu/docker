#!/bin/bash
java -Xmx1g -XX:MaxPermSize=250M -Djava.awt.headless=true \
-Djetbrains.youtrack.disableBrowser=true \
-Duser.home=/app \
-Ddatabase.location=/app/database \
-Ddatabase.backup.location=/app/backup \
-jar /app/youtrack.jar 80
