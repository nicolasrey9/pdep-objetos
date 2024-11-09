import casas.*
// PERSONAJES
class Personaje {
  const property casa
  const conyuges = []
  var property estaVivo
  const acompaniantes = []
  const personalidad

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

  method esAliadoDe(alguien) = self.aliados().contains(alguien)

  method complotarContra(persona) {
    personalidad.afectarA(persona)
  }

  method serAsesinado() {
    estaVivo = false
  }

  method derrochar(dinero) {
    casa.gastar(dinero)
  }
}

// PERSONALIDADES
object sutil {
  const casas = []
  method afectarA(persona) {
    const vivoSolteroYPobre = casas.min{ casa => casa.patrimonio() }.pretendiente()
    persona.casarCon(vivoSolteroYPobre)
  }
}
object asesino {
  method afectarA(persona) {
    persona.serAsesinado()
  }
}
object asesinoPrecavido {
  method afectarA(persona) {
    if(persona.estaSolo()) persona.serAsesinado() // sutil repeticion de logica con asesino, pero me da paja hacer una clase
  }
}
object disipado {
  const porcentajeADerrochar = 0.1
  method afectarA(persona) {
    persona.derrochar(persona.patrimonio() * porcentajeADerrochar)
  }
}
object miedoso {
  method afectarA(persona) { }
}


// MASCOTAS
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
