#!/bin/bash 

ssh serverb hostnamectl set-hostname serverb
ssh serverc hostnamectl set-hostname serverc
ssh science_server hostnamectl set-hostname science_server

