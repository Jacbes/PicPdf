package dev.jacbes.utils

import java.nio.file.Files
import java.nio.file.Paths

fun configureDirectory() {
    if (Files.notExists(Paths.get(DIRECTORY))) {
        Files.createDirectory(Paths.get(DIRECTORY))
    }
}