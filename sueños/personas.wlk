import suenios.*
import criterios.*


class Persona {
  var property criterio

  const sueniosCumplidos = []
  const sueniosPendientes = []
  const carrerasRecibidas = []
  const carrerasQueQuiereEstudiar = []
  const plataQueQuiereGanar
  var cantidadHijos = 0
  var nivelDeFelicidad

  method cumplirSuenio() {
    criterio.elegirSuenio(sueniosPendientes).cumplir(self)
  }

  method cumplio(suenio) {
    sueniosPendientes.remove(suenio)
    sueniosCumplidos.add(suenio)
  }

  method quiereEstudiar(carrera) = carrerasQueQuiereEstudiar.contains(carrera)
  method seRecibio(carrera) = carrerasRecibidas.contains(carrera)
  method recibirse(carrera) {
    carrerasRecibidas.add(carrera)
  } 

  method tieneHijos() = cantidadHijos > 0
  method tenerHijos(cantidad) {
    cantidadHijos =+ cantidad
  }

  method sueldoValido(sueldo) = sueldo >= plataQueQuiereGanar

  method ganarFelicidad(felicidad) {
    nivelDeFelicidad += felicidad
  }

  method esFeliz() = 
    nivelDeFelicidad > sueniosPendientes.sum{ suenio => suenio.felicidadQueOtorga() }
  
  method esAmbiciosa() = 
    3 < (sueniosPendientes + sueniosCumplidos).count{ suenio => suenio.felicidadQueOtorga() > 100}


}
