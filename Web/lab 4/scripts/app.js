import Work from "./Work.js"
import WorkTransform from "./WorkTransform.js"

const segment1 = document.querySelector(".top-segment")
const segment6 = document.querySelector(".bottom-segment")
const segment4 = document.querySelector(".right-segment")
const button = document.querySelector(".check")
const input = document.querySelector(".argument")
const field = document.querySelector(".top-segment .text")
const checkBox = document.querySelector(".label input")
const segmentList = document.querySelector(".middle-segment .array")

const segmentMap = {
    0:"top-segment",
    1:"left-segment",
    2:"right-segment",
    3:"middle-segment",
    4:"under-left-segment",
    5:"bottom-segment"
}

let textForm = document.createElement("form")
textForm.className = "textForm"
textForm.appendChild(createInput("data","text"))
textForm.appendChild(createInput("Save","button"))
textForm.appendChild(createInput("Resume","Button"))

function createInput(name,type) {
    let input = document.createElement("input")
    input.setAttribute("type",type)
    input.setAttribute("name",name)
    input.setAttribute("value", name)
    return input
}

//task1

segment1.addEventListener("click", (event) => {
    if(event.target == field) {
        return
    }

    for(let target of textForm.querySelectorAll("input")) {
        if(event.target==target) {
            return
        }
    }

    rewrite(segment1.querySelector(".number"), segment6.querySelector(".number"))
})

segment6.addEventListener("click", (event) => {

    for(target of textForm.querySelectorAll("input")) {
        if(event.target==target) {
            return
        }
    }

    rewrite(segment1.querySelector(".number"),segment6.querySelector(".number"))
})

function rewrite(segment1, segment2) {
    const temp = segment1.innerHTML
    segment1.innerHTML = segment2.innerHTML
    segment2.innerHTML = temp
}

//task 2

const a = 4
const b = 5
const segment3 = document.querySelector(".middle-segment")

let out = document.createElement("h3", 'class="output"')
out.innerHTML = "Result: " + 4*5

let isShown = false

segment3.addEventListener("click", (event) => {
    if(event.target == button | event.target == input) {
        return
    }
    if(!isShown){
        segment3.appendChild(out)
    }
    else {
        segment3.removeChild(out)
    }
    isShown=!isShown
})

//task 3

for(let record of document.cookie.split(";")){
    record = record.trim()
    let [key,value] = record.split("=")
    if(key === "Triangle" & value != "") {
        let accept = confirm(record + ", Зберегти?")
        if(accept) {
            document.forms.checker.setAttribute("style", "display:none")
        } else {
            document.cookie = "Triangle="
            alert("Кукі видалені")
            location.reload()
        }
    }
}

button.addEventListener("click", () => {
    let [a,b,c,...d] = input.value.split(" ")
    let exist = false
    if(!a | !b | !c | d) {
        alert("Error")
        return
    }
    if(a > Math.abs(b - c) && a < b + c) {
        exist = true
    }
    alert(exist)
    document.cookie = `Triangle=${exist}`
})

//task4

let setted = localStorage.getItem("Capitalize")

let capitalize = false
if(setted == "true") {
    segment4.setAttribute("style", "text-transform:capitalize")
    capitalize = true
}
field.addEventListener("blur", () => {
    if(!checkBox.checked){ 
        return
    }
    if(!capitalize) {
        segment4.setAttribute("style", "text-transform:capitalize")
        localStorage.setItem("Capitalize","true")
    } else {
        segment4.removeAttribute("style")
        localStorage.setItem("Capitalize","false")
    }
    capitalize = !capitalize
})

//task5

for(let i = 0; i < localStorage.length; i++) {
    let key = localStorage.key(i)
    if(isNaN(key)){
        continue
    }
    let segment = document.querySelector(`.${segmentMap[key]}`)
    segment.innerHTML = localStorage.getItem(key)
}

textForm.elements.Resume.addEventListener("click", () => {
    let target = textForm.getAttribute("target")
    localStorage.removeItem(target)
    let text = document.querySelector(`.${segmentMap[target]} .number`)
    text.innerHTML = localStorage.getItem(`${target}-prev`)
})

textForm.elements.Save.addEventListener("click", () => {
    let value = textForm.elements.data.value
    let target = textForm.getAttribute("target")
    let text = document.querySelector(`.${segmentMap[target]} .number`)
    localStorage.setItem(target, value)
    if(!localStorage.getItem(`${target}-prev`)) {
        let prev = text.innerHTML
        localStorage.setItem(`${target}-prev`, prev)
    }
    text.innerHTML = value
})

const segments = segmentList.querySelectorAll("li")
for(let i = 0; i < segments.length; i++) {
    segments[i].addEventListener("dblclick", () => {
        const segment = document.querySelector(`.${segmentMap[i]}`)
        textForm.setAttribute("target", i)
        segment.appendChild(textForm)
    })
}
const output = document.querySelector(".controller")
const data = {
    begin: "Begin",
    start: "start",
    stop: "stop",
    reload: "reload",
    left: "left",
    right: "right",
    close: "close",
    end: "end",
    bottom:"bot",
    top:"top",
    collapse:"collapse",
    speed: 100
}
const segment0 = document.querySelector(".left-segment")

// divs
// const work = new WorkTransform(segment0, output,data)

// canvas
const work = new Work(segment0, output,data)

document.querySelector(".Play").addEventListener("click", () => {
    if(segment3.querySelector(".work")!=null) {
        return
    } 
    if(output.querySelector("span")) {
        output.removeChild(output.querySelector("span"))
    }
    work.mount()
})

document.querySelector(".Save").addEventListener("click", () => {
    fetch(URL, {
        method: "POST",
        headers: {
            'Content-Type': 'text/plain'
        },
        body: JSON.stringify(data)
    
    }).then(r => r.text()).then(r => console.log(r))
})