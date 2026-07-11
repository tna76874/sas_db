FROM ubuntu:24.04

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONIOENCODING=utf-8 \
    SERVERHOST=0.0.0.0

RUN apt-get update && apt-get install -y \
    fuse3 \
    libglib2.0-0 \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY sas_qr.AppImage .
RUN chmod +x sas_qr.AppImage

EXPOSE 8000

CMD ["./sas_qr.AppImage"]