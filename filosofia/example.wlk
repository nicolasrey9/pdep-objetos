class Filosofo {
  const nombre
  const honorificos
  var property nivelIluminacion
  const actividades = []
  var edad 
  var dias
  const property argumentosPresentados = []


  method presentarse() = nombre + ", " + honorificos.join(", ") 
  method estaEnLoCorrecto() = nivelIluminacion > 1000
  
  method disminuirNivelIluminacion(nivel) {
    nivelIluminacion -= nivel
  }

  method aumentarNivelIluminacion(nivel) {
    nivelIluminacion += nivel
  }
  
  
  method ganarHonorifco(honorifico) {
    honorificos.add(honorifico)
  }

  method rejuvenecer(unosDias) {
    dias -= unosDias
  }

  method vivirDia() {
    actividades.forEach{ actividad => actividad.realizar(self) }
    dias += 1
    self.validarCumpleanios()
  }

  method validarCumpleanios() {
    if(dias == 365) {
      edad += 1
      dias = 0
      if(edad == 60) {
        self.ganarHonorifco("el sabio")
      }
    }
  }
}

// ACTIVIADADES
object tomarVino {
  
  method realizar(unFilosofo) {
    unFilosofo.disminuirNivelIluminacion(10)
    unFilosofo.ganarHonorifico("el borracho")
  } 
}
class JuntarseEnElAgoraCon {
  const otroFilosofo

  method realizar(unFilosofo) {
    unFilosofo.aumentarNivelIluminacion(otroFilosofo.nivelIluminacion() * 0.1)
  } 
}
object admirarElPaisaje {
  method realizar(unFilosofo) { } 
}
class MeditarBajoUnaCascada {
  const metrosDeCascada
  
  method realizar(unFilosofo) {
    unFilosofo.aumentarNivelIluminacion(10 * metrosDeCascada)
  } 
}

class PracticarUnDeporte {const numeroAleatorio = randomUpTo(10)  // Genera un número entre 0 y 10 (inclusive)
print(numeroAleatorio)

  const deporte
  
  method realizar(unFilosofo) {
    unFilosofo.rejuvenecer(deporte.diasQueRejuvenece())
  } 
}

class Deporte {
  const property diasQueRejuvenece
}
const futbol = new Deporte(diasQueRejuvenece = 1)
const polo = new Deporte(diasQueRejuvenece = 2)
const waterpolo = new Deporte(diasQueRejuvenece = 2 * polo.diasQueRejuvenece())


// DISCUSIONES
// argumentos
class Argumento {
  const naturaleza
  const descripcion

  method esEnriquecedor() = naturaleza.esEnriquecedora(self)

  method palabrasEnDescripcion() = descripcion.split(" ").size()

  method ultimaLetraDescripcion() = descripcion.last()
}

object estoica {
  method esEnriquecedora(argumento) = true
}
object moralista {
  method esEnriquecedora(argumento) = argumento.palabrasEnDescripcion() > 9
}
object esceptica {
  method esEnriquecedora(argumento) = argumento.ultimaLetraDescripcion() == '?'
}
object cinica {
  method esEnriquecedora(argumento) = 1.randomUpTo(10) <= 3
}
class NaturalezaCombinada {
  const naturalezas = []

  method esEnriquecedora(argumento) =
    naturalezas.all{ naturaleza => naturaleza.esEnriquecedora(argumento) }
}


class Discusion {
  const unPartido
  const otroPartido

  method esBuena() = self.argumentosEnriquecedores() >= self.cantidadDeArgumentosTotales() * 0.5 


  method cantidadDeArgumentosTotales() = self.argumentosTotales().size()
  method argumentosTotales() = unPartido.argumentosPresentados() + otroPartido.argumentosPresentados()

  method argumentosEnriquecedores() = 
    self.argumentosTotales().count{ argumento => argumento.esEnriquecedor() }.

}

// THE LAST DANCE
class FilosofoContemporaneo inherits Filosofo {
  var property amaAdmirarElPaisaje

  override method nivelIluminacion() {
    if(amaAdmirarElPaisaje) return 5 * super()
    return super()
  }
  
  override method presentarse() = "hola"
}