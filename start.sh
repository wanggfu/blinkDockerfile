#! /bin/bash
run -i -t -d -p 11202:22 -v /home/wangguangfu/sunniwell:/home/wangguangfu/sunniwell -v /opt:/opt --name="blinkbuild_contain" wanggfu/blinkbulid
