package dev.jacbes.plugins

import dev.jacbes.routes.createDocumentRoute
import dev.jacbes.routes.getIndexRoute
import io.ktor.server.routing.*
import io.ktor.server.application.*

fun Application.configureRouting() {
    routing {
        getIndexRoute()
        createDocumentRoute()
    }
}