
*** Settings ***

Resource    ${CURDIR}/imports.robot
Suite Setup        Create session for testing api

*** Test Cases ***
TC-001 Verify when input wrong username or password, API should return error
    Verify input invalid credentials, API should return error    ${login.invalid}    401

TC-002 Verify That Can Get Asset List From Get API correctly
    ${headers}  features.Get token from login       ${login.valid}    200
    features.Check assets contains more than one    ${headers}        200

TC-003 Verify that get asset API always require valid token
    Verify invalid or null token    expected_status=401

TC-004 Verify that create asset API can work correctly
    ${headers}  features.Get token from login       ${login.valid}    200
    features.Verify create new assets return success    ${headers}    ${assets_data['post']}     200
    ${asset_get_resp}    Get assets from api    ${headers}    200
    keywords.Validate message is correct      ${asset_get_resp.json()[-1]['assetId']}    ${assets_data['post']['assetId']}

TC-005 Verify that cannot create asset with duplicated ID
    ${headers}  features.Get token from login       ${login.valid}    200
    Verify cannot create duplicate id    ${headers}    ${assets_data['post']}     200
    ${asset_get_resp}    Get assets from api    ${headers}    200
    List Should Not Contain Duplicates    ${asset_get_resp.json()}

TC-006 Verify that modify asset API can work correctly
    ${headers}  features.Get token from login       ${login.valid}    200
    ${asset_put_resp}    Put modify assets data    ${headers}    ${assets_data['put']}    200
    keywords.Validate message is correct     ${asset_put_resp.json()['status']}    success
    Get assets and log data to console    ${headers}    200

TC-007 Verify that delete asset API can work correctly
    ${headers}  features.Get token from login       ${login.valid}    200
    ${asset_delete_resp}    Delete assets data      ${headers}     ${assets_data['post']['assetId']}    200
    Get assets and log data to console    ${headers}    200

TC-008 Verify that cannot delete asset which ID does not exists
    ${headers}  features.Get token from login       ${login.valid}    200
    ${asset_delete_resp}    Delete assets data      ${headers}     ${assets_data['post']['assetId']}    200
    keywords.Validate message is correct         ${asset_delete_resp.json()['message']}    cannot find this id in database