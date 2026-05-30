buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.11.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.2.20")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
    // 🪄 إجبار جميع الحزم الفرعية على قراءة إصدار الـ NDK المتوفر بجهازك
    afterEvaluate {
        if (hasProperty("android")) {
            extensions.configure<com.android.build.gradle.BaseExtension> {
                ndkVersion = "28.2.13676358"
            }
        }
    }
}

subprojects {
    buildscript {
        configurations.all {
            resolutionStrategy {
                eachDependency {
                    if (requested.group == "com.android.tools.build" && requested.name == "gradle") {
                        useVersion("8.11.1")
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
