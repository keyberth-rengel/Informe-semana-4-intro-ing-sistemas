Algoritmo DulceFantasia
	Definir menu_opcion Como Entero
	Definir nombre_cliente, caja_actual, dni_cliente Como Cadena
	Definir total_compra Como Real
	Dimensionar servicios(20)
	Dimensionar total_por_caja(3)
	Dimensionar ventas_por_caja(3)
	Definir num_servicios, num_comprobante Como Entero
	num_servicios <- 1
	num_comprobante <- 1
	Escribir '----------------------------------------------'
	Escribir '         Bienvenido a Dulce Fantasía          '
	Escribir '      Disfrute de nuestras instalaciones  	 '
	Escribir '----------------------------------------------'
	Para i<-1 Hasta 3 Con Paso 1 Hacer
		total_por_caja[i] <- 0
		ventas_por_caja[i] <- 0
	FinPara
	Repetir
		menu_opcion <- MenuPrincipal(caja_actual)
		Según menu_opcion Hacer
			1, 2, 3:
				SolicitarDatosCliente(nombre_cliente,dni_cliente)
				ManejoDeDatos(menu_opcion,servicios,num_servicios,total_compra,num_comprobante,total_por_caja,ventas_por_caja,caja_actual,nombre_cliente,dni_cliente)
			4:
				MostrarBalanceCajas(total_por_caja,ventas_por_caja)
			5:
				Escribir 'Gracias por usar Dulce Fantasía'
			De Otro Modo:
				Escribir 'Opción no válida, por favor intente de nuevo.'
		FinSegún
	Hasta Que menu_opcion=5
FinAlgoritmo

Función menu_opcion <- MenuPrincipal(caja_actual Por Referencia)
	Definir menu_opcion Como Entero
	Escribir ''
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir '  Elija una de nuestras cajas para continuar  '
	Escribir '----------------------------------------------'
	Escribir '1 - Caja preferencial'
	Escribir '2 - Caja normal'
	Escribir '3 - Caja rápida'
	Escribir '4 - Ver balance de cada caja'
	Escribir '5 - Salir'
	Leer menu_opcion
	Según menu_opcion Hacer
		1:
			caja_actual <- 'Caja preferencial'
		2:
			caja_actual <- 'Caja normal'
		3:
			caja_actual <- 'Caja rápida'
	FinSegún
FinFunción

Función SolicitarDatosCliente(nombre_cliente Por Referencia,dni_cliente Por Referencia)
	Escribir ''
	Escribir ''
	Escribir 'Desea ingresar su nombre y DNI? (S/N):'
	Definir respuesta Como Cadena
	Leer respuesta
	Si respuesta='S' O respuesta='s' Entonces
		Escribir 'Ingrese su nombre:'
		Leer nombre_cliente
		Escribir 'Ingrese su DNI:'
		Leer dni_cliente
	FinSi
FinFunción

Función ManejoDeDatos(indice_caja Por Valor,servicios Por Referencia,num_servicios Por Referencia,total_compra Por Referencia,num_comprobante Por Referencia,total_por_caja Por Referencia,ventas_por_caja Por Referencia,caja_actual Por Valor,nombre_cliente Por Valor,dni_cliente Por Valor)
	SeleccionarServicio(servicios,num_servicios,total_compra)
	ImprimirComprobante(num_comprobante,total_compra,nombre_cliente,caja_actual,servicios,num_servicios,ventas_por_caja,indice_caja,nombre_cliente,dni_cliente)
	total_por_caja[indice_caja] <- total_por_caja[indice_caja]+total_compra
	ventas_por_caja[indice_caja] <- ventas_por_caja[indice_caja]
	total_compra <- 0
	num_servicios <- 1
	LimpiarArregloServicios(servicios)
FinFunción

Función SeleccionarServicio(servicios Por Referencia,num_servicios Por Referencia,total_compra Por Referencia)
	Definir servicio Como Entero
	Repetir
		Escribir ''
		Escribir ''
		Escribir '----------------------------------------------'
		Escribir 'Seleccione el servicio que desea adquirir:'
		Escribir '----------------------------------------------'
		Escribir '1 - Show infantil.                 S/. 140'
		Escribir '2 - Hora loca.                     S/. 200'
		Escribir '3 - Show de Baby Shower.           S/. 180'
		Escribir '4 - Decoración.                    S/. 350'
		Escribir '5 - Finalizar compra'
		Leer servicio
		Si servicio>=1 Y servicio<=4 Entonces
			servicios[num_servicios] <- servicio
			total_compra <- total_compra+ObtenerPrecio(servicio)
			num_servicios <- num_servicios+1
		SiNo
			Si servicio=5 Y num_servicios>1 Entonces
				ElegirMetodoDePago()
			FinSi
		FinSi
	Hasta Que servicio=5
FinFunción

Función resultado <- ObtenerPrecio(servicio Por Valor)
	Definir resultado Como Entero
	Según servicio Hacer
		1:
			resultado <- 140
		2:
			resultado <- 200
		3:
			resultado <- 180
		4:
			resultado <- 350
		De Otro Modo:
			resultado <- 0
	FinSegún
FinFunción

Función ElegirMetodoDePago
	Definir metodo_pago Como Entero
	Escribir ''
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir 'Elija el método de pago:'
	Escribir '----------------------------------------------'
	Escribir '1 - Efectivo'
	Escribir '2 - Tarjeta de débito'
	Escribir '3 - Tarjeta de crédito'
	Leer metodo_pago
	Según metodo_pago Hacer
		1:
			PagoEnEfectivo()
		2:
			PagoConTarjeta('débito')
		3:
			PagoConTarjeta('crédito')
		De Otro Modo:
			Escribir 'Opción no válida, por favor elija un método de pago válido.'
			ElegirMetodoDePago()
	FinSegún
FinFunción

Función PagoEnEfectivo
	Escribir ''
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir 'Ha elegido pagar en efectivo.'
	Escribir '----------------------------------------------'
	Escribir ''
	Escribir 'Procesando pago...'
	Escribir 'Transacción completada. Entregue el comprobante al cliente. ¡Gracias!'
FinFunción

Función PagoConTarjeta(tipo_tarjeta Por Valor)
	Escribir ''
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir 'Ha elegido pagar con tarjeta de ', tipo_tarjeta, '.'
	Escribir '----------------------------------------------'
	Escribir 'Por favor, solicite al cliente que inserte su tarjeta y digite su PIN.'
	Si tipo_tarjeta='crédito' Entonces
		Escribir ''
		Escribir 'Ingrese el número de cuotas para el pago:'
		Definir cuotas Como Entero
		Leer cuotas
		Escribir 'Procesando el pago en ', cuotas, ' cuotas...'
	FinSi
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir 'Numero de tarjeta **** **** **** ****'
	Escribir 'PIN ****'
	Escribir '----------------------------------------------'
	Escribir ''
	Escribir ''
	Escribir 'Conectando con el banco proveedor...'
	Escribir ''
	Escribir 'Verificando datos...'
	Escribir ''
	Escribir 'Datos verificados con exito'
	Escribir ''
	Escribir 'Conectando con el emisor...'
	Escribir ''
	Escribir 'Transacción completada. Entregue el comprobante al cliente. ¡Gracias!'
FinFunción

Función ImprimirComprobante(num_comprobante Por Referencia,total_compra Por Valor,nombre_cliente Por Valor,caja_actual Por Valor,servicios Por Referencia,num_servicios Por Valor,ventas_por_caja Por Referencia,indice_caja Por Valor,nombre_cliente Por Valor,dni_cliente Por Valor)
	Si num_servicios>1 Entonces
		Definir i Como Entero
		Escribir ''
		Escribir 'Imprimiendo comprobante, espere un segundo por favor...'
		Escribir ''
		Escribir '----------------------------------------------'
		Escribir '          COMPROBANTE DE VENTA                '
		Escribir '----------------------------------------------'
		Escribir 'Número de comprobante: 0000', num_comprobante
		num_comprobante <- num_comprobante+1
		ventas_por_caja[indice_caja] <- ventas_por_caja[indice_caja]+1
		Si  NO (nombre_cliente)=('') Entonces
			Escribir '----------------------------------------------'
			Escribir '             DATOS DEL CLIENTE                '
			Escribir '----------------------------------------------'
			Escribir 'Nombre del cliente: ', nombre_cliente
			Escribir 'DNI del cliente: ', dni_cliente
			Escribir '----------------------------------------------'
		FinSi
		Escribir 'Fecha y Hora: ', FechaHoraActual()
		Escribir 'Caja: ', caja_actual
		Escribir '----------------------------------------------'
		Escribir 'Servicios Contratados:'
		Para i<-1 Hasta num_servicios Con Paso 1 Hacer
			Según servicios[i] Hacer
				1:
					Escribir '- Show infantil         S/. 140'
				2:
					Escribir '- Hora loca             S/. 200'
				3:
					Escribir '- Show de Baby Shower   S/. 180'
				4:
					Escribir '- Decoración            S/. 350'
			FinSegún
		FinPara
		Escribir '----------------------------------------------'
		Escribir 'IGV(18%)                S/. ', total_compra*0.18
		Escribir 'Sub total a pagar       S/. ', total_compra*0.82
		Escribir 'Total a pagar           S/. ', total_compra
		Escribir 'Gracias por su compra, ¡vuelva pronto!'
		Escribir '----------------------------------------------'
		Escribir ''
		Escribir ''
	FinSi
FinFunción

Función fecha <- FechaHoraActual
	fecha <- '24/04/2024 14:30'
FinFunción 

Función LimpiarArregloServicios(servicios Por Referencia)
	Para i<-1 Hasta 20 Con Paso 1 Hacer
		servicios[i] <- 0
	FinPara
FinFunción

Función MostrarBalanceCajas(total_por_caja Por Referencia,ventas_por_caja Por Referencia)
	Escribir ''
	Escribir '----------------------------------------------'
	Escribir 'Balance de ventas por cada caja:'
	Escribir ''
	Escribir 'Nombre              Ventas    Total'
	Escribir 'Caja Preferencial     ', ventas_por_caja[1], '       S/. ', total_por_caja[1]
	Escribir 'Caja Normal           ', ventas_por_caja[2], '       S/. ', total_por_caja[2]
	Escribir 'Caja Rápida           ', ventas_por_caja[2], '       S/. ', total_por_caja[3]
	Escribir '----------------------------------------------'
FinFunción
