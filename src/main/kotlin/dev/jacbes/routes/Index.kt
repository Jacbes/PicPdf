package dev.jacbes.routes

import dev.jacbes.models.Document
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.http.content.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.io.File

fun Route.getIndexRoute() {
    get {
        call.respond(FreeMarkerContent("index.ftl", model = null))
    }
}

fun Route.createDocumentRoute() {
    post {
        val multipartData = call.receiveMultipart()

        val document = Document()
        multipartData.forEachPart {
            when (it) {
                is PartData.FormItem -> {
                    document.setDocumentName(it.value)
                }
                is PartData.FileItem -> {
                    val byteArray = it.streamProvider().readBytes()
                    if (byteArray.isNotEmpty()) {
                        document.addImageToDocument(byteArray)
                    } else {
                        document.addEmptyPage()
                    }
                }
                else -> {}
            }
        }
        document.saveDocument()

        call.response.header(
            HttpHeaders.ContentDisposition,
            ContentDisposition.Attachment.withParameter(
                ContentDisposition.Parameters.FileName,
                document.name
            ).toString()
        )
        call.respondFile(File(document.path))

        File(document.path).delete()
    }
}