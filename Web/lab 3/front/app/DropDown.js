export default class DropDown {
    constructor(parent) {
        this._initBlock(parent)
        this.items = {}
    }

    _initBlock(parent) {
        const block = document.createElement("div")
        block.className = "field"
        parent.appendChild(block)
        this.field = block
    }

    addItem(title, editable = false) {
        const item = document.createElement("span")
        const name = document.createElement("p")
        name.innerHTML = title
        if(editable) {
            const edit = document.createElement("button")
            const deleteI = document.createElement("button")
            edit.innerHTML = "+"
            deleteI.innerHTML = "Delete"
            edit.addEventListener("click", this._edit.bind(this))
            deleteI.addEventListener("click", this._remove.bind(this))
            item.append(edit,deleteI)
        }
        const menu = document.createElement("ul")
        item.append(name, menu)
        let open = false
        name.addEventListener("click", (e) => {
            if(open) {
                e.target.parentElement.querySelector("ul").className = "active"
            } else {
                e.target.parentElement.querySelector("ul").className = ""
            }
            open = !open
        })
        this.field.appendChild(item)
        this.items[`${title}`] = []
        return item
    }

    _edit(e) {
        e.stopPropagation()
        const list = e.target.parentElement.querySelector("ul")
        let title = e.target.parentElement.querySelector("p").innerHTML
        const point = prompt("Введіть новий пункт")
        this.addpoint(list, point)
    }

    addpoint(list, point) {
        list.appendChild(this._createLi(point))
        this.items[`${list.parentElement.querySelector("p").innerHTML}`].push(point)
    }

    _remove(e) {
        e.stopPropagation()
        this.field.removeChild(e.target.parentElement)
        const list = e.target.parentElement.querySelector("p").innerHTML
        delete this.items[list]
    }

    _createLi(title) {
        const li = document.createElement("li")
        li.innerHTML = title
        return li
    }
}