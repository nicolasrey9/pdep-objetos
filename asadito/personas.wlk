import asadito.pasarYPosiciones.*
import asadito.comidas.*

class Persona {
  var property posicion
  var property criterioPasar
  var property criterioComida
  const comidasIngeridas = []


  method pedirCosa(cosa, persona) {
    self.validarQuePosee(cosa)
    criterioPasar.comoEnviar(self, posicion.cosasCercanas(), cosa, persona)
  }
  method recibirCosa(cosa) {
    posicion.ganarCosa(cosa) 
  }
  method dejarCosa(cosa) = posicion.perderCosa(cosa)

  method validarQuePosee(cosa) {
    if(! posicion.tieneCerca(cosa)) throw new DomainException(message = "no poseo esa cosa")
  }

  method comerSiQuiere(unaComida) {
    if(criterioComida.banca(unaComida)) comidasIngeridas.add(unaComida)
  }

  method estaPipon() = comidasIngeridas.any{ comidaIngerida => comidaIngerida.esPesada() } 

  method laEstaPasandoBien()
}

object osky inherits Persona (posicion = new Posicion(numero = 1), criterioPasar=sordo, criterioComida=vegetariano){
  override method laEstaPasandoBien() = true
}
object moni inherits Persona (posicion = new Posicion(numero = 2), criterioPasar=sordo, criterioComida=vegetariano){
  override method laEstaPasandoBien() = posicion.estaEn(11)
}
object facu inherits Persona (posicion = new Posicion(numero = 3), criterioPasar=sordo, criterioComida=vegetariano){
  override method laEstaPasandoBien() = comidasIngeridas.any{ comida => comida.esCarne() }
}
object vero inherits Persona (posicion = new Posicion(numero = 4), criterioPasar=sordo, criterioComida=vegetariano){
  override method laEstaPasandoBien() = posicion.cantidadCosasCerca() < 3
}