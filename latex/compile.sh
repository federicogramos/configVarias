#!/bin/bash
##==============================================================================
## @file compile.sh | Compilación y generación
##==============================================================================
## Condicion: siempre hay un unico .ipynb en el directorio del script (toma ese
## nombre como el basename del .tex).
## Ahora se puede compilar estando en otra ruta. Ejemplo:
## $> ./informe/compile.sh
##
## Cross-platform: funciona en Windows (Git Bash) y en Linux/Ubuntu. El binario
## de Python y la ruta de fgrLib (libPython) se eligen segun la plataforma.
##==============================================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" &>/dev/null && pwd) ## Dir del script.
cd "$SCRIPT_DIR" || exit 1  ## Ir.

## El unico .ipynb en el directorio del script.
IPYNB_FILE=$(find . -maxdepth 1 -name "*.ipynb" -printf "%f\n" 2>/dev/null | head -n 1)

if [ -z "$IPYNB_FILE" ]; then ## Validar q exista .ipynb
    echo "☒ Error: No se encontró ningún .ipynb en el directorio del script ($SCRIPT_DIR)."
    exit 1
fi

BASE_NAME="${IPYNB_FILE%.ipynb}" ## Extraer basename ("lab6.ipynb" => "lab6").

IPYNB="${BASE_NAME}.ipynb" ## Archivos q deben existir para compilación.
TEX="${BASE_NAME}.tex"

##==============================================================================
## Detección de plataforma => binario de Python + ruta de fgrLib (libPython).
##  - Windows (Git Bash / MSYS / Cygwin): binario .exe + ruta C:/fgr/16gb/...
##  - Linux / Ubuntu (bash):              python3 del PATH + /home/arq/16gb/...
##==============================================================================
case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*)
        ## --- Windows (Git Bash) ---
        PYTHON_BIN="/c/Users/feder/.local/bin/python3.14.exe"
        LIB_PYTHON_PATH="C:/fgr/16gb/lib/libPython"
        ;;
    *)
        ## --- Linux / Ubuntu ---
        PYTHON_BIN="$(command -v python3)"
        LIB_PYTHON_PATH="/home/arq/16gb/lib/libPython"
        ;;
esac

## Validar q el binario de Python y la lib fgrLib estén disponibles.
if [ ! -e "$PYTHON_BIN" ]; then
    echo "☒ Error: No se encontró el binario de Python ($PYTHON_BIN)."
    exit 1
fi
if [ ! -f "$LIB_PYTHON_PATH/fgrLib.py" ]; then
    echo "☒ Error: No se encontró fgrLib.py en $LIB_PYTHON_PATH."
    exit 1
fi

echo "Directorio de trabajo = $SCRIPT_DIR"
echo "Archivo de partida    = $IPYNB"
echo "Python bin            = $PYTHON_BIN"
echo "libPython             = $LIB_PYTHON_PATH"

## -B : Desactiva la creación automática de carpetas __pycache__ y archivos .pyc
## -u : Fuerza la salida en tiempo real (Unbuffered)
## -c : Indica que el siguiente argumento es el comando de código Python a ejecutar
FLAGS="-B -u -c"

CLEAN_OUTPUT=0  ## Archivos temporales de salida.

## Ejecución del rearmado.
"$PYTHON_BIN" $FLAGS "import sys; sys.path.append('$LIB_PYTHON_PATH'); import fgrLib; fgrLib.procesar_y_compilar_informe('$IPYNB', '$TEX', $CLEAN_OUTPUT)"
