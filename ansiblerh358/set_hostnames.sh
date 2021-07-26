#!/bin/bash 

ssh servera hostnamectl set-hostname servera
ssh serverb hostnamectl set-hostname serverb
ssh serverc hostnamectl set-hostname serverc
ssh serverd hostnamectl set-hostname serverd

