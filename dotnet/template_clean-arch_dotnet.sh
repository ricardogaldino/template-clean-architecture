#!/bin/bash

PROJECT="$1"

SRC="src"
TEST="test"

CLEAN_ARCH_UI="UI"
CLEAN_ARCH_USE_CASES="UseCases"
CLEAN_ARCH_ENTITIES="Entities"
CLEAN_ARCH_DATABASE="Database"
CLEAN_ARCH_EXTERNALS="Externals"

DEPENDENCY="Dependency"
INTERFACES="Interfaces"

TEST_UNITARY="UnitTest"
TEST_INTEGRATION="IntegTest"
TEST_ARCHITECTURE="ArchTest"

MODELS="Models"
SERVICES="Services"
REPOSITORIES="Repositories"
ENUMS="Enums"

# --------------------------------------------------

rm -Rf "$PROJECT"
mkdir "$PROJECT"
cd "$PROJECT"

mkdir "$SRC"
mkdir "$TEST"

# --------------------------------------------------

dotnet new sln -n "$PROJECT"

# --------------------------------------------------
cd "$SRC"
# --------------------------------------------------

dotnet new webapi -n "$PROJECT.$CLEAN_ARCH_UI" --no-https

cd "$PROJECT.$CLEAN_ARCH_UI"
dotnet add package Microsoft.Extensions.DependencyInjection
dotnet add package Microsoft.Extensions.DependencyInjection.Abstractions
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$CLEAN_ARCH_ENTITIES"

cd "$PROJECT.$CLEAN_ARCH_ENTITIES"
mkdir "$MODELS"
touch "$MODELS/.gitkeep"
mkdir "$ENUMS"
touch "$ENUMS/.gitkeep"
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$INTERFACES"

cd "$PROJECT.$INTERFACES"
mkdir "$CLEAN_ARCH_USE_CASES"
touch "$CLEAN_ARCH_USE_CASES/.gitkeep"
mkdir "$CLEAN_ARCH_EXTERNALS"
touch "$CLEAN_ARCH_EXTERNALS/.gitkeep"
mkdir "$CLEAN_ARCH_DATABASE"
touch "$CLEAN_ARCH_DATABASE/.gitkeep"
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$DEPENDENCY"

cd "$PROJECT.$DEPENDENCY"
dotnet add package Microsoft.Extensions.DependencyInjection
dotnet add package Microsoft.Extensions.DependencyInjection.Abstractions

mkdir "$CLEAN_ARCH_USE_CASES"
touch "$CLEAN_ARCH_USE_CASES/.gitkeep"
mkdir "$CLEAN_ARCH_EXTERNALS"
touch "$CLEAN_ARCH_EXTERNALS/.gitkeep"
mkdir "$CLEAN_ARCH_DATABASE"
touch "$CLEAN_ARCH_DATABASE/.gitkeep"
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$CLEAN_ARCH_USE_CASES"

cd "$PROJECT.$CLEAN_ARCH_USE_CASES"
dotnet add package AutoMapper
dotnet add package Newtonsoft.Json
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$CLEAN_ARCH_DATABASE"

cd "$PROJECT.$CLEAN_ARCH_DATABASE"
dotnet add package Dapper
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package EFCore.NamingConventions

mkdir "$REPOSITORIES"
touch "$REPOSITORIES/.gitkeep"
cd ..

# --------------------------------------------------

dotnet new classlib -n "$PROJECT.$CLEAN_ARCH_EXTERNALS"

cd "$PROJECT.$CLEAN_ARCH_EXTERNALS"
mkdir "$SERVICES"
touch "$SERVICES/.gitkeep"
cd ..

# --------------------------------------------------
cd ..
# --------------------------------------------------
cd "$TEST"
# --------------------------------------------------

dotnet new xunit -n "$PROJECT.$TEST_UNITARY"

cd "$PROJECT.$TEST_UNITARY"
dotnet add package Microsoft.NET.Test.Sdk
dotnet add package xunit
dotnet add package xunit.runner.console
dotnet add package xunit.runner.visualstudio
dotnet add package coverlet.collector
dotnet add package coverlet.msbuild
# dotnet add package Moq
dotnet add package FakeItEasy
dotnet add package FluentAssertions
dotnet add package NBuilder
dotnet add package Faker.Net
dotnet add package Bogus

mkdir "$CLEAN_ARCH_ENTITIES"
touch "$CLEAN_ARCH_ENTITIES/.gitkeep"
mkdir "$CLEAN_ARCH_USE_CASES"
touch "$CLEAN_ARCH_USE_CASES/.gitkeep"
cd ..

# --------------------------------------------------

cd "$TEST"
dotnet new xunit -n "$PROJECT.$TEST_INTEGRATION"

cd "$PROJECT.$TEST_INTEGRATION"
dotnet add package Microsoft.NET.Test.Sdk
dotnet add package Microsoft.AspNetCore.Mvc.Testing
dotnet add package DotNet.Testcontainers
dotnet add package xunit
dotnet add package xunit.runner.console
dotnet add package xunit.runner.visualstudio
dotnet add package coverlet.collector
dotnet add package coverlet.msbuild
# dotnet add package Moq
dotnet add package FakeItEasy
dotnet add package FluentAssertions
dotnet add package NBuilder
dotnet add package Faker.Net
dotnet add package Bogus

mkdir "$CLEAN_ARCH_UI"
touch "$CLEAN_ARCH_UI/.gitkeep"
mkdir "$CLEAN_ARCH_EXTERNALS"
touch "$CLEAN_ARCH_EXTERNALS/.gitkeep"
mkdir "$CLEAN_ARCH_DATABASE"
touch "$CLEAN_ARCH_DATABASE/.gitkeep"
cd ..

# --------------------------------------------------

dotnet new xunit -n "$PROJECT.$TEST_ARCHITECTURE"

cd "$PROJECT.$TEST_ARCHITECTURE"
dotnet add package Microsoft.NET.Test.Sdk
dotnet add package Microsoft.AspNetCore.Mvc.Testing
dotnet add package xunit
dotnet add package xunit.runner.console
dotnet add package xunit.runner.visualstudio
dotnet add package coverlet.collector
dotnet add package coverlet.msbuild
dotnet add package TngTech.ArchUnitNET
dotnet add package TngTech.ArchUnitNET.xUnit

mkdir "$CLEAN_ARCH_UI"
touch "$CLEAN_ARCH_UI/.gitkeep"
mkdir "$CLEAN_ARCH_ENTITIES"
touch "$CLEAN_ARCH_ENTITIES/.gitkeep"
mkdir "$CLEAN_ARCH_USE_CASES"
touch "$CLEAN_ARCH_USE_CASES/.gitkeep"
mkdir "$CLEAN_ARCH_EXTERNALS"
touch "$CLEAN_ARCH_EXTERNALS/.gitkeep"
mkdir "$CLEAN_ARCH_DATABASE"
touch "$CLEAN_ARCH_DATABASE/.gitkeep"
cd ..

# --------------------------------------------------
cd ..
# --------------------------------------------------

dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj"

dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$CLEAN_ARCH_UI/$PROJECT.$CLEAN_ARCH_UI.csproj"
dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$CLEAN_ARCH_ENTITIES/$PROJECT.$CLEAN_ARCH_ENTITIES.csproj"
dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$CLEAN_ARCH_USE_CASES/$PROJECT.$CLEAN_ARCH_USE_CASES.csproj"
dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$CLEAN_ARCH_DATABASE/$PROJECT.$CLEAN_ARCH_DATABASE.csproj"
dotnet sln "$PROJECT.sln" add "$SRC/$PROJECT.$CLEAN_ARCH_EXTERNALS/$PROJECT.$CLEAN_ARCH_EXTERNALS.csproj"

dotnet sln "$PROJECT.sln" add "$TEST/$PROJECT.$TEST_UNITARY/$PROJECT.$TEST_UNITARY.csproj"
dotnet sln "$PROJECT.sln" add "$TEST/$PROJECT.$TEST_INTEGRATION/$PROJECT.$TEST_INTEGRATION.csproj"
dotnet sln "$PROJECT.sln" add "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj"

# --------------------------------------------------

dotnet add  "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_ENTITIES/$PROJECT.$CLEAN_ARCH_ENTITIES.csproj"

dotnet add  "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_USE_CASES/$PROJECT.$CLEAN_ARCH_USE_CASES.csproj"
dotnet add  "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_DATABASE/$PROJECT.$CLEAN_ARCH_DATABASE.csproj"
dotnet add  "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_EXTERNALS/$PROJECT.$CLEAN_ARCH_EXTERNALS.csproj"

dotnet add  "$SRC/$PROJECT.$CLEAN_ARCH_UI/$PROJECT.$CLEAN_ARCH_UI.csproj" reference "$SRC/$PROJECT.$DEPENDENCY/$PROJECT.$DEPENDENCY.csproj"

dotnet add  "$SRC/$PROJECT.$CLEAN_ARCH_USE_CASES/$PROJECT.$CLEAN_ARCH_USE_CASES.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$SRC/$PROJECT.$CLEAN_ARCH_DATABASE/$PROJECT.$CLEAN_ARCH_DATABASE.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$SRC/$PROJECT.$CLEAN_ARCH_EXTERNALS/$PROJECT.$CLEAN_ARCH_EXTERNALS.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"

dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_UI/$PROJECT.$CLEAN_ARCH_UI.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_ENTITIES/$PROJECT.$CLEAN_ARCH_ENTITIES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_USE_CASES/$PROJECT.$CLEAN_ARCH_USE_CASES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_DATABASE/$PROJECT.$CLEAN_ARCH_DATABASE.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_ARCHITECTURE/$PROJECT.$TEST_ARCHITECTURE.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_EXTERNALS/$PROJECT.$CLEAN_ARCH_EXTERNALS.csproj"

dotnet add  "$TEST/$PROJECT.$TEST_INTEGRATION/$PROJECT.$TEST_INTEGRATION.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_INTEGRATION/$PROJECT.$TEST_INTEGRATION.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_UI/$PROJECT.$CLEAN_ARCH_UI.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_INTEGRATION/$PROJECT.$TEST_INTEGRATION.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_DATABASE/$PROJECT.$CLEAN_ARCH_DATABASE.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_INTEGRATION/$PROJECT.$TEST_INTEGRATION.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_EXTERNALS/$PROJECT.$CLEAN_ARCH_EXTERNALS.csproj"

dotnet add  "$TEST/$PROJECT.$TEST_UNITARY/$PROJECT.$TEST_UNITARY.csproj" reference "$SRC/$PROJECT.$INTERFACES/$PROJECT.$INTERFACES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_UNITARY/$PROJECT.$TEST_UNITARY.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_ENTITIES/$PROJECT.$CLEAN_ARCH_ENTITIES.csproj"
dotnet add  "$TEST/$PROJECT.$TEST_UNITARY/$PROJECT.$TEST_UNITARY.csproj" reference "$SRC/$PROJECT.$CLEAN_ARCH_USE_CASES/$PROJECT.$CLEAN_ARCH_USE_CASES.csproj"

# --------------------------------------------------
