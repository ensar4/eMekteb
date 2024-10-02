FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7160
ENV ASPNETCORE_URLS=http://+:7160

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ["eMekteb/eMekteb.csproj", "eMekteb/"]
COPY ["eMekteb.Model/eMekteb.Model.csproj", "eMekteb.Model/"]
COPY ["eMekteb.Services/eMekteb.Services.csproj", "eMekteb.Services/"]

RUN dotnet restore "eMekteb/eMekteb.csproj"

COPY . .

WORKDIR "/src/eMekteb"


RUN dotnet build "eMekteb.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "eMekteb.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "eMekteb.dll"]
