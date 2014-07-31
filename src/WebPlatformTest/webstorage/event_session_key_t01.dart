/**
 * after web-platform-tests/webstorage/event_session_key.html
 * @assertion: http://dev.w3.org/html5/webstorage/ 
 * @description key property test of session event
 */
import 'dart:collection';
import 'dart:html';
import "../Utils/expectWeb.dart";

void main() {
    Queue expected = new Queue.from(['name', null]);
    void onStorageEvent(event) {
        assert_equals(event.key, expected.removeFirst());
        if (expected.isEmpty) {
            asyncEnd();
        }
    }

    window.sessionStorage.clear();
    window.addEventListener('storage', onStorageEvent, false);
    var event = new StorageEvent('storage');
    asyncStart();
    var el = document.createElement("iframe");
    el.setAttribute('id', 'ifrm');
    el.setAttribute('src', '${testSuiteRoot}/webstorage/iframe/session_set_item_clear_iframe.html');
    document.body.append(el);
}