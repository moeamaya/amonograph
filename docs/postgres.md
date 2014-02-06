# Setting up Postgres locally
### 1. Install postgres with Homebrew, the local one is too out of date
```bash
$: brew install postgres
```
### 2. Edit */etc/paths* so that *usr/local/bin* is above */usr/bin*
### 3. Finish creating the database
```bash
$: initdb /usr/local/var/postgres
```
### 4. Start up the server
```bash
$: pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```
and if you need to **Stop** it
```bash
$: pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop
```
