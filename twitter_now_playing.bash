#!/bin/bash

LAST_TWEET=''

tweet() {
  echo "Trying to tweet this: $1"
  curl -XPOST \
    --url https://api.twitter.com/1.1/statuses/update.json \
    --header 'authorization: OAuth oauth_consumer_key="oauth_customer_key", oauth_nonce="generated_oauth_nonce", oauth_signature="generated_oauth_signature", oauth_signature_method="HMAC-SHA1", oauth_timestamp="generated_timestamp", oauth_token="oauth_token", oauth_version="1.0"' \
    -d "status=$1"
}

echo "Starting Twitter Now Playing Service..."

for (( ; ; ))
do
  TWEET=$(playerctl metadata --format 'Escutanto agora: {{ artist }} - {{ title }} #nowPlaying')
  echo "TWEET: $TWEET"
  echo "LAST_TWEET: $LAST_TWEET"
  if [[ "$TWEET" != "$LAST_TWEET" ]]
  then
    echo "Playing track changed: $TWEET"
    tweet "$TWEET"
    LAST_TWEET = "$TWEET"
  fi

  sleep 1
done
