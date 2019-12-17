# Dagger POC for PHP App

## Goals

* Build sources with composer [php/composer](https://github.com/jygastaud/dagger/tree/main/php/composer) plugin
* Copy build result into a php image
* Store image into a registry
* Run the php container

## Install

* Git clone
* `dagger init`
* `dagger mod get github.com/jygastaud/dagger@v0.1`

## Current status ⚠️ not working ⚠️

* Build go to the end
* php image is store into the registry
* the php image doesn't contain php builded source
