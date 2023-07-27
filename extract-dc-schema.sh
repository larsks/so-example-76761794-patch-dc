#!/bin/bash

jq '
	fromstream(
		{
			"swagger": .swagger,
			"definitions": [
			.definitions|to_entries[]|select(
				(.key|startswith("com.github.openshift.api.apps.v1.Deployment")) or
				(.key|startswith("io.k8s.apimachinery")) or
				(.key|startswith("io.k8s.api.core"))
			)]|from_entries
		}|tostream|del(select(.[0][-1]=="description"))|select(. != null)
	)
'
