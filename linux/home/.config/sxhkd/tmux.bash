#!/bin/bash

exec tmux -S "/run/user/$UID/tmux" new -As main
