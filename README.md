

<img width="472" height="118" alt="inspectorbin" src="https://github.com/user-attachments/assets/d5606ce9-3ee1-4034-a63b-ffad779d86d7" />

---

Durante mi aprendizaje de Linux y Bash 🐚, me di cuenta de que **conocer lo básico no es suficiente**. Quería reforzar fundamentos mientras practicaba con scripts y ejercicios prácticos.  

Uno de esos ejercicios era simple: verificar comandos y directorios. Pero pensé: *“¿y si llevo esto un paso más allá y hago algo útil y visual?”*  

Así nació **InspectorBin**, una **mini-herramienta de diagnóstico y aprendizaje**, que combina utilidad y estética en la terminal.

---

## 🛠️ Funcionalidades

- ✅ **Verificación de comandos:** Comprueba si los comandos que necesitas existen en tu sistema.  
- ⚠️ **Seguridad del directorio:** Detecta si el script se ejecuta desde un directorio inseguro (como `/tmp`).  
- 💻 **Información del sistema:** Muestra usuario, hostname, sistema operativo, versión de Bash y PATH.  
- 🔒 **Permisos del script:** Verifica si el script es ejecutable.  
- 🎨 **Visual y animado:** Animación de puntos mientras se realiza la consulta, haciendo la terminal más atractiva.  

---

## 📥 Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/v1l4x/InspectorBin.git
```
2. Darle permisos de ejecución

```bash
chmod +x inspectorbin.sh
```
3. Ejecutar el script

```bash
./inspectorbin.sh
```
---

## Parametros:

-c	Comprueba si los comandos que especifiques existen en el sistema. (ej.: -c ls cat bash)
-v	Verificar si el directorio desde el que se ejecuta el script es seguro
-i	Mostrar información del sistema
-p	Verificar permisos del script
-V	Mostrar versión de InspectorBin
-h	Mostrar ayuda detallada
