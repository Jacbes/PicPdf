<html lang="en">
<head>
    <title>PicToPdf</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
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
<script src="scripts/script.js"></script>
</body>
</html>