const max_document = 20
const preview = document.getElementById("preview");
const input_files = document.getElementById("image");
const attent = document.getElementById("attention")
const nonFil = document.getElementById("nonFiles")
const but = document.getElementById("forrm");
var dataTransfer = new DataTransfer()
const invAttent = "invisible fs-2 text-center"
const visAttent = "visible fs-2 text-center"

input_files.addEventListener("change", addPreview, false);

function addPreview() {
    for (let i = 0; this.files.length > i; i++) {
        dataTransfer.items.add(this.files[i]);
        if (dataTransfer.items.length >= max_document) {
            showAttention()
            break
        }
    }
    console.log(dataTransfer.files)
    console.log(this.files)
    input_files.files
    refreshPreview();
}

function refreshPreview() {
    preview.innerHTML = "";
    for (let i = 0; dataTransfer.files.length > i; i++) {
        const divev = document.createElement("div");
        const img = document.createElement("img");
        const delette = document.createElement("img")
        img.src = URL.createObjectURL(dataTransfer.files[i]);
        img.width = 200;
        img.height = 200;
        delette.id = i;
        divev.id = "img" + i;
        divev.className = "col-2"
        img.className = "img-thumbnail mb-2";
        delette.addEventListener("click", removeItem, false)
        img.addEventListener("click", mouseClick, false)
        delette.src = "images/x-circle.svg"
        divev.appendChild(delette)
        divev.appendChild(img)
        preview.appendChild(divev);
    }
}

function removeItem() {
    closeAttention()
    dataTransfer.items.remove(this.id)
    input_files.files = dataTransfer.files
    refreshPreview()
}

function clearList() {
    closeAttention()
    dataTransfer.items.clear()
    input_files.files = dataTransfer.files
    refreshPreview()
}

function sendRequest() {
    if (dataTransfer.files.length > 0) {
        closeAttention()
        input_files.files = dataTransfer.files
        but.submit()
    } else {
        showZeroFiles()
    }
}

function addFiles() {
    if (dataTransfer.files.length < max_document) {
        closeAttention()
        input_files.click()
    } else {
        showAttention()
    }
}

function showAttention() {
    attent.className = visAttent
}

function showZeroFiles() {
    nonFil.className = visAttent
}

function closeAttention() {
    attent.className = invAttent
    nonFil.className = invAttent
}

var firstImage = null
var firstFile = null
var secondImage = null
var secondFile = null

function mouseClick() {
    if (firstImage == null) {
        firstImage = this.parentNode
        firstFile = dataTransfer.files[firstImage.firstChild.id]
        this.style.backgroundColor = "red"
    } else if (firstImage == this.parentNode) {
        firstImage = null
        firstFile = null
        this.style.backgroundColor = "transparent"
    } else if (secondImage == null) {
        secondImage = this.parentNode
        secondFile = dataTransfer.files[secondImage.firstChild.id]

        let tempDataTransfer = new DataTransfer()
        for (let i = 0; dataTransfer.files.length > i; i++) {
            if (dataTransfer.files[i] == firstFile) {
                tempDataTransfer.items.add(secondFile)
            } else if (dataTransfer.files[i] == secondFile) {
                tempDataTransfer.items.add(firstFile)
            } else {
                tempDataTransfer.items.add(dataTransfer.files[i])
            }
        }

        firstImage = null
        secondImage = null
        firstFile = null
        secondFile = null
        console.log(dataTransfer.files)
        console.log(tempDataTransfer.files)
        dataTransfer = tempDataTransfer
        input_files.files = dataTransfer.files
        console.log(dataTransfer.files)
        console.log(input_files.files)
        refreshPreview()
    }
}