# DEMO - Culqi Ruby + Checkout V4 + Culqi 3DS

La demo integra Culqi Ruby, Checkout V4 , Culqi 3DS y es compatible con la v2.0 del Culqi API, con esta demo podrás generar tokens, cargos, clientes, cards.

## Requisitos

- Ruby 3.0.0+
- Afiliate [aquí](https://afiliate.culqi.com/).
- Si vas a realizar pruebas obtén tus llaves desde [aquí](https://integ-panel.culqi.com/#/registro), si vas a realizar transacciones reales obtén tus llaves desde [aquí](https://mipanel.culqi.com/#/registro).

> Recuerda que para obtener tus llaves debes ingresar a tu CulqiPanel > Desarrollo > ***API Keys***.

![alt tag](http://i.imgur.com/NhE6mS9.png)

> Recuerda que las credenciales son enviadas al correo que registraste en el proceso de afiliación.

* Para encriptar el payload debes generar un id y llave RSA  ingresando a CulqiPanel > Desarrollo  > RSA Keys.

## Instalación

Ejecuta los siguientes comandos:

```bash
gem install bundler
bundle install
```

## Configuración backend

En el archivo **server.rb** coloca tus llaves:

```ruby
$encrypt = '0'
Culqi.public_key = 'Llave pública del comercio (pk_test_xxxxxxxxx)'
Culqi.secret_key = 'Llave secreta del comercio (sk_test_xxxxxxxxx)'

$rsa_id = "Id de la llave RSA"
$rsa_key = 'Llave pública RSA que sirve para encriptar el payload de los servicios'
```


## Configuración frontend
Para configurar los datos del cargo, pk del comercio, rsa_id, rsa_public_key y datos del cliente se tiene que modificar en el archivo `static/js/config/index.js`.

```js
Culqi.publicKey = config.PUBLIC_KEY;

Culqi.settings({
	title: "Culqi 3DS TEST",
	order: jsonParams.orderId,
	currency: config.CURRENCY,
	description: "Polo/remera Culqi lover",
	amount: config.TOTAL_AMOUNT,
	xculqirsaid: config.RSA_ID,
	rsapublickey: config.RSA_PUBLIC_KEY
});
```

## Inicializar la demo
Ejecutar el siguiente comando:

```bash
ruby server.rb
```

## Probar la demo

Para poder visualizar el frontend de la demo ingresar a la siguiente URL:

- Para probar cargos: http://localhost:8080
- Para probar creación de cards: http://localhost:8080/index_card.html

## Documentación

- [Referencia de Documentación](https://docs.culqi.com/)
- [Referencia de API](https://apidocs.culqi.com/)
