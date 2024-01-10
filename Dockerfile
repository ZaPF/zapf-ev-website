FROM alpine as bobthebuilder
RUN apk add hugo git imagemagick make py3-docutils
ADD . /build
WORKDIR /build
RUN mkdir -p /tmp
RUN make

FROM nginx:alpine
COPY --from=bobthebuilder /build/public /usr/share/nginx/html/
