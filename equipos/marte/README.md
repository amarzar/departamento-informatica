
# Equipos MARTE

| Parámetro   | Valor                       |
| ----------- | --------------------------- |
| Responsable | Departamento de Informática |
| Uso actual  | 2ASIR y 2DAW |
| Cantidad    | 30 |
| Adquisición | Finales del curso 201718 |
| Comprado en | Entregados por la consejería |

---
# 1. Hardware

## 1.1 Características

_Pendiente_

| Hardware | Descripción   |
| -------- | ------------- |
| CPU      |            i7 |
| RAM      |         16 GB |
| Disco 1  | SSH-M2 128 GB |
| Disco 2  |    SSH 500 GB |
| T Red    |               |
| Monitor  |               |

## 1.2 Particiones

```
# fdisk -l

Disco /dev/nvme0n1: 238,5 GiB
Tipo de etiqueta de disco: gpt

Disposit.  Tamaño Tipo
nvme0n1p1    476M Sistema EFI
nvme0n1p2    2,8G Linux swap
nvme0n1p3   74,5G Sistema de ficheros de Linux
nvme0n1p4   74,5G Sistema de ficheros de Linux
nvme0n1p5   86,2G Sistema de ficheros de Linux

Disco /dev/sda: 465,8 GiB
Tipo de etiqueta de disco: gpt

Disposit.  Tamaño Tipo
sda1       235,8G Sistema de ficheros de Linux
sda2         230G Sistema de ficheros de Linux
```

```
# df -hT

S.ficheros     Tipo     Tamaño Usados  Disp Uso% Montado en
/dev/nvme0n1p1 vfat       476M   9,6M  466M   3% /boot/efi
/dev/nvme0n1p3 btrfs       75G    15G   59G  20% /
/dev/sda1      xfs        236G   376M  236G   1% /home/asir
/dev/sda2      xfs        230G   605M  230G   1% /home/daw
```

## 1.3 Configuración del Monitor

> Cambiar configuración en las pantallas para que los equipos no se queden "muertos" al arrancar si las pantallas están apagadas.

Configurar el monitor de la siguiente forma:
* Pulsar botón bajo el monitor para activar el menú.
* `Control de entrada -> Detección conexión directa DP -> Siempre activo`

---
# 2. Configuraciones

## 2.1 Software

Actualizar todos los equipos al comienzo del curso:
* `sudo zypper refresh`, refrescar repositorios.
* `sudo zypper update`, actualizar paquetes.

Consultar [script de instalación](./files/installer.sh) para ver el detalle de los paquetes software instalados.

> NOTA: Se está creando la versión 2 del script [installer-v2.rb](files/installer-v2.rb)

Además se han realizado las siguientes personalizaciones:

| Software        | Detalle                           |
| --------------- | --------------------------------- |
| SSOO base       | [OpenSUSE Leap 15.0](opensuse.md) |
| Repositorios agregados | [atom](./files/atom.repo), [Education](./files/Education.repo), [virtualbox](./files/virtualbox.repo), [visualcode](./files/visualcode.repo) y [vagrant-2.2.6.repo](./files/vagrant-2.2.6.repo) |
| Monitorización  | Guía del montorizador [Veyon](../general/veyon.md) |
| LinuxBrew       | Guía para instalar [linuxbrew](linuxbrew.md) en OpenSUSE  |

## 2.2 Usuarios

| Nombre | Descripción |
| ------ | ----------- |
| asir   | Usar en turno de mañana por los alumnos y profesores |
| daw    | Usar en turno de tarde por los alumnos y profesores |
| super  | Sólo para tareas del sistema |
| root   | Sólo para tareas del sistema |

> NOTA: En /home se guardan ficheros tar con las copias de seguridad de los home de los usuarios en el momento de empezar el curso. La idea es usarlos el próximo septiembre para restaurar dichos usuarios.
