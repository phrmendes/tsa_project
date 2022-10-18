#! /usr/bin/env bash

sudo sh -c 'echo "options(repos = c(RSPM = \"https://packagemanager.rstudio.com/all/__linux__/focal/latest\"))"
>> `R RHOME`/etc/Rprofile.site'
