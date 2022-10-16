# Youtube API Client

## Resources

- Video Categories
- Videos
- Comments

## Elements

- video category
  - id
  - snippet
    - title
    - channel id
- video
  - id
  - snippet
    - published at
    - channel id
    - title
    - description
    - thumbails
      - url
      - width
      - height
    - channel title
    - list of tags
    - category id
    - live broadcast content
    - localized
      - title
      - description
- comment
  - id
  - snippet
    - video id
    - top level comment
      - id
        - snippet
          - video id
          - text display
          - text original
          - author display name
          - author profiile image url
          - author channel url
          - author channel id
          - can rate
          - viewer rating
          - published at
          - updated at
    - can reply
    - replies
      - comments
        - id
        - snippet
          - video id
          - text display
          - text original
          - author display name
          - author profiile image url
          - author channel url
          - author channel id
          - can rate
          - viewer rating
          - published at
          - updated at

## Entities

These are objects that are important to the project:

- Video
- Category
- Comment

# Mexican Central Bank API Client


## Resources
** Some examples of indicators:

- Exchange rate historical series U.S. dollar - MXN exchange rate since 1954 (SF63528)
- Indice Nacional de Precios al consumidor Variación mensual (SP30577)

## Elements

- Exchange Rate
{
    "bmx": {
        "series": [
            {
                "idSerie": "SF63528",
                "titulo": "Serie histórica del tipo de cambio Tipo de cambio peso dólar desde 1954",
                "fechaInicio": "19/04/1954",
                "fechaFin": "14/10/2022",
                "periodicidad": "Diaria",
                "cifra": "Tipo de Cambio",
                "unidad": "Pesos por Dólar",
                "versionada": false
            }
        ]
    }
}

-INPC

{
    "bmx": {
        "series": [
            {
                "idSerie": "SP30577",
                "titulo": "Índice Nacional de Precios al consumidor Variación mensual",
                "fechaInicio": "01/01/1969",
                "fechaFin": "01/09/2022",
                "periodicidad": "Mensual",
                "cifra": "Porcentajes",
                "unidad": "Sin Unidad",
                "versionada": false
            }
        ]
    }
}

## Entities

exchange_rate
inpc
