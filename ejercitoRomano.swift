import Foundation

final class RetoCaso {

	// Método de lectura de la entrada del usuario, en el que solo se permite la entrada de números enteros del 0 al 10000000
	private func lecturaEntrada() -> Int {
		
		while true {
			if let entradaString = readLine(),
			let entrada: Int = Int(entradaString),
			entrada <= 10_000_000,
			entrada >= 0 {
				return entrada
			} else {
				print("Error. Introduce un número entero entre 1 y 10000000 o introduce 0 para salir")
			}
		}
	
	}

	// Método que calcula las formaciones necesarias en función al número total del ejército y devuelve un array con el número 
	// que aplicándole el cuadrado nos da el número total de soldados de la formación. Ej: [5, 3, 1] -> formaciones de 5x5, 3x3 y 1x1
	private func calcularFormaciones(_ numRomanos: Int) -> [Int] {
	
		var formaciones: [Int] = []
		var numRomanosRestantes: Int = 0
		var contadorNumRomanos: Int = 0
		
		for num in stride(from: 3_162, to: 0, by: -1) {

			let cuadradoNum: Int = Int(pow(Double(num),Double(2)))

			if cuadradoNum <= numRomanos {

				let cuadradoNum: Int = Int(pow(Double(num),Double(2)))

				if contadorNumRomanos == numRomanos {
				  break
				} else if cuadradoNum <= numRomanos && numRomanosRestantes == 0 {
				  numRomanosRestantes = numRomanos - cuadradoNum
				  contadorNumRomanos = contadorNumRomanos + cuadradoNum
				  formaciones.append(num)
				} else if cuadradoNum <= numRomanosRestantes {
				  numRomanosRestantes = numRomanosRestantes - cuadradoNum
				  contadorNumRomanos = contadorNumRomanos + cuadradoNum
				  formaciones.append(num)
				}

			}
		}
		
		return formaciones
		
	}
	
	private func calculoEscudos(_ formaciones: [Int]) -> Int {
	
		var escudosTotalesPorFormacion: [Int] = []
		var escudosTotales: Int = 0

		// Cálculo escudos según la posición que ocupa cada romano dentro de cada formación
		for formacion in formaciones {
		
			let numRomanosFormacion: Int = Int(pow(Double(formacion), Double(2)))

			// Los romanos que se encuentran en posición lateral pero sin estar en la esquina deben portar dos escudos
			let escudosLateralesYSinEsquinas: Int = (formacion - 2) * 4 * 2

			// Los romanos que se encuentran en las esquinas deben portar tres escudos
			let escudosEsquinas: Int = 4 * 3

			// Los romanos que se encuentra en la posición interior de la formación romana solo tienen que portar un escudo
			let numRomanosInteriores: Int = numRomanosFormacion - (formacion - 2) * 4 - 4

			let escudosTotalesFormacion: Int = escudosLateralesYSinEsquinas + escudosEsquinas + numRomanosInteriores
			escudosTotalesPorFormacion.append(escudosTotalesFormacion)
		
		}
		
		// Cálculo escudos totales
		for escudosFormacion in escudosTotalesPorFormacion {
			escudosTotales = escudosTotales + escudosFormacion
		}
	
		return escudosTotales
		
	}
	
	// Método que aplica la lógica principal de ejecución del programa
	func retoCaso() {
		while true {
			let numRomanos: Int = lecturaEntrada()
			if numRomanos != 0 {
				print(calculoEscudos(calcularFormaciones(numRomanos)))
			} else {
				break
			}
		}
	} 

}

// Main
let reto: RetoCaso = RetoCaso()
reto.retoCaso()
