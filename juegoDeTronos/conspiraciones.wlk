class Conspiracion {
    const enContra
    const complotados
    var fueEjecutada = false

    method initialize() {
      if(! enContra.esPeligroso()) 
        throw new DomainException(message = "no es peligroso")
    }
    method cantidadDeTraidores() = 
        complotados.count{ complotado => complotado.esAliadoDe(enContra) }

    method ejecutar() {
        complotados.forEach{ complotado => complotado.complotarContra(enContra)}
        fueEjecutada = true
    }
    method objetivoCumplido() = 
        if(fueEjecutada) ! enContra.esPeligroso()
}