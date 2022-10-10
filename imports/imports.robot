*** Settings ***
Library     RequestsLibrary
Library     Collections

Resource    ${CURDIR}/../keywords/pages/keywords.robot
Resource    ${CURDIR}/../keywords/features/features.robot

Variables    ${CURDIR}/../testdata/testdata.yaml