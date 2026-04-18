#!/bin/bash
# ============================================================================
# Module: Java / Maven / Gradle
# Description: Ghee shortcuts and utilities for Java, Maven, and Gradle.
# ============================================================================

# Java

_GG_REGISTRY["jver"]="java -version ||| Show Java version"]
_GG_REGISTRY["jcc"]="javac FILE.java ||| Compile Java source file"]
_GG_REGISTRY["jrun"]="java CLASS ||| Run compiled Java class"]

# Maven

_GG_REGISTRY["mci"]="mvn clean install ||| Maven clean install"]
_GG_REGISTRY["mcp"]="mvn clean package ||| Maven clean package"]
_GG_REGISTRY["mt"]="mvn test ||| Maven run tests"]
_GG_REGISTRY["mcl"]="mvn clean ||| Maven clean"]
_GG_REGISTRY["mdeps"]="mvn dependency:tree ||| Maven dependency tree"]
_GG_REGISTRY["mspring"]="mvn spring-boot:run ||| Maven Spring Boot run"]

# Gradle

_GG_REGISTRY["grb"]="gradle build ||| Gradle build"]
_GG_REGISTRY["grcl"]="gradle clean ||| Gradle clean"]
_GG_REGISTRY["grt"]="gradle test ||| Gradle run tests"]
_GG_REGISTRY["grrun"]="gradle run ||| Gradle run application"]
_GG_REGISTRY["grdeps"]="gradle dependencies ||| Gradle dependency tree"]
_GG_REGISTRY["grspring"]="gradle bootRun ||| Gradle Spring Boot run"]

# Aliases

alias jver='java -version'
alias jcc='javac'
alias jrun='java'
alias mci='mvn clean install'
alias mcp='mvn clean package'
alias mt='mvn test'
alias mcl='mvn clean'
alias mdeps='mvn dependency:tree'
alias mspring='mvn spring-boot:run'
alias grb='gradle build'
alias grcl='gradle clean'
alias grt='gradle test'
alias grrun='gradle run'
alias grdeps='gradle dependencies'
alias grspring='gradle bootRun'
