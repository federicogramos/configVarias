##==============================================================================
## @file compile.sh | Compilación y generación
##==============================================================================
## Condicion: siempre hay un unico .ipynb en el directorio actual (toma ese nomb
## re como el basename del .tex).
##==============================================================================

## Busca el unico archivo .ipynb en dir actual.
IPYNB_FILE=$(find . -maxdepth 1 -name "*.ipynb" -printf "%f\n" 2>/dev/null | head -n 1)

if [ -z "$IPYNB_FILE" ]; then ## Validar q exista .ipynb
    echo "☒ Error: No se encontró ningún .ipynb actual directorio."
    exit 1
fi

BASE_NAME="${IPYNB_FILE%.ipynb}" ## Extraer basename ("lab6.ipynb" => "lab6").

IPYNB="${BASE_NAME}.ipynb" ## Archivos q deben existir para compilación.
TEX="${BASE_NAME}.tex"

echo "Archivo de partida = $IPYNB"


## -B : Desactiva la creación automática de carpetas __pycache__ y archivos .pyc
## -u : Fuerza la salida en tiempo real (Unbuffered), obligando a Git Bash a mostrar todo ya mismo
## -c : Indica que el siguiente argumento es el comando de código Python a ejecutar
FLAGS="-B -u -c"

CLEAN_OUTPUT=0  ## Archivos temporales de salida.

## Ejecución del rearmado.
"/c/Users/feder/.local/bin/python3.14.exe" $FLAGS "import sys; sys.path.append('C:/fgr/16gb/lib/libPython'); import fgrLib; fgrLib.procesar_y_compilar_informe('$IPYNB', '$TEX', $CLEAN_OUTPUT)"
