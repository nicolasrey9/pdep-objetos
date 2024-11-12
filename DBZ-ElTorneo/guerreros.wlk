import trajes.*

class Guerrero {
  var property potencialOfensivo
  const energiaOriginal
  var energia = energiaOriginal
  var estaVivo = true
  var experiencia
  var property traje
  
  method atacarA(guerrero) {
    guerrero.recibirAtaque(self.potencialOfensivo())
  }
  
  method recibirAtaque(potencial) {
    traje.recibirAtaque(potencial, self)
  }
  
  method disminuirEnergia(cantidad) {
    energia -= cantidad
    self.validarMuerte()
  }
  
  method aumantarExperiencia(valor) {
    experiencia += valor
  }
  
  method validarMuerte() {
    if (energia == 0) {
      estaVivo = false
    }
  }
  
  method comerSemilla() {
    energia = energiaOriginal
  }
}

class Saiyan inherits Guerrero {
  var property transformacion
  
  override method potencialOfensivo() = transformacion.poder(potencialOfensivo)
  
  override method comerSemilla() {
    potencialOfensivo *= 1.05
    super()
  }
  
  override method disminuirEnergia(cantidad) {
    super(cantidad * (1 - transformacion.resistencia()))
    self.validarTransformacion()
  }
  
  method validarTransformacion() { 
    if (energia < (energiaOriginal * 0.01)) self.destransformarse() 
  }

  method destransformarse() {
    transformacion = estadoOriginal
  }
}

object estadoOriginal {
  method poder(valorBase) = valorBase
  
  method resistencia() = 0
}
class SuperSaiyan {
  method poder(valorBase) = valorBase * 1.5
  
  method resistencia()
}
object superSaiyanNivel1 inherits SuperSaiyan {
  override method resistencia() = 0.05
}
object superSaiyanNivel2 inherits SuperSaiyan {
  override method resistencia() = 0.07
}
object superSaiyanNivel3 inherits SuperSaiyan {
  override method resistencia() =0.15
}




