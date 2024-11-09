import asadito.comidas.*
import asadito.personas.*

// POSICIONES
class Posicion {
  const property cosasCercanas = []
  const property numero

  method perderCosa(cosa) {
    cosasCercanas.remove(cosa)    
  }
  method ganarCosa(cosa) {
    cosasCercanas.add(cosa)
  }

  method tieneCerca(cosa) = cosasCercanas.contains(cosa)

  method cantidadCosasCerca() = cosasCercanas.size()

  method estaEn(numeroPosicion) = numero == numeroPosicion  
}


// CRITERIOS
class CriterioQuePasa {
  method comoEnviar(emisor, cosasCercanas, cosa, receptor)
  method realizarEnvio(cosa, emisor, receptor) {
    receptor.recibirCosa(cosa)
    emisor.dejarCosa(cosa)
  }
}

object sordo inherits CriterioQuePasa {
  override method comoEnviar(emisor, cosasCercanas, cosa, receptor) {
    const cosaRandom = cosasCercanas.anyOne()
    self.realizarEnvio(cosaRandom, emisor, receptor)
  }
}
object pasaTodo inherits CriterioQuePasa {
  override method comoEnviar(emisor, cosasCercanas, cosa, receptor) {
    cosasCercanas.forEach { 
      unaCosa => 
      self.realizarEnvio(unaCosa, emisor, receptor)
    }
  }
}
object pasaElObjeto inherits CriterioQuePasa {
  override method comoEnviar(emisor, cosasCercanas, cosa, receptor) {
    self.realizarEnvio(cosa, emisor, receptor)
  }
}
object cambiaPosicion {
  method comoEnviar(emisor, cosasCercanas, cosa, receptor) {
    const posicionEmisor = emisor.posicion()
    emisor.posicion(receptor.posicion())
    receptor.posicion(posicionEmisor)
  }
}