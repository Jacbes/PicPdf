package dev.jacbes.models

import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.pdmodel.PDPage
import org.apache.pdfbox.pdmodel.PDPageContentStream
import org.apache.pdfbox.pdmodel.common.PDRectangle
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject

class Page(private val document: PDDocument, byteArray: ByteArray) {
    private val format = PDRectangle.A4
    val page = PDPage(format)
    private val image = PDImageXObject.createFromByteArray(document, byteArray, null)

    private val startX: Float
    private val startY: Float
    private val width: Float
    private val height: Float

    init {
        var scaleWidth = image.width / PDRectangle.A4.width
        var scaleHeight = image.height / PDRectangle.A4.height

        if (scaleWidth > scaleHeight) {
            scaleHeight = scaleWidth
        } else {
            scaleWidth = scaleHeight
        }

        startX = (format.width - image.width / scaleWidth) / 2
        startY = (format.height - image.height / scaleHeight) / 2

        width = image.width / scaleWidth
        height = image.height / scaleHeight

        addImageToPage()
    }

    private fun addImageToPage() {
        val contentStream = PDPageContentStream(document, page)

        contentStream.drawImage(
            image,
            startX, startY,
            width, height
        )
        contentStream.close()
    }
}