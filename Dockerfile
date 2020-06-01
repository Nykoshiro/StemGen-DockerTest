#FROM  axeldelafosse/stemgen
FROM lsiobase/alpine:3.11

RUN \
echo "**** compile chromaprint ****" && \
 git clone https://github.com/axeldelafosse/stemgen.git \
	/tmp/stemgen && \
 cd /tmp/stemgen && \
 cmake \
	-DBUILD_TOOLS=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr && \
 make && \
 make install && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# environment settings
ENV STEMGENDIR="/config" \
EDITOR="nano" \
HOME="/config"

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8337
VOLUME /config /downloads /music /output
