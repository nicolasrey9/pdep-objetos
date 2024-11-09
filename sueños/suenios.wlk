import personas.*

// SUEÑOS
class Suenio {
  const property felicidadQueOtorga = 0

  method cumplir(persona) {
    self.validarPuedeCumplir(persona)
    persona.cumplio(self)
    persona.ganarFelicidad(felicidadQueOtorga)
  }
  method validarPuedeCumplir(persona) { }

}

class RecibirseDeUnaCarrera inherits Suenio {
  const carrera

  override method cumplir(persona) {
    super(persona)
    persona.recibirse(self)
  }

  override method validarPuedeCumplir(persona) {
    if(! self.carreraValidaPara(persona)) throw new DomainException()
  }

  method carreraValidaPara(persona) = 
    persona.quiereEstudiar(carrera) && ! persona.seRecibio(carrera)
}
class TenerHijos inherits Suenio {
  const cantidadHijos

  override method cumplir(persona) {
    super(persona)
    persona.tenerHijos(cantidadHijos)
  }
}
class AdoptarHijos inherits TenerHijos {
  override method validarPuedeCumplir(persona) {
    if(persona.tieneHijos()) throw new DomainException()
  }
}
class ViajarA inherits Suenio {

}
class ConseguirTrabajo inherits Suenio {
  const sueldo

  override method validarPuedeCumplir(persona) {
    if(! persona.sueldoValido(sueldo)) throw new DomainException()
  }
}

// SUEÑOS MULTIPLES
class SuenioMultiple inherits Suenio {
  const suenios = []

  override method felicidadQueOtorga() = 
    suenios.sum{ suenio => suenio.felicidadQueOtorga() } 

  override method cumplir(persona) {
    self.validarPuedeCumplir(persona)
    suenios.forEach{ suenio => suenio.cumplir(persona) }
  }
  override method validarPuedeCumplir(persona) {
    suenios.forEach{ suenio => suenio.validarPuedeCumplir(persona) }
  }

}