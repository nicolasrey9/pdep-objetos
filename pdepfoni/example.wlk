/////////// LINEA
class Linea {
  const numero
  const packs = []
  const consumos

  method costoPromedioEntre(fechaInicio, fechaFin) = 
    self.consumosEntre(fechaInicio, fechaFin).sum{ consumo => consumo.costo() } / consumos.size()

  method consumosEntre(fechaInicio, fechaFin) = 
    consumos.filter{ consumo => consumo.estaEntre(fechaInicio, fechaFin)}

  method consumoMensual() { 
    const hoy = new Date()
    return self.consumosEntre(hoy.minusDays(30), hoy).sum{consumo => consumo.costo()}
  }

  method agregarPack(unPack) {  packs.add(unPack)  }
  
  method puedeConsumir(unConsumo) = packs.any{ unPack => unPack.puedeSatisfacer(unConsumo)}

  method consumir(unConsumo) {
    self.verificarQuePuedeConsumir(unConsumo)
    packs.reverse().find{ unPack => unPack.puedeSatisfacer(unConsumo) }.producirGasto(unConsumo)
    consumos.add(unConsumo)
  }

  method verificarQuePuedeConsumir(unConsumo) = 
    if(self.puedeConsumir(unConsumo)) throw new DomainException(message = "error, no puede consumir este pack")
}




/////////// CONSUMOS
class Consumo {
  const property fechaConsumo
  
  method costo()

  method estaEntre(fechaInicio, fechaFin) = fechaConsumo.between(fechaInicio, fechaFin)


  method seSatisfaceConCredito(creditoDisponible) = creditoDisponible > self.costo()

  method seSatisfaceConMB(mbCantidad) = false
  method seSatisfaceConllamadasGratis() = false
  method seSatisfaceConInternetIlimitado() = false
}

class ConsumoDeInternet inherits Consumo {
  const cantidadDeMB
  const precioPorMB = 0.1

  override method costo() = cantidadDeMB * precioPorMB

  override method seSatisfaceConMB(mbCantidad) = mbCantidad >= cantidadDeMB
  override method seSatisfaceConInternetIlimitado() = true

}

class ConsumoDeLlamadas inherits Consumo {
  const cantidadDeSegundos
  const precioPorSegundo = 0.05
  const precioFijo = 1

  override method costo() = precioFijo.max((cantidadDeSegundos - 30) * precioPorSegundo)

  override method seSatisfaceConllamadasGratis() = true
}


/////////// PACKS
class Vigencia inherits Date {
  method estaVigente() = self > new Date() 
}
object sinFechaDeVencimiento {
  method estaVigente() = true
}
class Pack {
  const vigencia = sinFechaDeVencimiento

  method puedeSatisfacer(valorAcumulado) = valorAcumulado && vigencia.estaVigente()

  method producirGasto(unConsumo) {

  }
  method estaVencido() = (! vigencia.estaVigente()) || self.estaAcabado()

  method estaAcabado() = false
}
class MBLibres inherits Pack {
    var property mbCantidad
    override method puedeSatisfacer(unConsumo) = super(unConsumo.seSatisfaceConMB(mbCantidad))

    override method estaAcabado() = mbCantidad <= 0

}

class Credito inherits Pack {
    var property creditoDisponible
    override method puedeSatisfacer(unConsumo) = super(unConsumo.seSatisfaceConCredito(creditoDisponible))

    override method estaAcabado() = creditoDisponible <= 0  

    override method producirGasto(unConsumo) {
      unConsumo.producirGasto(self)
    }
}

object llamadasGratis inherits Pack {
  override method puedeSatisfacer(unConsumo) = super(unConsumo.seSatisfaceConllamadasGratis())
}

object internetIlimitadoLosFindes inherits Pack {
  override method puedeSatisfacer(unConsumo) =
    if(self.esFinDeSemana((new Date()).dayOfWeek())) super(unConsumo.seSatisfaceConInternetIlimitado())
    else false

  method esFinDeSemana(unaFecha) = unaFecha == "sunday" || unaFecha == "saturday"
}