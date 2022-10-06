FROM debian:buster-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
	make curl ca-certificates file appstream
ENV APPIMAGE_EXTRACT_AND_RUN=1
