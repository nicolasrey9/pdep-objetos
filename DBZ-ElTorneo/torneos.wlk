class Torneo {
    const modalidad

    method participantes() = modalidad.participantesElegidos()
}

object powerlBest {
    method participantesElegidos() = []
}
object funny {
    method participantesElegidos() = []
}
object surprise {
    method participantesElegidos() = []
}

object participantes {
    const participantesTotales = []

    method filtrar16Segun(nestor) = self.filtrarSegun(nestor).take(16)

    method filtrarSegun(nestor) = participantesTotales.sortedBy(nestor)

    method ordenarPorPoder() = participantesTotales.sortedBy{ p1,p2 => p1.poder}

}

