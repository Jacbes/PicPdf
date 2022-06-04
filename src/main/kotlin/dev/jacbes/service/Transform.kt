package dev.jacbes.service

import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.pdmodel.PDPage
import org.apache.pdfbox.pdmodel.PDPageContentStream
import org.apache.pdfbox.pdmodel.common.PDRectangle
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject

fun createPdf(images: MutableList<String>, outName: String) {
    val document = PDDocument()
    images.forEach {
        insertImage(it, document)
    }

    document.save("uploads/${outName}.pdf")
    document.close()
}

private fun insertImage(image: String, document: PDDocument) {
    val page = PDPage()
    document.addPage(page)

    val contentStream = PDPageContentStream(document, page)
    val pdImage = PDImageXObject.createFromFile(image, document)
    val mediaBox = page.mediaBox

    var scaleWidth = pdImage.width / PDRectangle.A4.width
    var scaleHeight = pdImage.height / PDRectangle.A4.height

    if (scaleWidth > scaleHeight) {
        scaleHeight = scaleWidth
    } else {
        scaleWidth = scaleHeight
    }

    val startX = (mediaBox.width - pdImage.width / scaleWidth) / 2
    val startY = (mediaBox.height - pdImage.height / scaleHeight) / 2

    contentStream.drawImage(
        pdImage,
        startX, startY,
        pdImage.width / scaleWidth, pdImage.height / scaleHeight
    )

    contentStream.close()
}