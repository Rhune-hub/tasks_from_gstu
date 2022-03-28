"use strict";

const clickerForm = document.getElementById('clicker-form');
const clickerElements = [...document.getElementsByClassName('clicker-element')];
        
const socket = new WebSocket("ws://127.0.0.1:8000");
let is_active;   

const send = (event) => {
    socket.send(JSON.stringify({
        clicked: clickerForm.elements['clickers'].value
    }));
}

const enableElements = () =>  
    clickerElements.forEach( element => {
        element.addEventListener('change',send);
        element.disabled = false;
    });

const disableElements = () =>
    clickerElements.forEach( element => {
        element.disabled = true;
        element.removeEventListener('change',send);
    }); 

socket.onopen = function(e) {
    console.log("Connect to the server");
};

socket.onmessage = function(event) {
    const {active,clicked} = JSON.parse(event.data);

    if (is_active === undefined || is_active !== active)
        console.log(`Your are ${active ? 'CLICKERMAN' : 'VIEWER'}`);
    
    is_active = active;

    if (is_active)
        enableElements();
    else
        disableElements();
    
    if (!isNaN(clicked)) {
        clickerForm.elements['clickers'][clicked].checked = true;
        console.log(`Clicked to the ${clicked}`);
    }
};

socket.onclose = function(event) {
    disableElements();
    if (event.wasClean)
        console.log(`Disconnected from the server (${event.code}: ${event.reason})`);
    else
        console.log('Connection was killed');
};

socket.onerror = function(error) {
    console.log(`Error ${error.message}`);
};