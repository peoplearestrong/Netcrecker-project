#!/bin/bash

DO_FING=$(ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}' | cut -c 5-)
DO_TOKEN="c3b959b4f37f5ed812752600ddcf9dc7f13d334bcdb81e0697736994f6d664dd"

terraform $1 -auto-approve \
  -var "do_token=${DO_TOKEN}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=${DO_FING}"
