# torizon-diablo-devilutionx

Container for running Diablo with DevilutionX engine on Torizon OS

## Supported platforms

<details>
<summary>i.MX 8M Plus</summary>
- ✅ 0058 - Verdin iMX8M Plus Quad 4GB WB IT
</details>

## Build and run

```
# docker build -t devilutionx:<tag> .
# docker save -o devilutionx-<platform>.tar devilutionx:<tag>
# scp devilutionx-<platform>.tar docker-compose.yml user@host:/tmp/
# ssh user@host
# docker load -i /tmp/devilutionx-<platform>.tar
# docker-compose -f /tmp/docker-compose.yml up -d
```

## Roadmap

- [ ] Address performance issues (e.g. frame rate)
- [ ] Clean up the Dockerfile and docker-compose.yml
- [ ] Add support for other Torizon-supported platforms
- [ ] Create GitHub Actions for building and pushing the image to a registry

