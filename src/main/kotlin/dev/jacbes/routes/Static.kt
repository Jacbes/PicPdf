package dev.jacbes.routes

import io.ktor.server.http.content.*
import io.ktor.server.routing.*

fun Route.getStatic() {
    static("/") {
        staticBasePackage = "icons"
        static("images") {
            resource("favicon.ico")
            resource("x-circle.svg")
        }
    }
}