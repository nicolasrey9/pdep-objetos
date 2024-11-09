import casas.*
// PERSONAJES
class Personaje {
  const property casa
  const conyuges = []
  var property estaVivo
  const acompaniantes = []

  method noTienePareja() = conyuges.isEmpty()

  method sePuedeCasarCon(unPersonaje) =
    self.casaAdmiteCon(unPersonaje) 
    and unPersonaje.casaAdmiteCon(self)

  method casaAdmiteCon(otro) = casa.admiteCasamiento(self, otro)

  method casarCon(otro) {
    self.validarCasamientoCon(otro)
    self.agregarAConyuges(otro)
    otro.agregarAConyuges(self)
  }

  method agregarAConyuges(otro) {
    conyuges.add(otro)
  }

  method validarCasamientoCon(otro) {
    if(! self.sePuedeCasarCon(otro)) 
      throw new DomainException(message = "no se pueden casar")
  }

  method patrimonio() = casa.patrimonioDe(self)

  method estaSolo() = acompaniantes.isEmpty()

  method aliados() = acompaniantes + conyuges + casa.miembros()

  method esPeligroso() = 
    self.estaVivo() and
    self.cumpleRequerimientosPeligro()

  method cumpleRequerimientosPeligro() =
    self.aliados().sum{ aliado => aliado.patrimonio() } ||
    conyuges.all{ conyuge => conyuge.esDeCasaRica() } ||
    self.aliados().any{ aliado => aliado.esPeligroso() }


  method esDeCasaRica() = casa.esRica()
}

class Animal {
  method esPeligroso()
  method patrimonio() = 0
}
class Dragon inherits Animal {
  override method esPeligroso() = true
}

class Lobo inherits Animal {
  const esHungaro = false

  override method esPeligroso() = esHungaro
}
