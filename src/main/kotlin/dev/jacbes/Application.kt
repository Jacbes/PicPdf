package dev.jacbes

import io.ktor.server.application.*
import dev.jacbes.plugins.*
import dev.jacbes.utils.configureDirectory

fun main(args: Array<String>): Unit =
    io.ktor.server.netty.EngineMain.main(args)

@Suppress("unused")
fun Application.module() {
    configureDirectory()
    configureRouting()
    configureTemplating()
}