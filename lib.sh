#!/bin/bash

API_URL="https://api.fastmail.com/jmap/api"
# get session token func with bearer token
function get_session_token() {
    URL="https://api.fastmail.com/jmap/session"
    BEARER=$1
    SESSION_RESP=$(http GET $URL Authorization:"Bearer $BEARER")
    ACCOUNT=$(echo $SESSION_RESP | jq -r '.accounts | keys[0]')
    echo $ACCOUNT
}


function get_masked_email() {
    BEARER=$1
    ACCOUNT_ID=$2
    MASKED_EMAIL_ID=$3
    PAYLOAD=\
$"{
    \"using\": [
        \"urn:ietf:params:jmap:core\",
        \"https://www.fastmail.com/dev/maskedemail\"
    ],
    \"methodCalls\": [
        [\"MaskedEmail/get\", {
            \"accountId\": \"$ACCOUNT_ID\",
            \"ids\": [\"$MASKED_EMAIL_ID\"]
        }, \"t0\"]
    ]
}"
    #echo $PAYLOAD
    API_URL="https://api.fastmail.com/jmap/api"
    RESULT=$(echo $PAYLOAD | http $API_URL Authorization:"Bearer $BEARER")
    echo $RESULT
}

function get_masked_emails() {
    BEARER=$1
    ACCOUNT_ID=$2
    PAYLOAD=\
$"{
    \"using\": [
        \"urn:ietf:params:jmap:core\",
        \"https://www.fastmail.com/dev/maskedemail\"
    ],
    \"methodCalls\": [
        [\"MaskedEmail/get\", {
            \"accountId\": \"$ACCOUNT_ID\"
        }, \"t0\"]
    ]
}"
    #echo $PAYLOAD
    API_URL="https://api.fastmail.com/jmap/api"
    RESULT=$(echo $PAYLOAD | http $API_URL Authorization:"Bearer $BEARER")
    echo $RESULT
}

function destroy_masked_email() {
    BEARER=$1
    ACCOUNT_ID=$2
    MASKED_EMAIL_ID=$3
    PAYLOAD=\
$"{
    \"using\": [
        \"urn:ietf:params:jmap:core\",
        \"https://www.fastmail.com/dev/maskedemail\"
    ],
    \"methodCalls\": [
        [\"MaskedEmail/set\", {
            \"accountId\": \"$ACCOUNT_ID\",
            \"destroy\": [
                \"$MASKED_EMAIL_ID\"
            ]
        }, \"t0\"]
    ]
}"
    #echo $PAYLOAD
    API_URL="https://api.fastmail.com/jmap/api"
    RESULT=$(echo $PAYLOAD | http $API_URL Authorization:"Bearer $BEARER")
    echo $RESULT
}
