class Empleado {
    var property salud
    var property habilidades
    var property tipoEmpleado

    method saludCritica()

    method estaIncapacitado() = salud < tipoEmpleado.saludCritica()

    method puedeUsar(unaHabilidad) {
      self.validarSiNoEstaIncapacitado()
      return habilidades.contains(unaHabilidad)
    }

    method validarSiNoEstaIncapacitado() {
      if(self.estaIncapacitado()) throw new DomainException(message = "esta incapacitado")
    }

    method cumplirMision(unaMision) {
        if(self.reuneHabilidadesDe(unaMision)) {
            self.recibirDanio(unaMision.peligrosidad())
            self.finalizarMision(unaMision)
        }
    }

    method finalizarMision(unaMision) {
        if(self.estaVivo()) {
          tipoEmpleado.completoMision(self, unaMision)
        }
    }

    method reuneHabilidadesDe(unaMision) = unaMision.habilidadesRequeridas().all{ habilidad => habilidades.contains(habilidad)}

    method recibirDanio(unDanio) {
        salud -= unDanio
    }

    method estaVivo() = salud > 0

    method aprenderHabilidades(unasHabilidades) {
      habilidades = habilidades.union(unasHabilidades)
    }

}

object espia {
    method saludCritica() = 15

    method completoMision(unEmpleado, unaMision) {
        unEmpleado.aprenderHabilidades(unaMision.habilidadesRequeridas())
    }
}

class Oficinista {
    var property cantidadEstrellas
    
    method saludCritica() = 40 - 5 * cantidadEstrellas

    method completoMision(unEmpleado, _) {
        cantidadEstrellas += 1
        self.validarAcensoAEspia(unEmpleado)
    }

    method validarAcensoAEspia(unEmpleado) {
        if(cantidadEstrellas >= 3) unEmpleado.tipoEmpleado(espia)
    }
}

class Jefe inherits Empleado {
    const property subordinados

    override method puedeUsar(unaHabilidad) {
     return super() || subordinados.any{ subordinado => subordinado.puedeUsar(unaHabilidad)}
    }
}


class Equipo {
    const miembros

    method cumplirMision(unaMision) {
        if(self.reunenHabilidadesDe(unaMision)) {
            self.afectarMiembros{ miembro => miembro.recibirDanio(unaMision.peligrosidad() / 3)}
            self.afectarMiembros{ miembro => miembro.finalizarMision(unaMision)}
        }
    }

    method afectarMiembros (efecto) {
        miembros.forEach(efecto)
    }

    method reunenHabilidadesDe(unaMision) =  
      miembros.any{ miembro => miembro.reunenHabilidadesDe(unaMision)}
}


class Mision {
    const property habilidadesRequeridas
    const property peligrosidad
}