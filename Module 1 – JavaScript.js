console.log("Welcome to the Community Portal");

window.onload=()=>{
alert("Portal Loaded");
};

const eventName="Tech Meetup";
const eventDate="10-06-2025";
let seats=50;

console.log(`${eventName} on ${eventDate}`);

function register(){
    seats--;
}

const events=[
    {
        id:1,
        name:"Tech Meetup",
        category:"Technology",
        seats:20
    },
    {
        id:2,
        name:"Music Fest",
        category:"Music",
        seats:30
    }
];

events.forEach(event=>{
    console.log(event.name);
});

function addEvent(event){
    events.push(event);
}

function registerUser(eventId){
    console.log("Registered",eventId);
}

function filterEventsByCategory(category){
    return events.filter(
        e=>e.category===category
    );
}

function registrationCounter(){
    let count=0;

    return function(){
        count++;
        return count;
    };
}

const counter=registrationCounter();

class Event{

    constructor(name,seats){
        this.name=name;
        this.seats=seats;
    }

    checkAvailability(){
        return this.seats>0;
    }
}

const event1=new Event("Workshop",20);

console.log(event1.checkAvailability());

const musicEvents=
events.filter(
e=>e.category==="Music"
);

const cards=
events.map(
e=>`Workshop on ${e.name}`
);

document.addEventListener(
"DOMContentLoaded",
()=>{

const div=
document.querySelector("#events");

if(div){

events.forEach(event=>{

const card=
document.createElement("div");

card.innerHTML=event.name;

div.appendChild(card);

});

}

});

async function fetchEvents(){

try{

const response=
await fetch(
"https://jsonplaceholder.typicode.com/posts"
);

const data=
await response.json();

console.log(data);

}
catch(error){

console.log(error);

}

}

fetchEvents();

const copy=[...events];

const {name,seats:availableSeats}=event1;

console.log(name,availableSeats);