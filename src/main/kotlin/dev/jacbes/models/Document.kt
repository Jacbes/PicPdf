package dev.jacbes.models

import dev.jacbes.utils.CYRILLIC_CHAR_LIST
import dev.jacbes.utils.DIRECTORY
import dev.jacbes.utils.ENG_CYRILLIC_CHAR_LIST
import dev.jacbes.utils.RANDOM_NAME_LENGTH
import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.pdmodel.PDPage

class Document {
    private val document = PDDocument()
    lateinit var name: String
    lateinit var path: String

    fun addImageToDocument(byteArray: ByteArray) {
        val page = Page(document, byteArray)
        document.addPage(page.page)
    }

    fun addEmptyPage() {
        document.addPage(PDPage())
    }

    fun setDocumentName(name: String) {
        this.name = if (name.isEmpty()) {
            "${setRandomName()}.pdf"
        } else {
            name.map {
                if (isCyrillicChar(it)) {
                    changeToEngChar(it)
                } else {
                    it
                }
            }.joinToString("") + ".pdf"
        }
        setDocumentPath()
    }

    private fun setDocumentPath() {
        path = "$DIRECTORY/$name"
    }

    fun saveDocument() {
        document.save(path)
        document.close()
    }

    private fun setRandomName(): String {
        val listOfSymbols = ('A'..'Z') + ('a'..'z') + ('0'..'9')
        return (0..RANDOM_NAME_LENGTH)
            .map { listOfSymbols.random() }
            .joinToString("")
    }

    private fun isCyrillicChar(char: Char): Boolean {
        return CYRILLIC_CHAR_LIST.contains(char)
    }

    private fun changeToEngChar(char: Char): String {
        CYRILLIC_CHAR_LIST.forEachIndexed { index, it ->
            if (it == char) {
                return ENG_CYRILLIC_CHAR_LIST[index]
            }
        }

        return ""
    }
}