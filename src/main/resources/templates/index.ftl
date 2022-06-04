<html lang="en">
<head>
    <title>PicToPdf</title>
</head>
<body>
<div>
    <form action="/" method="post" enctype="multipart/form-data">
        <p>
            <input type="file" id="image" name="image[]" accept=".jpg, .jpeg, .png" multiple>
        </p>
        <div id="preview"></div>
        <p>
            <input type="text" name="outName">
        </p>
        <p>
            <input type="submit">
        </p>
    </form>
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
            img.width = 100
            img.height = 100
            preview.appendChild(img);
        }
    }
</script>
</body>
</html>