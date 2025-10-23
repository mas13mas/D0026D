
set -euo pipefail


LOCAL_HOME="/home/mas13"
REMOTE_USER="cisco"
REMOTE_HOST="192.168.214.98"

DEST_BASE="/home/${REMOTE_USER}/backups"
DEST_CURRENT="${DEST_BASE}/current"
DATE="$(date +%F)"
DEST_ARCHIVE="${DEST_BASE}/archives/${DATE}"
LOGFILE="$HOME/rsync-backup.log"


ssh "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p '${DEST_CURRENT}' '${DEST_ARCHIVE}'"


RSYNC_OPTS="-aHv --numeric-ids -e ssh --delete --backup --backup-dir='${DEST_ARCHIVE}'"

rsync ${RSYNC_OPTS} "${LOCAL_HOME}/" ${REMOTE_USER}@${REMOTE_HOST}:${DEST_CURRENT}/


echo "$(date '+%F %T') Backup OK -> ${REMOTE_HOST}:${DEST_CURRENT} (archive ${DEST_ARCHIVE})" >> "${LOGFILE}"
