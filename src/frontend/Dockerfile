FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["PetSpotR/PetSpotR.csproj", "PetSpotR/"]
RUN dotnet restore "PetSpotR/PetSpotR.csproj"
COPY . .
WORKDIR "/src/PetSpotR"
RUN dotnet build "PetSpotR.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PetSpotR.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PetSpotR.dll"]
