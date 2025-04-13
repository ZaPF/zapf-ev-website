FROM alpine:3.19.1 as bobthebuilder
RUN apk add hugo git imagemagick rsvg-convert make py3-docutils
ADD . /build
WORKDIR /build
RUN mkdir -p /tmp
RUN make

FROM nginx:alpine
COPY --from=bobthebuilder /build/public /usr/share/nginx/html/
