# Common Errors and Troubleshooting

This document lists common issues encountered while deploying
selective auto-archive policies in Exchange Online
and their recommended resolutions.

---

## Archive Does Not Move Immediately

### Symptoms
- Emails older than 180 days are still visible in the primary mailbox
- Online Archive exists but appears empty

### Cause
Managed Folder Assistant (MFA) runs on a scheduled basis
and does not process mailboxes instantly.

### Resolution
Manually trigger MFA for the affected user:

```powershell
Start-ManagedFolderAssistant -Identity user@domain.com
