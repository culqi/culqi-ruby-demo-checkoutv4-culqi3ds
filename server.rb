# frozen_string_literal: true

require 'webrick'
require 'culqi-ruby'

$encrypt = '0'
Culqi.public_key = 'pk_test_e94078b9b248675d'
Culqi.secret_key = 'sk_test_c2267b5b262745f0'

$rsa_key = 'de35e120-e297-4b96-97ef-10a43423ddec'
$rsa_id = "-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDswQycch0x/7GZ0oFojkWCYv+g
r5CyfBKXc3Izq+btIEMCrkDrIsz4Lnl5E3FSD7/htFn1oE84SaDKl5DgbNoev3pM
C7MDDgdCFrHODOp7aXwjG8NaiCbiymyBglXyEN28hLvgHpvZmAn6KFo0lMGuKnz8
HiuTfpBl6HpD6+02SQIDAQAB
-----END PUBLIC KEY-----"


# Crear una subclase de WEBrick::HTTPServlet::FileHandler
class CustomHandler < WEBrick::HTTPServlet::FileHandler
  def initialize(server, dir)
    super(server, dir)
  end

  def do_GET(request, response)
    if request.path =~ /\/js\/.*\.js$/i
      response['Content-Type'] = 'application/javascript'
    else
      response['Content-Type'] = 'text/html'
    end

    super(request, response)
  end
end


# Crear una subclase de WEBrick::HTTPServlet::AbstractServlet para el controlador adicional
class CustomerController < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)


    response['Content-Type'] = 'application/json'

    puts request


    params = JSON.parse(request.body)
    customer, statusCode = Culqi::Customer.create(params)
    response.status = statusCode
    response.body = customer

  end
end

class CardController < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)

    response['Content-Type'] = 'application/json'

    puts request


    params = JSON.parse(request.body)
    if $encrypt == '1'
      card, statusCode = Culqi::Card.create(params, $rsa_key, $rsa_id)
    else
      card, statusCode = Culqi::Card.create(params)
    end

    puts card
    response.body = card
    response.status = statusCode

  end
end

class ChargeController < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    response['Content-Type'] = 'application/json'

    puts request


    params = JSON.parse(request.body)
    if $encrypt == '1'
      charge, statusCode = Culqi::Charge.create(params, $rsa_key, $rsa_id)
    else
      charge, statusCode = Culqi::Charge.create(params)
    end
    puts charge
    response.body = charge
    response.status = statusCode

  end
end

class OrderController < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)


    response['Content-Type'] = 'application/json'

    puts request


    params = JSON.parse(request.body)
    if $encrypt == '1'
      order, statusCode = Culqi::Order.create(params, $rsa_key, $rsa_id)
    else
      order, statusCode = Culqi::Order.create(params)
    end
    puts order
    response.body = order
    response.status = statusCode

  end
end

# Configurar el servidor
server = WEBrick::HTTPServer.new(Port: 8000)

# Establecer el directorio raíz del servidor
server.mount('/', CustomHandler, './')


server.mount('/createCustomer', CustomerController)
server.mount('/createCard', CardController)
server.mount('/generateCharge', ChargeController)
server.mount('/generateOrder', OrderController)

# Manejar señales de interrupción para detener el servidor correctamente
trap('INT') { server.shutdown }

# Iniciar el servidor
server.start

