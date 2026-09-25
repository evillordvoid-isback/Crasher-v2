# Dockerfile — static host for the Crasher V2 single-page app
FROM nginx:alpine

# drop the page in as the default index
COPY index.html /usr/share/nginx/html/index.html

# render gives us PORT at runtime — nginx needs to listen on it
# (render's default is 10000 for web services; adjust if it says otherwise)
ENV PORT=10000
RUN sed -i "s/listen       80;/listen       ${PORT};/" /etc/nginx/conf.d/default.conf \
 && sed -i "s/listen  \[::\]:80;/listen  [::]:${PORT};/" /etc/nginx/conf.d/default.conf

EXPOSE 10000

CMD ["nginx", "-g", "daemon off;"]
