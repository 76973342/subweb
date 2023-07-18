#/bin/sh
if [ ! -f /usr/share/nginx/html/conf/config.js ]; then
  cp /app/public/conf/config.js /usr/share/nginx/html/conf
fi

if [ $API_URL ]; then
  echo "当前 API 地址为: $API_URL"
  sed -i "s#http://sub.jacky.lyd#$API_URL#g" /usr/share/nginx/html/conf/config.js
else
  echo "当前为默认本地 API 地址: http://sub.jacky.ltd"
  echo "如需修改请在容器启动时使用 -e API_URL='https://sub.ops.ci' 传递环境变量"
fi

if [ $SHORT_URL ]; then
  echo "当前短链接地址为: $API_URL"
  sed -i "s#https://s.ops.ci#$SHORT_URL#g" /usr/share/nginx/html/conf/config.js
fi

if [ $SITE_NAME ]; then
  sed -i "s#Subconverter Web#$SITE_NAME#g" /usr/share/nginx/html/conf/config.js
fi

nginx -g "daemon off;"
