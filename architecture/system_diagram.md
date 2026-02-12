```mermaid
graph TB
    subgraph "Threat Vector"
        H[Kali Linux: Hydra/Brute Force]
    end

    subgraph "Target Infrastructure"
        W[Web-Server: Apache2]
        D[DB-Server: MariaDB]
        S[Agent: ashda_pulse.sh]
    end

    subgraph "Wazuh Security Stack (SIEM)"
        M[Wazuh Manager]
        Dec[Custom Decoders: ashda-pulse]
        R[Custom Rules: 100051]
        DS[Wazuh Dashboard]
    end

    subgraph "Automation & Healing"
        A[Ansible Controller]
        P[Playbooks: service_restart.yml]
    end

    %% Data Flow
    H -- "Unauthorized Access" --> W
    W -- "local_decoder.xml" --> M
    D -- "local_rules.xml" --> M
    S -- "JSON/Syslog Heartbeat" --> M
    
    %% Processing Flow
    M --> Dec
    Dec --> R
    R -->|Visualize| DS
    
    %% Action Flow
    R -- "Trigger Active Response" --> A
    A --> P
    P -- "SSH/Python: systemctl restart" --> W
    P -- "SSH/Python: systemctl restart" --> D