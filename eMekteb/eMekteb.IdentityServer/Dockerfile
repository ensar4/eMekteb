FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7049
#ENV ASPNETCORE_URLS=http://+:7049

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ["eMekteb.IdentityServer/eMekteb.IdentityServer.csproj", "eMekteb.IdentityServer/"]
RUN dotnet restore "eMekteb.IdentityServer/eMekteb.IdentityServer.csproj"

COPY . .


WORKDIR "/src/eMekteb.IdentityServer"

RUN dotnet build "eMekteb.IdentityServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "eMekteb.IdentityServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

COPY eMekteb.IdentityServer/certificate.pfx /app/certificate.pfx

ENTRYPOINT ["dotnet", "eMekteb.IdentityServer.dll"]
