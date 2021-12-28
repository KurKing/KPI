import DropDown from "./DropDown.js";
import { URL } from "./ref.js";
const parent = document.querySelector(".under-left-segment")
const menu = new DropDown(parent)

const masonryControl = document.forms.dropdown_control
const title = masonryControl.elements.title
const add = masonryControl.elements.add
const save = masonryControl.elements.save

fetch(URL)
.then(r => r.text())
.then(text => {
    let items = JSON.parse(text)
    for(let item of Object.getOwnPropertyNames(items)) {
        let temp = menu.addItem(item, true)
        for(let point of items[item]){
            menu.addpoint(temp.querySelector("ul"), point)
        }
    }
})
add.addEventListener("click", () => {
    for(let exist of Object.getOwnPropertyNames(menu.items)) {
        if(exist == title.value) {
            alert("Same title")
            return
        }
    }
    menu.addItem(title.value, true)
})

save.addEventListener("click", () =>{
    let body = menu.items
    fetch(URL, {
        method: "POST",
        headers: {
            'Content-Type': 'text/plain'
        },
        body: JSON.stringify(body)
    
    }).then(r => r.text()).then(r => console.log(r))
})