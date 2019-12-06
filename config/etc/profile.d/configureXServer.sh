#!/bin/bash

export DISPLAY=$(ip route get 1 | awk '{print $NF;exit}'):0
export LIBGL_ALWAYS_INDIRECT=1
