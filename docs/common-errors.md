```text
COMMON ERRORS AND TROUBLESHOOTING

This document lists common issues that may occur while deploying
selective auto-archive policies in Exchange Online and explains
their causes and resolutions.

----------------------------------------------------------------

ARCHIVE DOES NOT MOVE IMMEDIATELY

Symptoms
- Emails older than 180 days are still visible in the primary mailbox
- Online Archive mailbox exists but appears empty

Cause
Managed Folder Assistant (MFA) runs on a scheduled basis and does not
process mailboxes immediately after policy assignment.

Resolution
Manually trigger Managed Folder Assistant for the affected user.

Command:
Start-ManagedFolderAssistant -Identity user@domain.com

----------------------------------------------------------------

USER HAS NO ONLINE ARCHIVE ENABLED

Symptoms
- Retention policy is assigned successfully
- No archive mailbox is created
- No errors are returned by the script

Cause
The Online Archive mailbox is not enabled for the user.

Resolution
Enable Online Archive for the user.

Command:
Enable-Mailbox user@domain.com -Archive

After enabling the archive, rerun the deployment script
or trigger Managed Folder Assistant again.

----------------------------------------------------------------

RETENTION POLICY TAG CONFLICT ERROR

Error Message
RetentionPolicy has a conflicting MessageClass '*'
for linked default RetentionPolicyTags

Cause
More than one default retention tag with the MoveToArchive action
is linked to the same retention policy.

Resolution
Ensure that only one retention tag with:
- Type = All
- RetentionAction = MoveToArchive

is linked to the policy.

The deployment script in this repository automatically removes
conflicting archive tags before assigning the correct one.

----------------------------------------------------------------

POLICY ASSIGNED BUT NO ARCHIVE ACTIVITY

Symptoms
- Retention policy is visible on the mailbox
- No emails are moved to Online Archive
- MFA has been triggered manually

Possible Causes
- Policy changes have not fully propagated
- Large mailbox size
- Backend processing delay in Exchange Online

Resolution
- Wait several hours
- Trigger MFA again
- Verify policy assignment

Command:
Get-Mailbox user@domain.com | Select-Object RetentionPolicy

----------------------------------------------------------------

PERMISSION OR ACCESS DENIED ERRORS

Symptoms
- PowerShell cmdlets fail to execute
- Access denied or insufficient permissions errors

Cause
The executing account does not have sufficient administrative roles.

Resolution
Ensure the account has one of the following roles:
- Global Administrator
- Exchange Administrator

----------------------------------------------------------------

NEW OUTLOOK OR CLIENT-SIDE CONFUSION

Explanation
This solution is entirely server-side.
Outlook, New Outlook, and OWA do not control auto-archive behavior.

Resolution
No client-side action is required.

----------------------------------------------------------------

ROLLBACK SAFETY CONFIRMATION

Question
Will running the rollback script delete or move archived emails?

Answer
No.

The rollback script only:
- Reassigns the Default MRM Policy
- Stops future automatic archiving

Existing archived emails remain safely in the Online Archive mailbox.

----------------------------------------------------------------

LOGGING AND AUDITING

All actions performed by these scripts are recorded in:
- Exchange Admin Audit Logs
- Microsoft Purview Unified Audit Log

No additional logging configuration is required.

----------------------------------------------------------------

SUPPORT STATEMENT

This solution is based on:
- Exchange Online Messaging Records Management (MRM)
- Microsoft-supported PowerShell cmdlets
- Production-safe configuration patterns

It aligns with Microsoft best practices for Exchange Online.
```
