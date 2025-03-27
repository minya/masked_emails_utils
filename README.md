# Fastmail's Masked Emails API utilities

A collection of command-line tools to manage Fastmail's masked email addresses through their API.

## Requirements
- Fastmail account with masked email feature
- bash/shell environment
- curl (for API requests)
- jq (for JSON parsing)

## Setup
Create an API token with the Masked Email scope. Put it in the `.env/token` file.

## Usage examples
### Create a new masked email
```bash
./create-email
```

### List all masked emails
```bash
./list-emails | ./to-list
```

### List only deleted masked emails
```bash
./list-emails | ./to-list | ./by-status deleted
```

### List emails created after a certain date
```bash
./list-emails | ./to-list | ./by-creation-date 2025-03-23T17:09:49Z
```

### Hard delete an email
```bash
./destroy-email <email_id>
```

### Edit an email (can also be used to change state, e.g. from active to deleted)
```bash
./edit-email <email_id>
```
Opens the system editor with a JSON payload for the `MaskedEmail/set` API call. Make changes and save.

## Troubleshooting
- If you encounter permission issues, ensure the scripts are executable: `chmod +x ./*`
- Check your API token if you get authentication errors
- For full API documentation, refer to the [Fastmail API documentation](https://www.fastmail.com/developer/)