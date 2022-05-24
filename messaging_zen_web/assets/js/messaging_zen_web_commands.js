/**
 * Zendesk Messenger Web API Commands
 * These can be called once the Zendesk Messenger script has been loaded by the browser.
 * API Reference: https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/sdk_api_reference/
 */

/** Test Function: Test that the JS has loaded successfully **/
function testAlert() {
    alert("messaging_zen_web_commands.js test successful");
}

/**
 *  Await Script Load
 *  Returns a promise resolved when the script has loaded.
 *  Allows us to wait for a script to load before calling commands against it.
 *  scriptId should use the '#' symbol in the ID string for the selector
 */
async function awaitScriptLoad(scriptId) {
    console.log(`Awaiting the ${scriptId} script to load...`);

    return new Promise((resolve, reject) => {
        var script = document.querySelector(scriptId);
        script.addEventListener('load', function() {
            console.log(`${scriptId} script loaded, resolving promise.`);
            resolve();
        });
    });
}



/**
 * Show (open) Zendesk Messenger
 */
function openZendeskMessenger() {
    console.log("Opening the Zendesk messenger.");
    zE('messenger', 'open');
}