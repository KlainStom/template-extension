buildscript {
    repositories {
        maven("https://repo.spongepowered.org/maven")
    }
}

plugins {
    id("com.github.johnrengelman.shadow") version "7.0.0"
    id("net.kyori.blossom") version "1.3.0"
    java
}

var displayName = "EXTENSION_DISPLAY_NAME"
var minestomVersion = "be100fa5b8a410258e0da2aa4341cc341a0359a6"

group "com.github.klainstom"
version "1.0-SNAPSHOT"

repositories {
    mavenCentral()
    maven("https://repo.spongepowered.org/maven")
    maven("https://jitpack.io")
}

dependencies {
    compileOnly("com.github.Minestom:Minestom:$minestomVersion")
}

tasks {
    blossom {
        replaceToken("&NAME", displayName.toUpperCase())
        replaceToken("&Name", displayName)
        replaceToken("&name", displayName.toLowerCase())
        replaceToken("&version", version)
        replaceToken("&minestomVersion", minestomVersion)
    }

    shadowJar {
        archiveBaseName.set(displayName)
        archiveClassifier.set("")
        archiveVersion.set(project.version.toString())
    }

    test {
        useJUnitPlatform()
    }

    build {
        dependsOn(shadowJar)
    }

    processResources {
        expand(
            mapOf(
                "name" to displayName,
                "version" to version
            ),
        )
    }
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}
