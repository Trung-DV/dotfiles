#!/usr/bin/env osascript -l JavaScript

let iTerm = Application('iTerm');
iTerm.includeStandardAdditions = true;
let window = iTerm.currentWindow;

function run(argv) {
    try {
        window.name()
        window.createTabWithDefaultProfile();
    } catch (err) {
        console.log("create window: ", err)
        window = iTerm.createWindowWithDefaultProfile();
    }
    iTerm.setTheClipboardTo(argv.toString())
    window.currentSession.write({text: 'docker exec -it `pbpaste` /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"'})
    iTerm.activate();
}