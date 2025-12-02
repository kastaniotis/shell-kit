#!/usr/bin/env sh
set -u   # no -e, so asserts don’t abort the script

PASS_COUNT=0
FAIL_COUNT=0

# Run validate_json on value + rules
# Sets:
#   OUTPUT  = JSON string from validate_json
#   SUCCESS = .success (true/false)

DESCRIPTION=""
TEST_KIND=""
TEST_VALUE=""

expect() {
    DESCRIPTION=$1
}

condition() {
    TEST_KIND=$1
    TEST_VALUE=$2
}

test() {
    #OUTPUT=$(validate_json "$@")
    ui show:info "Testing Result ($1): "

    if assert "$TEST_KIND" "$1" "$TEST_VALUE" "$DESCRIPTION"; then
        PASS_COUNT=$((PASS_COUNT+1))
    else
        FAIL_COUNT=$((FAIL_COUNT+1))
    fi
}

title() {
    ui show:title "$1"
}

summary() {
    ui show:title "Passed: $PASS_COUNT   Failed: $FAIL_COUNT"

    [ "$FAIL_COUNT" -eq 0 ] || exit 1
}