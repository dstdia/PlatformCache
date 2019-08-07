#!/usr/bin/env bash

# Create scratch org
sfdx force:org:create -f config/project-scratch-def.json -a PlatformCache -s
if [[ $? -gt 0 ]] ; then exit 1; fi

# Push metadata
sfdx force:source:push
if [[ $? -gt 0 ]] ; then exit 1; fi
	
# Assign Permissions
sfdx force:user:permset:assign -n Cache
if [[ $? -gt 0 ]] ; then exit 1; fi
	
#Creating Users
sfdx force:user:create -f config/user-u1-def.json 
sfdx force:user:create -f config/user-u2-def.json 
sfdx force:user:create -f config/user-u3-def.json

#creating data
sfdx force:apex:execute -f data/createSalesDistricts.apexc 

#load data
sfdx force:data:bulk:upsert -f data/Products.csv  -s Product2 -i ExtId__c  -w 10

