# ASHDA: Automated Self-Healing Defense Architecture
**Proactive SIEM Monitoring & Automated Incident Response Ecosystem**

##  Project Overview
ASHDA (Automated Self-Healing Defense Architecture) is a security framework designed to bridge the gap between detection and remediation. By integrating **Wazuh (SIEM)** with **Ansible (Automation)**, the system identifies critical service failures and unauthorized access in real-time, executing pre-defined playbooks to restore system integrity without human intervention.

---

##  Tech Stack
* **SIEM/XDR**: Wazuh (Manager & Agents)
* **Orchestration**: Ansible (Active Response Controller)
* **Infrastructure**: Vagrant, VirtualBox (Multi-node Linux Environment)
* **Target Services**: Apache2 (Web), MariaDB (Database), OpenSSH
* **Security Tooling**: Kali Linux (Hydra for Attack Simulation)

---

##  Architecture & Logic
The system utilizes a **Negative Logic Heartbeat** protocol. Rather than simply alerting when a service fails, the manager monitors a continuous "Pulse." If the pulse reports a `CRITICAL` status, Rule `100051` triggers an Ansible recovery workflow.

* **[Detailed System Diagram](architecture/system_diagram.md)**: Visual mapping of data and command flow.

---

##  Key Features
### 1. Automated Threat Neutralization
Detected brute-force attacks via Rule `100010` (MariaDB Access Denied) trigger an immediate IP-table block on the offending source.

### 2. Self-Healing Infrastructure
Custom scripts monitor service health (`ashda_pulse.sh`). Upon detection of service downtime, Rule `100051` (Level 12) initiates an Ansible ad-hoc command to restart the failed component.

### 3. Forensic Traceability
Every detection and healing action is logged with high-fidelity timestamps, supporting post-incident forensic analysis.

---

##  Engineering Logs & Evidence
* **[Incident Report 001](engineering_logs/incident_001_visibility_loss.md)**: Deep dive into troubleshooting resource exhaustion and time-drift synchronization.
* **[Proof of Concept Gallery](proof_of_concept/)**: Screenshots of Level 12 alerts and successful active responses.

---

## About the developer
**CICSA V2 Candidate**
Focused on SOC Analyst roles, SIEM engineering, and security automation.