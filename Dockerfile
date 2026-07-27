FROM ubuntu:24.04

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONIOENCODING=utf-8 \
    SERVERHOST=0.0.0.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libzbar0 \
    libglib2.0-0 \
    libgl1 \
    libglx-mesa0 \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY sas_qr.AppImage .
RUN chmod +x sas_qr.AppImage

EXPOSE 8000

CMD ["./sas_qr.AppImage"]