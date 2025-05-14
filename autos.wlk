object dominic {
	const autos = []
	
	method comprar(auto) {
		autos.add(auto)
	}
	
	method autosNoEnCondiciones() = autos.filter(
		{ auto => not auto.enCondiciones() }
	)
	
	method autosEnCondiciones() = autos.filter({ auto => auto.enCondiciones() })
	
	method mandarAutosAlTaller() {
		taller.recibirAutos(self.autosNoEnCondiciones())
	}
	
	method realizarPruebasDeVelocidad() {
		autos.forEach({ auto => auto.hacerPrueba() })
	}
	
	method venderAutos() {
		autos.clear()
	}
	
	method promedioVelocidades() = autos.sum(
		{ auto => auto.velocidadMaxima() }
	) / autos.size()
	
	method masRapido() = self.autosEnCondiciones().max(
		{ auto => auto.velocidadMaxima() }
	)
	
	method hayUnAutoMuyRapido() = self.masRapido().velocidadMaxima() > (2 * self.promedioVelocidades())
}

object taller {
	const autosAReparar = []
	
	method recibirAutos(listaDeAutos) {
		autosAReparar.addAll(listaDeAutos)
	}
	
	method repararAutos() {
		autosAReparar.forEach({ auto => auto.reparar() })
		autosAReparar.clear()
	}
}

object ferrari {
	var motor = 87
	
	method enCondiciones() = motor >= 65
	
	method reparar() {
		motor = 100
	}
	
	method velocidadMaxima() = 110 + if (motor > 75) 15 else 0
	
	method hacerPrueba() {
		motor = (motor - 30).max(0)
	}
}

object flecha{
	var cantidadLitrosCombustible = 100
	var color = azul
	var property combustible = gasolina
/*
	El property genera un getter y setter sin definirlos, en este caso:
	method combustible() = combustible
	method combustible(unValor){combustible = unValor}
	Si no tengo el property debo definir esos 2 metodos.
*/

	method enCondiciones() = 
		cantidadLitrosCombustible > combustible.nivelMinimo() && color == rojo
	
	method reparar() {
		cantidadLitrosCombustible = cantidadLitrosCombustible * 2
		color = color.cambiarColor()
	}
	
	method velocidadMaxima() {
		return (cantidadLitrosCombustible * 2) + combustible.calculoAdicional(cantidadLitrosCombustible)
	}
	
	method hacerPrueba() {
		cantidadLitrosCombustible = (cantidadLitrosCombustible - 5).max(0)
	}
}

object gasolina {
	method nivelMinimo(nivel) = 85 
	method calculoAdicional(litros) = 10
}

object nafta {
	method nivelMinimo(nivel) = 50 
	method calculoAdicional(litros) = -1 * ((litros * 2)*0.10) //-1 para restar el 10%
}

object nitrogeno {
	method nivelMinimo(nivel) = 0
	method calculoAdicional(litros) = (litros * 2)*10
}

object azul {
	method cambiarDeColor() = verde
}

object rojo {
	method cambiarDeColor() = azul
}

object verde {
	method cambiarDeColor() = rojo
}

object intocable {
    var property enCondiciones = true
    method hacerPrueba() {enCondiciones = false}
    method reparar() {enCondiciones = true}
    method velocidadMaxima() = 45
}