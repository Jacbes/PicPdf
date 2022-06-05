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
    <form action="/" method="post" enctype="multipart/form-data">

        <div class="row mb-2 justify-content-md-center">
            <div class="col-auto">
                <label for="formFileMultiple" class="form-label">Выберите файлы JPG</label>
                <input class="form-control" type="file" id="image" name="image[]" accept=".jpg, .jpeg, .png" multiple>
            </div>
        </div>

        <div class="row justify-content-md-center">
            <div id="preview"></div>
        </div>

        <div class="row mb-2 justify-content-md-center">
            <div class="col-auto">
                <input class="form-control" type="text" name="outName" placeholder="Название файла PDF">
            </div>
        </div>

        <div class="row mb-2 justify-content-md-center">
            <div class="col-auto">
                <button class="btn btn-primary" type="submit">Конвертировать</button>
            </div>
        </div>
    </form>
<#--    <button>-->
<#--        <img src="/images/x-circle.svg">-->
<#--    </button>-->
</div>
<script>
    const preview = document.getElementById("preview");
    const input_files = document.getElementById("image");

    input_files.addEventListener("change", addPreview, false);

    function addPreview() {
        preview.innerHTML = "";
        for (let i = 0; this.files.length > i; i++) {
            const img = document.createElement("img");
            img.src = URL.createObjectURL(this.files[i]);
            img.width = 200;
            img.height = 200;
            img.className = "img-thumbnail mb-2";
            preview.appendChild(img);
        }
    }
</script>
</body>
</html>