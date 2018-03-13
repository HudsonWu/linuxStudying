#!/bin/bash
cd /home/ParallelConsultingPro && pm2 start server.js
cd /home/ParallelApiForSails  && pm2 start app.js
cd /home/ParallelBackendPro && pm2 start server.js
cd /home/MemberCenterForSails && pm2 start app.js
# cd /home/ParallelPortalForSails && pm2 start app.js
cd /home/ParallelExpertPro && pm2 start server.js
# cd /home/ParallelParkPro && pm2 start server.js
cd /home/ParallelOwnerPro && pm2 start server.js
# cd /home/ParallelConsultationForVue && npm run dev && cd /home/ParallelOwnerForVue && npm run dev
cd /home/ParallelForPhp && php artisan queue:work redis --sleep=3 --tries=3 &
