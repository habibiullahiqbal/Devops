# #---------------------------------------------backend deploy script---------------------------------------------
# #!/bin/bash
# set -e

# IMAGE="$1"
# REGION="eu-west-2"

# aws ecr get-login-password --region "$REGION" | sudo docker login --username AWS --password-stdin "$IMAGE"
# sudo docker pull "$IMAGE:latest"

# sudo docker stop backend || true
# sudo docker rm backend || true
# sudo docker network inspect appnet >/dev/null 2>&1 || sudo docker network create appnet

# OUT=/home/ubuntu/.env
# : > "$OUT"

# aws ssm get-parameters-by-path --path "/" --with-decryption --recursive \
#   --query "Parameters[*].[Name,Value]" --output text \
# | while IFS=$'\t' read -r name value; do
#     key="${name##*/}"
#     [ -z "$key" ] && continue
#     clean="$(printf "%s" "$value" | tr -d '\r\n')"
#     printf "%s=%s\n" "$key" "$clean" >> "$OUT"
#   done

# sed -i -e "/^=$/d" -e "/^$/d" "$OUT"
# chown ubuntu:ubuntu "$OUT"
# chmod 600 "$OUT"

# sudo docker run -d --name backend --env-file /home/ubuntu/.env -p 5010:5010 --network appnet "$IMAGE:latest"

# sudo docker image prune -af
















# #---------------------------------------------frontend deploy script---------------------------------------------
# #!/bin/bash
# set -e

# IMAGE="$1"
# REGION="eu-west-2"
# PARAM_PATH="/frontend"
# ENV_FILE="/home/ubuntu/frontend.env"

# aws ecr get-login-password --region "$REGION" | sudo docker login --username AWS --password-stdin "$IMAGE"
# sudo docker pull "$IMAGE:latest"

# sudo docker stop frontend || true
# sudo docker rm frontend || true
# sudo docker network inspect appnet >/dev/null 2>&1 || sudo docker network create appnet

# : > "$ENV_FILE"

# aws ssm get-parameters-by-path \
#   --path "$PARAM_PATH" \
#   --with-decryption \
#   --recursive \
#   --query "Parameters[*].[Name,Value]" \
#   --output text \
# | while IFS=$'\t' read -r name value; do
#     key="${name##*/}"
#     [ -z "$key" ] && continue
#     clean="$(printf "%s" "$value" | tr -d '\r\n')"
#     printf "%s=%s\n" "$key" "$clean" >> "$ENV_FILE"
#   done

# chown ubuntu:ubuntu "$ENV_FILE"
# chmod 600 "$ENV_FILE"

# sudo docker run -d --name frontend --env-file "$ENV_FILE" -p 3000:3000 --network appnet "$IMAGE:latest"

# sudo docker image prune -af
