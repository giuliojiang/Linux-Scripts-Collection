#! /bin/bash
for i in $(dpkg -l "*$(uname -r)*" | grep image | awk '{print $2}'); do echo $i hold | dpkg --set-selections; done
dpkg --get-selections | grep hold
