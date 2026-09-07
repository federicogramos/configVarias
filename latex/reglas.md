# Tabla latex
Este es un ejemplo de la sintaxis a usar:

<latex_table cap="Comparativa de parámetros y sus promedios." lbl="tab:parametrosValores">
\\begin{{center}}
\\begin{{tabular}}{{|c|c|c|c|c|}}
\\hline
\\rowcolor{{tabColorHdr_085}}
    \\textnormal{{Parámetro}} & 
    \\textnormal{{Vin = 1}} & 
    \\textnormal{{Promedio}} \\\\ \\hline
\\rowcolor{{tabColor}}cggp & OP('/$I_{{individual}}$/I0/mp0' 'cgg') & 381.7a & 180.2a & 280.95a \\\\ \\hline
\\rowcolor{{tabColor}}Pcpgg & (0.3 * cggp) & 114.5a & 54.06a & 84.28a \\\\ \\hline
\\rowcolor{{tabColor}}Pgs & (0.7 * Pcpgg) & 80.16a & 37.84a & 59.00a \\\\ \\hline
\\rowcolor{{tabColor}}cggn & OP('/$I_{{individual}}$/I0/mn0' 'cgg') & 100.8a & 234.3a & 167.55a \\\\ \\hline
\\rowcolor{{tabColor}}Ncpgg & (0.3 * cggn) & 30.25a & 70.28a & 50.26a \\\\ \\hline
\\rowcolor{{tabColor}}Ngs & (0.7 * Ncpgg) & 21.18a & 49.2a & 35.19a \\\\ \\hline
\\end{{tabular}}
\\end{{center}}
</latex_table>

Observar:
* El escape de \\ en varias directivas debe ser respetado:
\\rowcolor{{tabColor}}Ngs & (0.7 * Ncpgg) & 21.18a & 49.2a & 35.19a \\\\ \\hline
\\end{{tabular}}
\\end{{center}}
* Los dobles {{}}, por ejemplo: {{tabColor}}
* No incluir nada mas que lo que en el ejemplo se utiliza. Si no está en el ejemplo, no se puede asumir que funciona.
* respuesta en bloque de codigo.