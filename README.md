# ⚡ Linux Automation Toolkit

> Automated disk monitoring, service recovery, log rotation, and alerting framework for Linux servers using pure Bash and Cron.

<p align="center">

![Linux](https://img.shields.io/badge/platform-Linux-blue?style=for-the-badge\&logo=linux)
![Bash](https://img.shields.io/badge/shell-Bash-green?style=for-the-badge\&logo=gnubash)
![Cron](https://img.shields.io/badge/scheduler-Cron-orange?style=for-the-badge)
![Automation](https://img.shields.io/badge/type-Server%20Automation-red?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-black?style=for-the-badge)

</p>

---

# 📚 Table of Contents

* [Overview](#-overview)
* [The Problem This Solves](#-the-problem-this-solves)
* [Architecture](#-architecture)
* [Features](#-features)
* [Tech Stack](#-tech-stack)
* [Project Structure](#-project-structure)
* [Configuration](#-configuration)
* [Installation](#-installation)
* [Cron Scheduling](#-cron-scheduling)
* [Deployment Guide](#-deployment-guide)
* [Testing the Toolkit](#-testing-the-toolkit)
* [Monitoring & Alerts](#-monitoring--alerts)
* [Troubleshooting](#-troubleshooting)
* [Sample Outputs](#-sample-outputs)
* [Lessons Learned](#-lessons-learned)
* [Future Improvements](#-future-improvements)
* [License](#-license)

---

# 🌍 Overview

Linux Automation Toolkit is a production-ready Bash automation framework designed to solve the most common Linux server maintenance problems automatically.

Instead of waiting for servers to fail silently, this toolkit continuously:

✅ Monitors disk usage
✅ Restarts failed services
✅ Rotates and compresses logs
✅ Sends alerts automatically
✅ Maintains structured audit logs
✅ Runs entirely on cron schedules

It acts as a lightweight server hygiene layer for Linux environments without requiring Kubernetes, heavy monitoring stacks, or external SaaS tooling.

Built for:

* Linux administrators
* DevOps learners
* Infrastructure engineers
* Self-hosted server environments
* VPS monitoring
* WSL environments
* Home lab automation

---

# ❌ The Problem This Solves

Most Linux servers fail for predictable reasons:

| Problem                     | Impact                        | Solution                      |
| --------------------------- | ----------------------------- | ----------------------------- |
| Disk usage reaches 100%     | Services crash unexpectedly   | Automated disk monitoring     |
| Services die silently       | Downtime until manual restart | Auto-restart service recovery |
| Logs grow endlessly         | Storage exhaustion            | Automated log rotation        |
| No centralized alerts       | Problems discovered too late  | Email alerting system         |
| Repeated manual maintenance | Operational overhead          | Cron-based automation         |
| Scattered configurations    | Hard to maintain scripts      | Centralized `config.sh`       |

---

# 🏗️ Architecture

<img width="3200" height="2000" alt="image" src="https://github.com/user-attachments/assets/5bb451e2-f139-405d-9b31-876d63610119" />


# ✨ Features

## ✅ Disk Usage Monitoring

* Configurable disk usage threshold
* Alerts before storage reaches critical levels
* WSL-aware partition filtering
* Detects dangerous storage growth early

---

## ✅ Automatic Service Recovery

Monitors Linux services continuously and automatically restarts them if they crash.

Example monitored services:

```bash
nginx
mysql
ssh
redis
postgresql
```

---

## ✅ Log Rotation & Cleanup

Automatically:

* Compresses old logs
* Deletes stale archives
* Prevents `/var/log` from consuming all storage

---

## ✅ Centralized Alerting

All scripts route alerts through:

```bash
send_alert.sh
```

Benefits:

* Single alert pipeline
* Easier maintenance
* Future Slack/webhook integrations
* Cleaner architecture

---

## ✅ Structured Logging

Every event is written to:

```bash
toolkit.log
```

Provides:

* Full audit trail
* Easier debugging
* Historical monitoring visibility

---

## ✅ Zero Heavy Dependencies

No need for:

* Kubernetes
* Prometheus
* Grafana
* Cloud monitoring platforms

Runs using:

* Bash
* Cron
* Linux utilities

---

# ⚙️ Tech Stack

| Technology       | Purpose               |
| ---------------- | --------------------- |
| Bash             | Automation scripting  |
| Cron             | Job scheduling        |
| Linux            | Operating environment |
| Postfix          | Email delivery        |
| mailutils        | Sending alerts        |
| awk / sed / grep | System parsing        |
| systemctl        | Service management    |

---

# 📁 Project Structure

```bash
linux-automation-toolkit/
├── scripts/
│   ├── disk_monitor.sh
│   ├── service_restart.sh
│   ├── log_rotate.sh
│   └── send_alert.sh
│
├── logs/
│   └── toolkit.log
│
├── config.sh
└── README.md
```

---

# 🔧 Configuration

All toolkit settings are centralized inside:

```bash
config.sh
```

Example configuration:

```bash
# Email destination
ALERT_EMAIL="you@example.com"

# Shared log file
LOG_FILE="$HOME/toolkit/logs/toolkit.log"

# Disk monitoring
DISK_THRESHOLD=80

# Log management
LOG_DIR="/var/log"
LOG_MAX_DAYS=7
LOG_ARCHIVE_DAYS=30

# Services to monitor
SERVICES=("nginx" "mysql" "ssh")
```

---

## Add More Services

```bash
SERVICES=("nginx" "mysql" "ssh" "redis" "postgresql")
```

---

# 🚀 Installation

## 1. Clone Repository

```bash
git clone git@github.com:Khaula-cloud/Linux-Automation-Toolkit.git

cd Linux-Automation-Toolkit
```

---

## 2. Install Dependencies

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    mailutils \
    sysstat \
    bc \
    curl
```

---

## 3. Create Toolkit Directories

```bash
mkdir -p ~/toolkit/{scripts,logs}

touch ~/toolkit/logs/toolkit.log

chmod 644 ~/toolkit/logs/toolkit.log
```

---

## 4. Copy Scripts

```bash
cp scripts/*.sh ~/toolkit/scripts/

cp config.sh ~/toolkit/config.sh
```

---

## 5. Set Permissions

```bash
chmod +x ~/toolkit/scripts/*.sh

chmod 644 ~/toolkit/config.sh
```

---

## 6. Configure Toolkit

```bash
nano ~/toolkit/config.sh
```

Update:

* Email address
* Services to monitor
* Thresholds
* Log paths

---

# ⏰ Cron Scheduling

Open crontab:

```bash
crontab -e
```

Add jobs:

```bash
# Disk monitoring every 30 minutes
*/30 * * * * bash $HOME/toolkit/scripts/disk_monitor.sh

# Service health checks every 5 minutes
*/5 * * * * bash $HOME/toolkit/scripts/service_restart.sh

# Log cleanup every day at 2 AM
0 2 * * * bash $HOME/toolkit/scripts/log_rotate.sh
```

---

# 🌐 Deployment Guide

## Deploy on Remote Server

```bash
ssh user@your-server-ip
```

Clone directly:

```bash
git clone git@github.com:Khaula-cloud/Linux-Automation-Toolkit.git ~/toolkit-setup
```

Install:

```bash
cd ~/toolkit-setup

chmod +x scripts/*.sh

cp scripts/*.sh ~/toolkit/scripts/

cp config.sh ~/toolkit/config.sh
```

---

## Verify Cron

```bash
systemctl status cron
```

Expected:

```bash
active (running)
```

---

# 🧪 Testing the Toolkit

## Test Disk Monitor

```bash
bash ~/toolkit/scripts/disk_monitor.sh
```

---

## Test Service Monitor

```bash
bash ~/toolkit/scripts/service_restart.sh
```

---

## Test Log Rotation

```bash
bash ~/toolkit/scripts/log_rotate.sh
```

---

## Send Test Alert

```bash
bash ~/toolkit/scripts/send_alert.sh \
"Test Alert" \
"Toolkit is functioning correctly."
```

---

## Watch Logs Live

```bash
tail -f ~/toolkit/logs/toolkit.log
```

---

# 📡 Monitoring & Alerts

## Simulate Disk Alert

Lower threshold temporarily:

```bash
sed -i 's/DISK_THRESHOLD=80/DISK_THRESHOLD=5/' \
~/toolkit/config.sh
```

Run monitor:

```bash
bash ~/toolkit/scripts/disk_monitor.sh
```

Reset threshold:

```bash
sed -i 's/DISK_THRESHOLD=5/DISK_THRESHOLD=80/' \
~/toolkit/config.sh
```

---

## Monitor Cron Activity

```bash
sudo tail -f /var/log/syslog | grep CRON
```

---

# 🛠️ Troubleshooting

# Permission Denied

```bash
chmod +x ~/toolkit/scripts/*.sh
```

---

# Cron Jobs Not Running

Verify:

```bash
crontab -l
```

Check logs:

```bash
sudo grep CRON /var/log/syslog | tail -20
```

Restart cron:

```bash
sudo systemctl restart cron
```

---

# Emails Not Arriving

Check postfix:

```bash
sudo systemctl status postfix
```

Test email manually:

```bash
echo "test" | mail -s "test" your@email.com
```

Check mail logs:

```bash
sudo tail -20 /var/log/mail.log
```

---

# WSL Disk Alerts

The toolkit automatically excludes:

* `/mnt`
* `drivers`
* `rootfs`
* `none`

Filter example:

```bash
df -H | grep -vE '^Filesystem|tmpfs|cdrom|none|drivers|rootfs|/mnt'
```

---

# 📋 Sample Outputs

## Disk Alert

```text
[2026-05-23 17:18:54] Running disk check...
[2026-05-23 17:18:54] WARNING: Disk /dev/sda1 is at 85%
[2026-05-23 17:18:54] ALERT: Disk Usage Critical
```

---

## Service Recovery

```text
[2026-05-23 03:12:01] nginx is DOWN
[2026-05-23 03:12:04] nginx restarted successfully
```

---

## Log Rotation

```text
[2026-05-23 02:00:01] Starting log rotation...
[2026-05-23 02:00:03] Deleted old archive
[2026-05-23 02:00:03] Rotation complete
```

---

# 🎓 Lessons Learned

## Cron Is Not Your Shell

Cron runs with a minimal environment.

Scripts that work manually may fail under cron unless:

* Full paths are used
* `$HOME` is explicitly defined
* Environment variables are handled properly

---

## Centralized Alerts Scale Better

Instead of placing mail logic in every script:

```bash
send_alert.sh
```

acts as a reusable alert abstraction layer.

This makes future integrations easy.

---

## Parsing Linux Output Is Real Engineering

This project required understanding:

* `df`
* `awk`
* `grep`
* `sed`
* `systemctl`
* `/var/log`
* Postfix
* Cron internals

Practical Linux engineering happens through system interaction — not theory.

---

# 🚀 Future Improvements

Planned enhancements:

* Slack webhook integration
* Discord alerts
* Prometheus exporter
* Grafana dashboard
* CPU & RAM monitoring
* Dockerized deployment
* Multi-server orchestration
* Alert deduplication
* Web dashboard
* Telegram notifications

---

# 🔐 Security Considerations

Implemented practices:

✅ Principle of least privilege
✅ Minimal dependencies
✅ Cron isolation
✅ Structured logging
✅ Controlled alerting

Recommended next steps:

* Harden mail configuration
* Add authentication layers
* Encrypt logs
* Secure SSH access

---

# 📜 License

MIT License

```text
MIT © 2026 Linux Automation Toolkit
```

Use it freely.

Modify it.

Deploy it.

Learn from it.

---

# 🙌 Final Note

This project was built to teach:

* Linux systems engineering
* Bash automation
* Cron scheduling
* Monitoring fundamentals
* Infrastructure reliability
* Operational thinking

Not just scripting.

---

<p align="center">

### ⚡ Built for real Linux environments — not toy examples.

</p>
