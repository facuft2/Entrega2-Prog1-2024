{Se definen las siguientes constantes, todas de valor entero mayor que cero: MAXCOL = ...; MAXCAD = ...; cota de columnas de un archivo  cota de cadena de caracteres  Y los siguientes tipos de datos:  formato del texto  TipoFormato = ( Neg, Ita, Sub ); Formato = array [TipoFormato] of boolean; 3 uncarácterenuntextoincluyesuformato Caracter= record car:char; fmt:Formato end; arreglocontopequerepresentaaunalínea RangoColumna=1..MAXCOL; Linea = record cars: array[RangoColumna] ofCaracter; tope:0..MAXCOL end; PosibleLinea= record caseesLinea: boolean of true :(l:Linea); false:() end; listadelíneas,querepresentaauntexto Texto =ˆNodoLinea; NodoLinea = record info :Linea; sig :Texto end; posicióneneltexto Posicion = record linea :1..maxint; columna :RangoColumna end; PosiblePosicion= recordcase esPosicion: booleanof true :(p:Posicion); false:() end; PosibleColumna= recordcaseesColumna: boolean of true :(col:1..MAXCOL); false:() end; cadenadecaracteres Cadena = record cars: array[1..MAXCAD]of char; tope:0..MAXCAD end;}

function todosTienenFormatoEnLinea ( tfmt : TipoFormato; ini, fin : RangoColumna
                                   ; ln : Linea ) : boolean;
{ Retorna true solo si todos los caracteres de `ln` entre las columnas `ini` y `fin`, 
  incluídos los extremos, tienen el formato `tfmt`. En otro caso retorna false. 

  Precondiciones: 1 <= ini <= ln.tope
                  1 <= fin <= ln.tope }
var
  i: RangoColumna;
  verify: boolean;
begin
  i := ini;
  verify := true;
  while (i <= fin) and verify do
    begin
      if not ln.cars[i].fmt[tfmt] then
        verify := false;
      i := i + 1;
    end;

  todosTienenFormatoEnLinea := verify;
end;


procedure aplicarFormatoEnLinea ( tfmt : TipoFormato; ini, fin : RangoColumna
                                ; var ln : Linea );
{ Aplica el formato `tfmt` a los caracteres de `ln` entre las columnas `ini` y `fin`, 
  incluídos los extremos. 
  Si todos los carácteres ya tienen el tipo de formato `tfmt`, en lugar de aplicarlo 
  lo quita.

  Precondiciones: 1 <= ini <= ln.tope
                  1 <= fin <= ln.tope }
var 
    i: RangoColumna;
begin
  for i := ini to fin do
    if ln.cars[i].fmt[tfmt] = true then
      ln.cars[i].fmt[tfmt] := false
    else ln.cars[i].fmt[tfmt] := true;
end;



function contarCaracteresEnTexto ( txt : Texto ) : integer;
{ Retorna la cantidad de caracteres que tiene el texto `txt` }
var
    x,cantCar: Integer;
begin
  cantCar := 0;
  while txt^.sig <> nil do
  begin
    for x := 1 to txt^.info.tope do
      begin 
        cantCar := cantCar + 1;
      end;
    txt := txt^.sig;
  end;
  for x := 1 to txt^.info.tope do
      begin 
        cantCar := cantCar + 1;
      end;
  contarCaracteresEnTexto := cantCar;
end;


procedure buscarCadenaEnLineaDesde ( c : Cadena; ln : Linea; desde : RangoColumna
                                   ; var pc : PosibleColumna );
{ Busca la primera ocurrencia de la cadena `c` en la línea `ln` a partir de la 
  columna `desde`. Si la encuentra, retorna en `pc` la columna en la que incia. 

  Precondiciones: 1 <= desde <= ln.tope }
var
    i,pcA,x: Integer;
    igual,fin: Boolean; 
begin
  fin := false;
  igual := false;
  i := desde;

  while (i <= ln.tope ) and not fin do
  begin
    x := 1;
    if  ln.cars[i].car = c.cars[1]  then
    begin
      pcA := i;
      igual := true;
      while igual = true and (x <= c.tope) do
      begin
        if c.cars[x] = ln.cars[pcA].car then
        begin
          x += 1;
          pcA += 1;
        end
        else
        begin
          igual := false;
        end;
      end;
    end;
    if igual = true then
    begin
      fin := igual;
      pc.esColumna := true;
      pc.col := i;
    end;
    i += 1;
  end;
  if igual = false then 
  begin
    pc.esColumna := false;
  end;

end;


procedure buscarCadenaEnTextoDesde ( c : Cadena; txt : Texto; desde : Posicion
                                   ; var pp : PosiblePosicion );
{ Busca la primera ocurrencia de la cadena `c` en el texto `txt` a partir de la 
  posición `desde`. Si la encuentra, retorna en `pp` la posición en la que incia. 
  La búsqueda no encuentra cadenas que ocupen más de una línea.

  Precondiciones: 1 <= desde.linea <= cantidad de líneas 
                  1 <= desde.columna <= tope de línea en desde.linea }
var
    // linea: Integer;
begin

// linea := desde.linea;

end;



procedure insertarCadenaEnLinea ( c : Cadena; columna : RangoColumna
                                ; var ln : linea; var pln : PosibleLinea );
{ Inserta la cadena `c` a partir de la `columna` de `ln`, y desplaza hacia la derecha 
  a los restantes caracteres de la línea. Los carácteres insertados toman el formato 
  del carácter que ocupaba la posición `columna` en la línea. Si la columna es 
  `ln.tope+1`, entonces queda sin formato.
  Si (c.tope + lin.tope) supera `MAXCOL`, los carácteres sobrantes se retornan (en
  orden) en la posible línea `pln`.
 
  Precondiciones:  1 <= columna <= ln.tope+1
                   columna <= MAXCOL
                   c.tope + columna <= MAXCOL  }  
begin
end;


procedure insertarLineaEnTexto ( ln : Linea; nln : integer; var txt : Texto );
{ Inserta la línea `ln` en la posición `nlin` del texto `txt`.

  Precondiciones: 1 < nln <= cantidad de líneas del texto + 1
}
begin
end;
