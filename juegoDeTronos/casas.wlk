import personajes.*
// CASAS
class Casa {
  var property patrimonio = 100
  var property miembros = []

  method patrimonioDe(miembro) = patrimonio / miembros.size()

  method esRica() = patrimonio > 1000 

  method admiteCasamiento(miembro, otro)

  method pretendiente() = 
    miembros.find{ 
      alguien => alguien.noTienePareja() && alguien.estaVivo()
    }

  method gastar(dinero) {
    patrimonio -= dinero
  }
}

object lennister inherits Casa {
  override method admiteCasamiento(miembro, otro) =
    miembro.noTienePareja()
}
object stark inherits Casa {
  override method admiteCasamiento(miembro, otro) =
    miembro.casa() != otro.casa()
}
object guardiaDeLaNoche inherits Casa {
  override method admiteCasamiento(miembro, otro) = false
}
