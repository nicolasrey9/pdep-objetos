object pepita {
  var energia = 100
  var lugar = llavallol

  method energia() = energia

  method volar(kilometros) {
    energia = energia - (kilometros + 10) 
  }

  method comer(gramos) {
    energia = energia + 4 * gramos
  }

  method lugar(destino) {
    self.volar(self.distanciaA(destino))
    lugar = destino
  }

  method distanciaA(destino) = (lugar.kilometraje() - destino.kilometraje()).abs()
  
  method puedeIr(unLugar) = self.leDaPara(self.distanciaA(unLugar))

  method leDaPara(distancia) =  self.energia() > distancia + 10
  
}

object llavallol {
  const kilometraje = 0

  method kilometraje() = kilometraje
}

object turdera {
  const kilometraje = 100

  method kilometraje() = kilometraje
}

object lomas {
  const kilometraje = 300

  method kilometraje() = kilometraje
}