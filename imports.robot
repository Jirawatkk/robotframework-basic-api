*** Settings ***
Library     RequestsLibrary
Library     Collections

Resource    ${CURDIR}/keywords.robot
Resource    ${CURDIR}/features.robot

Variables    ${CURDIR}/testdata.yaml