enum EstadoPedido {
    case procesando
    case enviado
    case entregado
}

protocol NotificacionPedido {
    func notificarCambioDeEstado(nuevoEstado: EstadoPedido)
}

class Pedido {
    var estado: EstadoPedido
    var delegado: NotificacionPedido?

    init(estado: EstadoPedido) {
        self.estado = estado
    }

    func cambiarEstado(nuevoEstado: EstadoPedido) {
        estado = nuevoEstado
        if let delegado = delegado {
            delegado.notificarCambioDeEstado(nuevoEstado: nuevoEstado)
        }
    }
}

class GestorPedido: NotificacionPedido {
    func notificarCambioDeEstado(nuevoEstado: EstadoPedido) {
        print("El estado del pedido ha cambiado a: \(nuevoEstado)")
    }
}

let gestor = GestorPedido()
let pedido = Pedido(estado: .procesando)
pedido.delegado = gestor
pedido.cambiarEstado(nuevoEstado: .enviado)
