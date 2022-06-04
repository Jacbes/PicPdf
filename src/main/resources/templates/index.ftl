<html lang="en">
<head>
    <title>PicToPdf</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div>
    <form action="/" method="post" enctype="multipart/form-data">
        <p>
            <input type="file" id="image" name="image[]" accept=".jpg, .jpeg, .png" multiple>
        </p>
        <div id="frames"></div>
        <p>
            <input type="text" name="outName">
        </p>
        <p>
            <input type="submit">
        </p>
    </form>
</div>
<script>
    $(document).ready(function () {
        $('#image').change(function () {
            for (let i = 0; i < $(this)[0].files.length; i++) {
                $('#frames').append('<img src="' + window.URL.createObjectURL(this.files[i]) + '" width="100px" height="100px"/>');
            }
        });
    });
</script>
</body>
</html>