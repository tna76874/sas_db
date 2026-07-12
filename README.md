# SAS QR App

Dieses Repository enthält die automatisierten Builds und Docker-Konfigurationen für das SAS QR-Projekt.

## 📥 Downloads (Latest Release)

Hier findest du die direkt ausführbaren Binaries der aktuellsten Version:

- **Windows (.exe)**  
  https://github.com/tna76874/sas_db/releases/download/latest/sas_qr.exe

- **Linux (AppImage)**  
  https://github.com/tna76874/sas_db/releases/download/latest/sas_qr.AppImage

---

## 🐧 Hinweis für Linux-Nutzer

Damit die AppImage-Datei Barcodes und QR-Codes korrekt verarbeiten kann, wird die Systembibliothek **zbar** benötigt. Falls das Programm nicht startet oder Fehler wirft, installiere sie über deinen Paketmanager.

### Ubuntu / Debian / Linux Mint

```bash
sudo apt update
sudo apt install -y libzbar0
```

---

# 🐋 Container Deployment

Du kannst die Anwendung auch direkt als Container ausführen. Die Datenbank wird dabei lokal im Ordner `./data` persistent gespeichert.

## Option 1: Docker Compose

Stelle sicher, dass das Verzeichnis `./data` existiert und starte anschließend den Stack:

```bash
mkdir -p data
docker compose up -d
```

---

## Option 2: Podman Compose

Wenn du ein rootless Setup mit Podman bevorzugst, kannst du dieselbe Compose-Datei nahezu unverändert verwenden.

> **Hinweis:** Podman verwendet standardmäßig strengere Volume-Berechtigungen (SELinux und User Namespaces). Verwende deshalb `:Z` am Volume oder stelle sicher, dass die Berechtigungen des lokalen Ordners entsprechend gesetzt sind.

```bash
mkdir -p data
podman-compose up -d
```

---

## Podman ohne Compose

Alternativ kannst du den Container direkt mit der Podman-CLI starten:

```bash
podman run -d \
  --name sas_qr_app \
  -p 8000:8000 \
  -v ./data:/app/data:Z \
  --restart unless-stopped \
  ghcr.io/tna76874/sas_db:latest
```

---

## 📂 Persistente Daten

Alle Anwendungsdaten werden im lokalen Verzeichnis gespeichert:

```text
./data
```

Dadurch bleibt die Datenbank auch nach Container-Updates oder Neustarts erhalten.

---

## 🚀 Aktualisieren

### Docker Compose

```bash
docker compose pull
docker compose up -d
```

### Podman Compose

```bash
podman-compose pull
podman-compose up -d
```

### Podman

```bash
podman pull ghcr.io/tna76874/sas_db:latest

podman stop sas_qr_app
podman rm sas_qr_app

podman run -d \
  --name sas_qr_app \
  -p 8000:8000 \
  -v ./data:/app/data:Z \
  --restart unless-stopped \
  ghcr.io/tna76874/sas_db:latest
```

