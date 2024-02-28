FROM mcr.microsoft.com/dotnet/sdk:7.0

WORKDIR /source

ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo $TARGETPLATFORM \
    echo $TARGETARCH \
    echo $BUILDPLATFORM

COPY . .

RUN dotnet restore -a $TARGETARCH
RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore

CMD dotnet /app/Worker.dll