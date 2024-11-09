object realista {
    method elegirSuenio(suenios) = 
        suenios.max{ suenio => suenio.felicidadQueOtorga() }
}

object alocado {
    method elegirSuenio(suenios) = suenios.anyOne()

}

object obsesivo {
    method elegirSuenio(suenios) = suenios.first()
}