# Exchange Online – Selective 6-Month Auto Archive Policy

🇹🇷 Türkçe açıklama aşağıdadır  
🇬🇧 English description below

---

## 🇬🇧 Overview

This repository provides a **Microsoft-supported, production-safe solution**
to automatically move emails older than **6 months (180 days)** to **Online Archive**
for **selected users only** in Exchange Online.

Key principles:
- Default MRM Policy remains unchanged
- Only targeted users are affected
- Fully automatic (server-side)
- No Outlook, New Outlook or OWA action required
- No client-side archive operation needed

This solution is based on **Exchange Online MRM (Messaging Records Management)**  
and is fully supported by Microsoft.

---

## 🇹🇷 Genel Bakış

Bu repo, Exchange Online ortamında **sadece belirli kullanıcılar için**
**6 ayı geçen e-postaların otomatik olarak Online Archive’a taşınmasını**
sağlayan, **Microsoft tarafından desteklenen** bir çözüm sunar.

Temel prensipler:
- Default MRM Policy değiştirilmez
- Sadece seçilen kullanıcılar etkilenir
- Tamamen otomatik (sunucu tarafı)
- Outlook / New Outlook / OWA üzerinden manuel işlem gerekmez
- Kullanıcı bilgisayarında archive başlatmaya gerek yoktur

Bu çözüm **Exchange Online MRM (Messaging Records Management)** altyapısını kullanır
ve üretim ortamları için uygundur.

---

## Architecture / Mimari

Exchange Online
│
├─ Default MRM Policy
│ └─ All standard users (unchanged)
│
└─ Default MRM Policy - 6AyAutoArchive
└─ Selected users
└─ Emails older than 180 days
└─ Automatically moved to Online Archive

yaml
Kodu kopyala

---

## Prerequisites / Gereksinimler

- Exchange Online
- Online Archive enabled for target users
- Exchange Online PowerShell Module
- Global Administrator or Exchange Administrator role

---

## Solution Scope / Çözüm Kapsamı

✔ Selective (user-based) auto archive  
✔ Fully automatic background processing  
✔ No impact on existing users  
✔ Rollback supported  
✔ New Outlook compatible  

✖ Not using Microsoft Purview (by design)  
✖ No client-side rules  

---

## Repository Structure

exchange-online-selective-auto-archive/
│
├─ README.md
├─ scripts/
│ ├─ deploy-6month-archive.ps1
│ └─ rollback-archive-policy.ps1
│
└─ docs/
└─ common-errors.md

yaml
Kodu kopyala

---

## Scripts

### deploy-6month-archive.ps1

Creates:
- A 180-day MoveToArchive retention tag
- A cloned retention policy based on Default MRM Policy
- Assigns the policy to selected users
- Triggers Managed Folder Assistant

### rollback-archive-policy.ps1

- Reverts selected users back to Default MRM Policy
- No data loss
- Safe to execute anytime

---

## Usage / Kullanım

### Deployment

```powershell
.\scripts\deploy-6month-archive.ps1
Rollback
powershell
Kodu kopyala
.\scripts\rollback-archive-policy.ps1
Automation Details
Managed Folder Assistant runs automatically

Archive movement may take time depending on mailbox size

Optional manual trigger is included in deployment script

This process is fully server-side.

Common Errors / Sık Karşılaşılan Hatalar
See documentation:
📄 docs/common-errors.md

Important Notes
Only one default MoveToArchive tag is allowed per retention policy

Online Archive must be enabled per user

Policy changes may take several hours to fully apply

License
MIT License

Author
Created by an Exchange Online administrator
for real-world production environments.
