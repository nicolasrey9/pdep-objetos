
import asadito.pasarYPosiciones.*
import asadito.personas.*

// OMS
object oms {
  method recomendacionCalorica() = 500 
}

// COMIDA
class BandejaDeComida {
  const personasEnMesa = []
  const property esCarne
  const property calorias

  method pasar() {
    personasEnMesa.forEach { persona => persona.comerSiQuiere(self) }
  }

  method esPesada() = calorias > 500 
}
// const pechitoDeCerdo = new BandejaDeComida(esCarne = true, calorias = 270)

// CRITERIOS COMIDA
object vegetariano {
  method banca(comida) = ! comida.esCarne()
}

object dietetico {
  method banca(comida) = comida.calorias() <= oms.recomendacionCalorica()
}

class Alternado {
  var ultimaDecision = false

  method banca(comida) {
    ultimaDecision = ! ultimaDecision
    return ! ultimaDecision
  } 
}
class CombinacionDeCondiciones {
  // no entendi como hacerlo
}