*** Keywords ***

Verify input invalid credentials, API should return error
    [Arguments]         ${request_body}=${None}        ${expected_status}=401
    ${resp}     keywords.Post request login       ${request_body}    ${expected_status}
    keywords.Validate message is correct    ${resp.json()['status']}     ${message.error}
    keywords.Validate message is correct    ${resp.json()['message']}    ${message.login_message}

Get token from login
    [Arguments]         ${request_body}=${None}        ${expected_status}=200
    ${resp}     keywords.Post request login       ${request_body}    ${expected_status}
    ${headers}  keywords.Set token in headers    ${resp.json()['message']}
    [Return]    ${headers}

Check assets contains more than one
    [Arguments]        ${headers}=${None}    ${expected_status}=200
    ${get_resp}        Get assets from api    ${headers}    ${expected_status}
    ${count}           Get Length  ${get_resp.json()}
    ${morethanone}     Evaluate    ${count}>1
    BuiltIn.Should Be True     ${morethanone}

Verify invalid or null token
    [Arguments]    ${headers}=${None}    ${expected_status}=401
    ${get_resp}        keywords.Get assets from api     ${headers}        expected_status=${expected_status}
    keywords.Validate message is correct    ${get_resp.json()['message']}    ${message.message_no_permission_to_access_data}

Verify create new assets return success
    [Arguments]    ${headers}=${None}    ${request_body}=${None}    ${expected_status}=200
    ${asset_post_resp}    keywords.Post create new assetes    ${headers}    ${request_body}     ${expected_status}
    keywords.Validate message is correct    ${asset_post_resp.json()['status']}    ${message.success}

Verify cannot create duplicate id
    [Arguments]    ${headers}=${None}    ${request_body}=${None}    ${expected_status}=200
    ${asset_post_resp}    keywords.Post create new assetes    ${headers}     ${request_body}     ${expected_status}
    keywords.Validate message is correct    ${asset_post_resp.json()['status']}    ${message.failed}
    keywords.Validate message is correct    ${asset_post_resp.json()['message']}    id : ${assets_data['post']['assetId']} is already exists , please try with another id

Get assets and log data to console
    [Arguments]    ${headers}=${None}    ${expected_status}=200
    ${asset_get_resp}    keywords.Get assets from api    ${headers}    ${expected_status}
    Log To Console    ${asset_get_resp.json()}