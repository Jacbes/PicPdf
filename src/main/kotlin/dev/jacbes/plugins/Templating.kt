package dev.jacbes.plugins

import dev.jacbes.service.createPdf
import freemarker.cache.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.freemarker.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.request.*
import io.ktor.server.routing.*
import java.io.File

fun Application.configureTemplating() {
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }

    routing {
        get("/") {
            call.respondRedirect("index")
        }
        route("index") {
            get {
                call.respond(FreeMarkerContent("index.ftl", model = null))
            }
            post {
                var fileName = ""
                var outName = ""

                val listOfImages = mutableListOf<String>()
                val multipartData = call.receiveMultipart()

                multipartData.forEachPart {
                    when (it) {
                        is PartData.FormItem -> {
                            outName = it.value
                        }
                        is PartData.FileItem -> {
                            fileName = it.originalFileName as String
                            val fileBytes = it.streamProvider().readBytes()
                            File("uploads/${fileName}").writeBytes(fileBytes)
                            listOfImages.add("uploads/${fileName}")
                        }
                    }
                }

                createPdf(listOfImages, outName)
                val file = File("uploads/${outName}.pdf")

                call.response.header(
                    HttpHeaders.ContentDisposition,
                    ContentDisposition.Attachment.withParameter(
                        ContentDisposition.Parameters.FileName,
                        "${outName}.pdf"
                    )
                        .toString()
                )
                call.respondFile(file)

                listOfImages.forEach {
                    File(it).delete()
                }
                file.delete()
            }
        }
    }
}
