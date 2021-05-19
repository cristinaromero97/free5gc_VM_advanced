#  TFM Cristina Romero - free5gc. Escenario avanzado.

# Instalar paquetes

Solo es necesario hacerlo una vez, en las máquines que vayan a ejecutar el núcleo de red y los UPF.

```
sh install_go.sh
source ~/.bashrc
sh install_free5gc.sh
make
```


# Configuración y lanzamiento escenario avanzado

En la máquina donde correrán las funciones de control ejecutar:
```
sudo cp myConfig/amfcfg.yaml config/amfcfg.yaml
sudo cp myConfig/smfcfg.yaml config/smfcfg.yaml
```


En la máquina UPF1 ejecutar:
```
sudo cp myConfig/upf1.yaml NFs/upf/build/config/upfcfg.yaml
```

En la máquina UPF2 ejecutar:
```
sudo cp myConfig/upf2.yaml NFs/upf/build/config/upfcfg.yaml
```

Si se ha reiniciado las MVs UPF es necesario relizar la configuración del enrutado y NAPT en cada una.

```
sh upf1_network_config.sh #En UPF1
sh upf2_network_config.sh #En UPF2
```


Para la ejecutar el escenario:

Primero lanzar los UPFs ejecutando en cada uno:

```
cd free5gc/NFs/upf/build
sudo bin/free5gc-upfd
```

A continuación, lanzar el plano de control con la siguientes funciones ejecutando el siguiente script:
```
bash run_control_NFs.sh
```


# Webconsole

```
make webconsole
cd webconsole
go run server.go
```
