import DropDown from "./DropDown.js";
import { URL } from "./ref.js";
const parent = document.querySelector(".under-left-segment")
const menu = new DropDown(parent)

fetch(URL)
.then(r => r.text())
.then(text => {
    let items = JSON.parse(text)
    for(let item of Object.getOwnPropertyNames(items)) {
        let temp = menu.addItem(item)
        for(let point of items[item]){
            menu.addpoint(temp.querySelector("ul"), point)
        }
    }
})