# Aerodynamics Toolkit Docker

## Prerequisites

-   X11 based desktop (not tested on wayland)
-   Docker
-   Docker Compose v2

## Packaged Applications

-   [OpenFOAM](./openfoam/)
-   [OpenVSP](./openvsp/)
-   [XFLR5](./xflr5/)

### If you have trouble with X11 try running

```sh
# Allow X11 on docker to connect to local machine
xhost +local:docker > /dev/null
```
