object pepe {
  var puesto = manager
  var antiguedad = 5
  var faltas = 0
  const presentismo = bonoPorFaltas

  method puesto (puestoNuevo) {
    puesto = puestoNuevo
  }
  method antiguedad (anios) {
    antiguedad = anios
  }
  method falta () {
    faltas += 1
  }

  method sueldo () = 
    puesto.sueldoNeto(antiguedad) 
    + presentismo.bono(faltas, antiguedad)
    + resultadosEmpresa.bono(puesto.sueldoNeto(antiguedad), antiguedad)
}

object manager {
  method sueldoNeto (antiguedad) = 1500 + 50 * antiguedad
}
object desarrollador {
  method sueldoNeto (antiguedad) = 1000 + 25 * antiguedad
}
object gerente {
  method sueldoNeto (antiguedad) = 2500 + 100 * antiguedad
}

object bonoPorFaltas {
  method bono (faltas, antiguedad) =
    if (faltas == 0) 100
    else if (faltas == 1) 50 - antiguedad
    else 0
}
object bonoNulo{
  method bono (faltas, antiguedad) = 0
}
object bonoNioqui{
  method bono (faltas, antiguedad) = 2 ** faltas
}

object resultadosEmpresa {
  var tipoBono = "STI"

  method tipoBono (bonoTipo) {
    tipoBono = bonoTipo
  }

  method bono(sueldoNeto, antiguedad) =
    if(tipoBono == "STI") 0.25 * sueldoNeto
    else if (tipoBono == "fijo") 15 + antiguedad
    else 0 
}