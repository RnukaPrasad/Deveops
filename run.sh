#!/bin/sh
export workspace_build=$workspace_build
export workspace_nginx=$workspace_nginx
export data_integration_nginx=$dataintegration_nginx
export index_env=$index_env
sed -i "s|https://cloud.msa2.apps.yokogawa.build/app-yib-workspace/yibpoc/remoteEntry.js|$workspace_build|" /usr/share/nginx/html/main.*.js
sed -i "s|app-yib-host/yibpoc/|$index_env|" /usr/share/nginx/html/index.html
sed -i "s|https://cloud.msa2.apps.yokogawa.build/app-yib-workspace/yibpoc/assets/workspace/|$workspace_nginx|g" /etc/nginx/conf.d/default.conf
sed -i "s|https://cloud.msa2.apps.yokogawa.build/app-yib-data-integration/yibpoc/assets/data-integration/|$data_integration_nginx|g" /etc/nginx/conf.d/default.conf
envsubst < /usr/share/nginx/html/assets/js/env.template.js > /usr/share/nginx/html/assets/js/env.js
nginx -g 'daemon off;'
