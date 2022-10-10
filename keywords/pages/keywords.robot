*** Keywords ***

Create session for testing api
    RequestsLibrary.Create session     ${session_name}    ${url.main}

Post request login
    [Arguments]         ${request_body}=${None}        ${expected_status}=200
    ${resp}     RequestsLibrary.POST On Session     ${session_name}        ${url.path.login}      json=${request_body}    expected_status=${expected_status}
    [Return]    ${resp}

Set token in headers
    [Arguments]    ${token}
    ${headers}     BuiltIn.Create Dictionary    token=${token}
    [Return]       ${headers}

Get assets from api
    [Arguments]    ${headers}=${None}    ${expected_status}=200
    ${resp}     RequestsLibrary.GET On Session      ${session_name}    ${url.path.assets}         headers=${headers}    expected_status=${expected_status}
    [Return]    ${resp}

Post create new assetes
    [Arguments]    ${headers}=${None}    ${json_assets}=${None}    ${expected_status}=200
    ${asset_post_resp}    RequestsLibrary.POST On Session    ${session_name}     ${url.path.assets}    headers=${headers}    json=${json_assets}    expected_status=${expected_status}
    [Return]    ${asset_post_resp}

Put modify assets data
    [Arguments]    ${headers}=${None}    ${json_assets}=${None}    ${expected_status}=200
    ${asset_put_resp}    RequestsLibrary.PUT On Session    ${session_name}     ${url.path.assets}    headers=${headers}    json=${json_assets}    expected_status=${expected_status}
    [Return]    ${asset_put_resp}

Delete assets data
    [Arguments]    ${headers}=${None}    ${asset}=${None}    ${expected_status}=200
    ${asset_delete_resp}    RequestsLibrary.DELETE On Session    ${session_name}     /assets/${asset}    headers=${headers}    expected_status=${expected_status}
    [Return]    ${asset_delete_resp}

Validate message is correct
    [Arguments]         ${msg1}    ${msg2}
    BuiltIn.Should be equal     ${msg1}    ${msg2}