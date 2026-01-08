# Exchange Online – Selective 6-Month Auto Archive Policy

TR / EN – Plain Markdown README

---

## Overview (EN)

This repository provides a Microsoft-supported and production-safe solution
to automatically move emails older than 6 months (180 days) to Online Archive
for selected users only in Exchange Online.

Key principles:
- Default MRM Policy remains unchanged
- Only targeted users are affected
- Fully automatic (server-side)
- No Outlook, New Outlook or OWA action required
- No client-side archive operation needed

This solution is based on Exchange Online MRM
(Messaging Records Management) and is fully supported by Microsoft.

---

## Genel Bakis (TR)

Bu repo, Exchange Online ortaminda sadece belirli kullanicilar icin
6 ayi gecen e-postalarin otomatik olarak Online Archive'a tasinmasini saglayan,
Microsoft tarafindan desteklenen bir cozum sunar.

Temel prensipler:
- Default MRM Policy degistirilmez
- Sadece secilen kullanicilar etkilenir
- Tamamen otomatik (sunucu tarafi)
- Outlook / New Outlook / OWA uzerinden manuel islem gerekmez
- Kullanici bilgisayarinda archive baslatmaya gerek yoktur

---
## Architecture

```text
Exchange Online
|
|-- Default MRM Policy
|   |-- Standard users (unchanged)
|
|-- Default MRM Policy - 6AyAutoArchive
    |-- Selected users
        |-- Mail older than 180 days
            |-- Automatically moved to Online Archive
```

## Prerequisites

- Exchange Online
- Online Archive enabled for target users
- Exchange Online PowerShell Module
- Global Administrator or Exchange Administrator role

---

## Repository Structure

```text
exchange-online-selective-auto-archive/
|
|-- README.md
|-- scripts/
|   |-- deploy-6month-archive.ps1
|   |-- rollback-archive-policy.ps1
|
|-- docs/
    |-- common-errors.md

```
---

## Scripts

### Deploy Script
- **File:** [deploy-6month-archive.ps1](scripts/deploy-6month-archive.ps1)
- Creates a 180-day MoveToArchive retention tag
- Clones Default MRM Policy
- Assigns policy to selected users
- Triggers Managed Folder Assistant

### Rollback Script
- **File:** [rollback-archive-policy.ps1](scripts/rollback-archive-policy.ps1)
- Reverts users back to Default MRM Policy
- No data loss
---

## Usage

Deployment:
powershell
.\scripts\deploy-6month-archive.ps1

Rollback:
powershell
.\scripts\rollback-archive-policy.ps1

---

## Automation Details

- Managed Folder Assistant runs automatically
- Processing time depends on mailbox size
- Fully server-side operation

---

## Common Errors

Detailed error handling and known issues are documented here:

📄 **[docs/common-errors.md](docs/common-errors.md)**

---

## Important Notes

- Only one default MoveToArchive tag is allowed per retention policy
- Online Archive must be enabled per user
- Policy changes may take several hours

---

## License

MIT License
