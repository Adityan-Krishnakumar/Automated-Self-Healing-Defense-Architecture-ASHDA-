# Incident Report 001: SIEM Visibility Loss & Resource Exhaustion

**Date:** 2026-02-12  
**Status:** Resolved  
**Impact:** Total loss of SSH and Dashboard visibility for Wazuh Manager.

##  The Issue
During high-load testing (simultaneous Hydra attack and Heartbeat monitoring), the Wazuh Manager entered a "Zombie" state. SSH connections were refused, and the Web UI became unresponsive.

##  Forensic Diagnosis
1. **Resource Exhaustion**: Analysis of the host machine confirmed 100% RAM utilization, causing the VirtualBox process to freeze.
2. **Time Drift**: Upon hard-rebooting the VMs, logs were flowing but not appearing in the Dashboard. Investigation revealed a 5-hour discrepancy between the `db-server` and the `wazuh-manager`.
3. **Rule Omission**: During the recovery process, it was discovered that `local_rules.xml` had been reverted, losing the custom Rule 100051.

##  Resolution
* **Force Reset**: Performed `vagrant halt --force` to break the zombie state.
* **Time Sync**: Synchronized VM hardware clocks using `hwclock -s` to align logs with the SIEM index.
* **Rule Restoration**: Re-deployed Rule 100051 with `self-healing` group tags to restore automated alerting.

## Lessons Learned
In a production SOC environment, NTP synchronization and resource quotas (cgroups) are non-negotiable for maintaining SIEM integrity.