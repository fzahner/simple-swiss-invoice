#import "../invoice-maker.typ": *

// TODO: Handle reverse charges correctly

#show: invoice.with(
  language: "de", // or "de"
  banner-image: image("banner.png"),
  title: "Beispielsrechnung mit längerem Titel",
  // // Uncomment this to create a cancellation invoice
  // cancellation-id: "2024-03-24t210835",
  issuing-date: "2024-03-10",
  delivery-date: "2024-02-29",
  vat: 0, // 0.081,
  due-date: "2024-03-20",
  biller: (
    name: "Gyro Gearloose",
    title: "Inventor",
    company: "Crazy Inventions Ltd.",
    iban: "DE89370400440532013000",
    address: (
      country: "Disneyland",
      city: "Duckburg",
      postal-code: "123456",
      street: "Inventor Drive 23",
    ),
  ),
  recipient: (
    name: "Scrooge McDuck",
    title: "Treasure Hunter",
    address: (
      country: "Disneyland",
      city: "Duckburg",
      postal-code: "123456",
      street: "Killmotor Hill 1",
    )
  ),
  hourly-rate: 100, // For any items with `dur-min` but no `price`
  items: (
    (
      // number: 3, // You can also specify a custom item number
      date: "2016-04-03",
      description: "Arc reactor",
      // dur-min: 0, Either specify `dur-min` or `quantity` & `price`
      quantity: 1,
      price: 13000,
    ),
    (
      date: "2016-04-05",
      description: "Flux capacitor",
      dur-min: 0,
      quantity: 1,
      price: 27000,
    ),
    (
      date: "2016-04-07",
      description: "Lightsaber",
      dur-min: 0,
      quantity: 2,
      price: 3600,
    ),
    (
      date: "2016-04-08",
      description: "Sonic screwdriver",
      dur-min: 0,
      quantity: 10,
      price: 800,
    ),
  ),
)
