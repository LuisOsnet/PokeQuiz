# PokeQuiz

https://github.com/user-attachments/assets/62804566-0f14-4fc1-9be5-e452bfd74ae9

**PokeQuiz** es una aplicación web desarrollada con Ruby on Rails 7.1.3.4 y Ruby 3.3.0. El objetivo de la aplicación es proporcionar un juego de preguntas y respuestas temáticas sobre Pokémon, donde los usuarios pueden poner a prueba su conocimiento sobre el mundo Pokémon.

[Demo](https://lo-pokequiz-190a6c36e319.herokuapp.com)

## Requisitos

Antes de comenzar, asegúrate de tener instalados los siguientes requisitos:

- **Ruby** 3.3.0
- **Rails** 7.1.3.4
- **PostgreSQL** 14.11

## Instalación

Sigue estos pasos para configurar y ejecutar la aplicación en tu entorno local:

1. **Clona el repositorio:**

   ```bash
   git clone git@github.com:LuisOsnet/PokeQuiz.git
   cd pokequiz

2. **Instala las dependencias:**

    ```bash
    bundle install
    yarn install

3. **Configura la base de datos:**

    ```bash
    rails db:create
    rails db:migrate

4. **Inicia el servidor:**

    ```bash
    rails server

### Características

Sistema de preguntas y respuestas sobre Pokémon, donde los usuarios pueden intentar adivinar detalles de diferentes Pokémon.
Autenticación de usuarios utilizando Devise para gestionar sesiones y registros.
Interfaz de usuario amigable y responsiva diseñada con Tailwind CSS.
API para gestionar las preguntas y respuestas del juego, permitiendo integración con otras aplicaciones.
Internacionalización (i18n) para soportar múltiples idiomas, comenzando con inglés y español.

### Testing
La aplicación utiliza RSpec para pruebas automatizadas. Para ejecutar las pruebas, usa el siguiente comando

    rails server

### Documentación API

La aplicación incluye documentación de la API generada con Rswag. Para acceder a la documentación, asegúrate de que el servidor esté en ejecución y visita:

    http://localhost:3000/api-docs

### Documentación Técnica

[PokeQuiz Doc.pdf](https://github.com/user-attachments/files/16629272/PokeQuiz.Doc.pdf)

### Documentación de elementos pendientes

[Deuda Técnica.pdf](https://github.com/user-attachments/files/16629464/Deuda.Tecnica.pdf)



