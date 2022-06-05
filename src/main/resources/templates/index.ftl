<html lang="en">
<head>
    <title>PicToPdf</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <form action="/" method="post" enctype="multipart/form-data" id="forrm">

        <div class="row mb-2 justify-content-center">
            <div class="col-auto">
                <a class="btn btn-outline-secondary" onclick="addFiles()">
                    Выберите файлы JPG
                </a>
                <input class="invisible" type="file" id="image" name="image[]" accept=".jpg, .jpeg, .png" multiple>
                <a class="btn btn-outline-secondary" role="button" onclick="clearList()">
                    Удалить файлы
                </a>
            </div>
        </div>

        <div class="row justify-content-center" id="preview">
        </div>

        <div class="row mb-2 justify-content-center">
            <div class="col-auto">
                <input class="form-control" type="text" name="outName" placeholder="Название файла PDF">
            </div>
        </div>

        <div class="row mb-2 justify-content-center">
            <div class="col-auto">
                <a class="btn btn-primary" onclick="sendRequest()">
                    Конвертировать
                </a>
            </div>
        </div>
    </form>
    <p class="invisible fs-2 text-center" id="attention">
        Максимум 20 файлов
    </p>
    <p class="invisible fs-2 text-center" id="nonFiles">
        Не выбраны файлы
    </p>
</div>
<script>
    const max_document = 20
    const preview = document.getElementById("preview");
    const input_files = document.getElementById("image");
    const attent = document.getElementById("attention")
    const nonFil = document.getElementById("nonFiles")
    const but = document.getElementById("forrm");
    const dataTransfer = new DataTransfer()
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
        this.files = dataTransfer.files;
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
            delette.src = "/images/x-circle.svg"
            divev.appendChild(delette)
            divev.appendChild(img)
            preview.appendChild(divev);
        }
    }

    function removeItem() {
        closeAttention()
        for (let i = 0; dataTransfer.files.length > i; i++) {
            if (i == this.id) {
                dataTransfer.items.remove(i)
                break
            }
        }
        refreshPreview()
    }

    function clearList() {
        closeAttention()
        dataTransfer.items.clear()
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
</script>
</body>
</html>