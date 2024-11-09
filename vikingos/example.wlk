// VIKINGOS
class Vikingo {
  var property castaSocial
  const armas


  method esProductivo()
  method puedeSubirSegunCasta() = castaSocial.puedeSubir(self)
  method tieneArmas() = ! armas.isEmpty()

  method ganarBotinAscenso() 

  method escalarSocialmente() {
    castaSocial.ascender(self)    
  }
}

class Soldado inherits Vikingo {
  var vidasCobradas
  
  override method esProductivo() = vidasCobradas > 20 && self.tieneArmas() 

  override method ganarBotinAscenso() {
    10.times{ armas.add(arma) }
  }

}

class Granjero inherits Vikingo {
  var cantidadDeHijos
  var hectareas

  override method esProductivo() = hectareas * 2 > cantidadDeHijos

  override method ganarBotinAscenso() {
    cantidadDeHijos += 2
    hectareas += 2
  }
  
}

object arma {

}

// CASTAS SOCIALES
class ClaseSocial {
  method puedeSubir(unVikingo) = true

  method ascender(unVikingo)
}
object jarl inherits ClaseSocial{
  override method puedeSubir(unVikingo) = ! unVikingo.tieneArmas() 

  override method ascender(unVikingo) {
    unVikingo.castaSocial(karl)
    unVikingo.ganarBotinAscenso()
  }
}

object karl inherits ClaseSocial{
  override method ascender(unVikingo) {
    unVikingo.castaSocial(thrall)
  }
}

object thrall inherits ClaseSocial{
  override method ascender(unVikingo) {

  }
}

// EXPEDICIONES
class Expedicion {
  const objetivos
  const vikingos

  method puedeSubir(unVikingo) = unVikingo.esProductivo() && unVikingo.puedeSubirSegunCasta()
  method valeLaPena() = objetivos.all{ objetivo => objetivo.valeLaPena(self) }


  method cantidadVikingos() = vikingos.size()
  method vidasCobradas() = self.cantidadVikingos() 
  method sedDeSaqueo() = 15

  method realizar()

}


// ALDEAS Y CAPITALES
class Capital {
  const factorDeRiqueza

  method valeLaPena(unaExpedicion) = self.botinDe(unaExpedicion) > unaExpedicion.cantidadVikingos() * 3

  method botinDe(unaExpedicion) = unaExpedicion.vidasCobradas() * factorDeRiqueza

}

class Aldea {
  var property cantidadDeCrucifijos

  method valeLaPena(unaExpedicion) = self.botinDe() > unaExpedicion.sedDeSaqueo()

  method botinDe() = cantidadDeCrucifijos
}

class AldeaAmurallada inherits Aldea {
  const cantidadMinima

  override method valeLaPena(unaExpedicion) =  unaExpedicion.cantidadVikingos() >= cantidadMinima && super(unaExpedicion)

}

