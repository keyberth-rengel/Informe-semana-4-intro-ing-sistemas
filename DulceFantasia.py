def menu_principal(caja_actual):
    print("\n----------------------------------------------")
    print("  Elija una de nuestras cajas para continuar  ")
    print("----------------------------------------------")
    print("1 - Caja preferencial")
    print("2 - Caja normal")
    print("3 - Caja rápida")
    print("4 - Ver balance de cada caja")
    print("5 - Salir")
    menu_opcion = int(input())
    if menu_opcion == 1:
        caja_actual = "Caja preferencial"
    elif menu_opcion == 2:
        caja_actual = "Caja normal"
    elif menu_opcion == 3:
        caja_actual = "Caja rápida"
    return menu_opcion, caja_actual

def solicitar_datos_cliente():
    respuesta = input("\nDesea ingresar su nombre y DNI? (S/N): ").strip().lower()
    nombre_cliente, dni_cliente = None, None
    if respuesta == 's':
        nombre_cliente = input("Ingrese su nombre: ")
        dni_cliente = input("Ingrese su DNI: ")
    return nombre_cliente, dni_cliente

def manejo_de_datos(indice_caja, servicios, num_servicios, total_compra, num_comprobante, total_por_caja, ventas_por_caja, caja_actual, nombre_cliente, dni_cliente):
    servicios, num_servicios, total_compra = seleccionar_servicio(servicios, num_servicios, total_compra)
    imprimir_comprobante(num_comprobante, total_compra, nombre_cliente, caja_actual, servicios, num_servicios, ventas_por_caja, indice_caja, dni_cliente)
    total_por_caja[indice_caja] += total_compra
    total_compra = 0
    num_servicios = 0
    servicios.clear() 
    return servicios, num_servicios, total_compra

def seleccionar_servicio(servicios, num_servicios, total_compra):
    while True:
        print("\n----------------------------------------------")
        print("Seleccione el servicio que desea adquirir:")
        print("----------------------------------------------")
        print("1 - Show infantil.                 S/. 140")
        print("2 - Hora loca.                     S/. 200")
        print("3 - Show de Baby Shower.           S/. 180")
        print("4 - Decoración.                    S/. 350")
        print("5 - Finalizar compra")
        
        try:
            servicio = int(input())
            if 1 <= servicio <= 4:
                servicios.append(servicio)
                total_compra += obtener_precio(servicio)
                num_servicios += 1
            elif servicio == 5:
                if num_servicios > 0:
                    elegir_metodo_de_pago()
                break
        except ValueError:
            print("Por favor, ingrese un número válido.")
    
    return servicios, num_servicios, total_compra


def obtener_precio(servicio):
    precios = {1: 140, 2: 200, 3: 180, 4: 350}
    return precios.get(servicio, 0)

def elegir_metodo_de_pago():
    print("\n----------------------------------------------")
    print("Elija el método de pago:")
    print("----------------------------------------------")
    print("1 - Efectivo")
    print("2 - Tarjeta de débito")
    print("3 - Tarjeta de crédito")
    metodo_pago = int(input())
    if metodo_pago == 1:
        pago_en_efectivo()
    elif metodo_pago == 2:
        pago_con_tarjeta('débito')
    elif metodo_pago == 3:
        pago_con_tarjeta('crédito')
    else:
        print("Opción no válida, por favor elija un método de pago válido.")

def pago_en_efectivo():
    print("\n----------------------------------------------")
    print("Ha elegido pagar en efectivo.")
    print("----------------------------------------------")
    print("Procesando pago...")
    print("Transacción completada. Entregue el comprobante al cliente. ¡Gracias!")

def pago_con_tarjeta(tipo_tarjeta):
    print("\n----------------------------------------------")
    print(f"Ha elegido pagar con tarjeta de {tipo_tarjeta}.")
    print("----------------------------------------------")
    print("Por favor, solicite al cliente que inserte su tarjeta y digite su PIN.")
    if tipo_tarjeta == 'crédito':
        cuotas = int(input("Ingrese el número de cuotas para el pago: "))
        print(f"Procesando el pago en {cuotas} cuotas...")
    print("\n----------------------------------------------")
    print("Numero de tarjeta **** **** **** ****")
    print("PIN ****")
    print("----------------------------------------------")
    print("Conectando con el banco proveedor...")
    print("Verificando datos...")
    print("Datos verificados con éxito")
    print("Conectando con el emisor...")
    print("Transacción completada. Entregue el comprobante al cliente. ¡Gracias!")

def imprimir_comprobante(num_comprobante, total_compra, nombre_cliente, caja_actual, servicios, num_servicios, ventas_por_caja, indice_caja, dni_cliente):
    if num_servicios > 0:
        print("\nImprimiendo comprobante, espere un segundo por favor...")
        print("\n----------------------------------------------")
        print("          COMPROBANTE DE VENTA                ")
        print("----------------------------------------------")
        print(f"Número de comprobante: {str(num_comprobante).zfill(4)}")  # Asegura un ancho de 4 dígitos
        num_comprobante += 1
        ventas_por_caja[indice_caja] += 1
        if nombre_cliente:
            print("\n----------------------------------------------")
            print("          DATOS DEL CLIENTE                     ")
            print("------------------------------------------------")
            print("Nombre del cliente: ", nombre_cliente)
            print("DNI del cliente:    ", dni_cliente)
            print("------------------------------------------------")
        print("Fecha y Hora: ", fecha_hora_actual())
        print("Caja:         ", caja_actual)
        print("------------------------------------------------")
        print("Servicios Contratados:")
        for i in range(num_servicios):
            servicio = servicios[i - 1]
            print(f"- {servicio_descripcion(servicio)}        S/. {obtener_precio(servicio)}")
        print("------------------------------------------------")
        print("IGV(18%)               S/. ", "{:.2f}".format(total_compra*0.18))
        print("Sub total a pagar:     S/. ", "{:.2f}".format(total_compra*0.82))
        print("Total a pagar:         S/. ", total_compra)
        print("Gracias por su compra, ¡vuelva pronto!")

def fecha_hora_actual():
    from datetime import datetime
    return datetime.now().strftime("%d/%m/%Y %H:%M:%S")

def limpiar_arreglo_servicios(servicios):
    return [0] * len(servicios)

def mostrar_balance_cajas(total_por_caja, ventas_por_caja):
    print("\n----------------------------------------------")
    print("Balance de ventas por cada caja:")
    print("Caja Preferencial: Ventas = ", ventas_por_caja[0], "Total S/. =", total_por_caja[0])
    print("Caja Normal:       Ventas = ", ventas_por_caja[1], "Total S/. =", total_por_caja[1])
    print("Caja Rápida:       Ventas = ", ventas_por_caja[2], "Total S/. =", total_por_caja[2])
    print("----------------------------------------------")

def servicio_descripcion(servicio):
    descripciones = {
        1: "Show infantil",
        2: "Hora loca",
        3: "Show de Baby Shower",
        4: "Decoración"
    }
    return descripciones.get(servicio, "Servicio desconocido")

# Ejecución principal
if __name__ == "__main__":
    caja_actual = ""
    nombre_cliente = ""
    dni_cliente = ""
    total_compra = 0
    servicios = []
    total_por_caja = [0, 0, 0]
    ventas_por_caja = [0, 0, 0]
    num_servicios = 0
    num_comprobante = 1

    while True:
        print("----------------------------------------------")
        print("         Bienvenido a Dulce Fantasía          ")
        print("      Disfrute de nuestras instalaciones  	 ")
        print("----------------------------------------------")
        menu_opcion, caja_actual = menu_principal(caja_actual)
        if menu_opcion == 5:
            print("Gracias por usar Dulce Fantasía")
            break
        elif menu_opcion in (1, 2, 3):
            nombre_cliente, dni_cliente = solicitar_datos_cliente()
            servicios, num_servicios, total_compra = manejo_de_datos(menu_opcion - 1, servicios, num_servicios, total_compra, num_comprobante, total_por_caja, ventas_por_caja, caja_actual, nombre_cliente, dni_cliente)
        elif menu_opcion == 4:
            mostrar_balance_cajas(total_por_caja, ventas_por_caja)
        else:
            print("Opción no válida, por favor intente de nuevo.")
