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
Culqi.public_key = 'INSERTE_SU_LLAVE_PUBLICA'
Culqi.secret_key = 'INSERTE_SU_LLAVE_PRIVADA'

$rsa_id = 'INSERTE_SU_RSA_ID'
$rsa_key = 'INSERTE_SU_LLAVE_RSA'
```

Reemplaza los placeholders localmente por tus propias llaves de prueba (`pk_test_` y `sk_test_`) y, si usas encriptación, por tu ID y llave pública RSA. No hagas commit de credenciales. Mantén la llave privada exclusivamente en el backend. La demo hace llamadas reales a Culqi.

## Configuración frontend
Para configurar los datos del cargo, pk del comercio, rsa_id, rsa_public_key y datos del cliente se tiene que modificar en el archivo `js/config/index.js`.

```js
export default Object.freeze({
  TOTAL_AMOUNT: 600,
  CURRENCY: "PEN",
  PUBLIC_KEY: "INSERTE_SU_LLAVE_PUBLICA",
  COUNTRY_CODE: "PE",
  RSA_ID: "INSERTE_SU_RSA_ID",
  RSA_PUBLIC_KEY: "INSERTE_SU_LLAVE_RSA",
});
```

## Inicializar la demo
Ejecutar el siguiente comando:

```bash
ruby server.rb
```

## Probar la demo

Para poder visualizar el frontend de la demo ingresar a la siguiente URL:

- Para probar cargos: http://localhost:8000
- Para probar creación de cards: http://localhost:8000/index_card.html

## Documentación

- [Referencia de Documentación](https://docs.culqi.com/)
- [Referencia de API](https://apidocs.culqi.com/)
