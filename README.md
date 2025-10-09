# Arch Linux WSL – MRR Group Developer RootFS

A minimal **Arch Linux RootFS for WSL 2**, prepared by [MRR Group](https://github.com/MRR-Group) as a base image for local development.

It ships with a standard Arch base system plus pre-configured **Docker Engine**.

> The RootFS is automatically rebuilt on the **1st of every month at 07:24 UTC**.

---

## ⚠️ Important Notes

1. This is a **clean Arch Linux** image with basic CLI tools, Docker and FRP pre-installed for development use.  
2. **WSL 2 only** – WSL 1 is not supported.  
3. Before installing, we recommend reviewing the [official Arch Linux on WSL guide](https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL).  
4. The image is intended as a **pre-configured developer-ready baseline for MRR Group projects** and includes a default Docker setup.

---

## 📦 Download

Grab the latest build from the [**Releases**](../../releases/latest) page — download the `archlinux.wsl` file.

---

## 🚀 Installation

### On WSL ≥ 2.4.4
```powershell
wsl --install --from-file /path/to/archlinux.wsl
```

### On older WSL
```powershell
wsl --import Arch-Dev C:\WSL\Arch-Dev .\archlinux.wsl
```

## 💡 Install on a Different Drive

```powershell
wsl --import Arch-Dev E:\WSL\Arch D:\Downloads\archlinux.wsl
```

- `Arch-Dev` – the name under which the distro will appear in `wsl --list`.  
- `E:\WSL\Arch` – the folder where WSL will store the filesystem.  
- `D:\Downloads\archlinux.wsl` – path to your downloaded RootFS file.

## 🟢 First-Run OOBE
1. Create your UNIX user account.
2. systemd is enabled and Docker initialized.
3. `mmr-gen-frpc` generates your basic FRP config (~/frpc.toml).
4. `frpc.service` is enabled (user-level) to start automatically.

## ➕ Adding Extra Domains
Expose another local port over FRP:
```bash
mmr-add-domain <name> <localPort>
# e.g. mmr-add-domain app 5173
```
This appends a new `[[proxies]]` block to `~/frpc.toml` and restarts the client.
