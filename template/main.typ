#import "../invoice-maker.typ": *

// TODO: Handle reverse charges correctly

#show: invoice.with(
  language: "de", // or "fr", "en" (italian contribution is welcome!)
  currency: "CHF", // CHF, EUR, €
  title: "Rechnung",
  banner-image: image("banner.png", width: 12em),
  invoice-id: "custom-id-1234", // optional, auto-generated with date if not specified
  // cancellation-id: "2024-03-24t210835,  // Uncomment this to create a cancellation invoice
  issuing-date: "2024-03-10",
  delivery-date: "2024-02-29",
  due-date: "2024-03-20",
  vat: 0, // or 0.081
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
      date: "2016-04-03",
      description: "Arc reactor",
      // dur-min: 0, Either specify `dur-min` or `quantity` & `price`
      quantity: 1,
      price: 13000,
    ),
    (
      date: "2016-04-05",
      description: "Building flux capacitor",
      dur-min: 120,
    ),
    (
      date: "2016-04-08",
      description: "Sonic screwdriver",
      dur-min: 0,
      quantity: 10,
      price: 800,
    ),
  ),
  qr_opts: (
    // required
    account: "CH4431999123000889012",
    creditor-name: "Maximilian Muster & Söhne",
    creditor-street: "Musterstrasse",
    creditor-building: "123",
    creditor-postal-code: "8000",
    creditor-city: "Seldwyla",
    creditor-country: "CH",
    reference-type: "QRR",  // QRR, SCOR, or NON
    reference: "210000000003139471430009017",
    // optional
    debtor-name: "Simon Muster",
    debtor-street: "Musterstrasse",
    debtor-building: "1",
    debtor-postal-code: "8000",
    debtor-city: "Seldwyla",
    debtor-country: "CH",
    additional-info: "Bestellung vom 15.10.2020",
  ),
)
