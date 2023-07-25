#!/bin/bash

jq '
	{
		"swagger": .swagger,
		"info": .info,
		"definitions": [
		.definitions|to_entries[]|select(
			(.key|startswith("com.github.openshift.api.apps.v1.Deployment")) or
			(.key|startswith("io.k8s.apimachinery")) or
			(.key|startswith("io.k8s.api.core"))
		)]|from_entries}
' | sed '/"description"/d'
