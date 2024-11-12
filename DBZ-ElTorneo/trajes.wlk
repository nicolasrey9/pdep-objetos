class Traje {
  const property aumentoDeExperiencia = 1
  var desgaste = 0
  const valorMaximoDesgaste = 100
  
  method recibirAtaque(potencial, guerrero) {
    if (!self.estaGastado()) {
      guerrero.disminuirEnergia(self.danioRecibido(potencial))
      guerrero.aumantarExpericnecia(self.aumentoDeExperiencia())
      self.desgastarse()
    }
  }
  
  method estaGastado() = desgaste >= valorMaximoDesgaste
  
  method desgastarse() {
    desgaste += 5
  }
  
  method danioRecibido(potencial)
}

class TrajeComun inherits Traje {
  const porcentajeDeReduccion
  
  override method danioRecibido(potencial) = potencial * (1 - porcentajeDeReduccion)
}

object aumentoTrajeEntrenamiento {
  const property porcentajeExp = 2
}

class TrajeDeEntrenamiento inherits Traje {
  override method danioRecibido(potencial) = potencial
  
  override method aumentoDeExperiencia() = aumentoTrajeEntrenamiento.porcentajeExp() * super()
}

class TrajeModularizado inherits Traje{
  const piezas = []
  
  override method desgastarse() {}

  override method danioRecibido(potencial) = 1 - piezas.sum{ pieza => pieza.resistencia() }

  override method aumentoDeExperiencia() = piezas.size() - self.cantidadPiezasGastadas()
  
  method cantidadPiezasGastadas() = piezas.count{ pieza => pieza.estaGastada() } 

  override method estaGastado() = piezas.all{ pieza => pieza.estaGastada() }

}

class Pieza {
  var desgaste = 0
  const resistencia
  
  method resistencia() = if (!self.estaGastada()) resistencia else 0
  
  method estaGastada() = desgaste >= 20
}