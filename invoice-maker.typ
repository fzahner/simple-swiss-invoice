#import "@preview/payqr-swiss:0.4.1": swiss-qr-bill
#let nbh = "‑"

// TODO: Add banner image

// Truncate a number to 2 decimal places
// and add trailing zeros if necessary
// E.g. 1.234 -> 1.23, 1.2 -> 1.20
#let add-zeros = (num) => {
    // Can't use trunc and fract due to rounding errors
    let frags = str(num).split(".")
    let (intp, decp) = if frags.len() == 2 { frags } else { (num, "00") }
    str(intp) + "." + (str(decp) + "00").slice(0, 2)
  }

// From https://stackoverflow.com/a/57080936/1850340
#let verify-iban = (country, iban) => {
    let iban-regexes = (
        DE: regex(
          "^DE[a-zA-Z0-9]{2}\s?([0-9]{4}\s?){4}([0-9]{2})$"
        ),
        FR: regex(
          "^FR[a-zA-Z0-9]{2}\s?([0-9]{4}\s?){5}([0-9]{3})$"
        ),
        GB: regex(
          "^GB[a-zA-Z0-9]{2}\s?([a-zA-Z]{4}\s?){1}([0-9]{4}\s?){3}([0-9]{2})$"
        ),
      )

    if country == none or not country in iban-regexes {
      true
    }
    else {
      iban.find(iban-regexes.at(country)) != none
    }
}

#let parse-date = (date-str) => {
  let parts = date-str.split("-")
  if parts.len() != 3 {
    panic(
      "Invalid date string: " + date-str + "\n" +
      "Expected format: YYYY-MM-DD"
    )
  }
  datetime(
    year: int(parts.at(0)),
    month: int(parts.at(1)),
    day: int(parts.at(2)),
  )
}

#let format-date = (date-str) => {
  let parts = date-str.split("-")
  if parts.len() != 3 {
    panic(
      "Invalid date string: " + date-str + "\n" +
      "Expected format: YYYY-MM-DD"
    )
  }
  let yyyy = parts.at(0)
  let mm = parts.at(1)
  let dd = parts.at(2)
  let mm2 = if mm.len() == 1 { "0" + mm } else { mm }
  let dd2 = if dd.len() == 1 { "0" + dd } else { dd }
  dd2 + "." + mm2 + "." + yyyy
}

#let TODO = box(
  inset: (x: 0.5em),
  outset: (y: 0.2em),
  radius: 0.2em,
  fill: rgb(255,180,170),
)[
  #text(
    size: 0.8em,
    weight: 600,
    fill: rgb(100,68,64)
  )[TODO]
]

#let horizontalrule = [
  #v(8mm)
  #line(
    start: (20%,0%),
    end: (80%,0%),
    stroke: 0.8pt + gray,
  )
  #v(8mm)
]

#let signature-line = line(length: 5cm, stroke: 0.4pt)

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#let languages = (
    en: (
      id: "en",
      country: "CH",
      recipient: "Recipient",
      biller: "Biller",
      invoice: "Invoice",
      cancellation-invoice: "Cancellation Invoice",
      cancellation-notice: (id, issuing-date) => [
        As agreed, you will receive a credit note
        for the invoice *#id* dated *#issuing-date*.
      ],
      invoice-id: "Invoice ID",
      issuing-date: "Issuing Date",
      delivery-date: "Delivery Date",
      items: "Items",
      closing: "Thank you for your business!",
      number: "№",
      date: "Date",
      description: "Description",
      duration: "Duration",
      quantity: "Quantity",
      price: "Price",
      total-time: "Total working time",
      subtotal: "Subtotal",
      discount-of: "Discount of",
      vat: "VAT of",
      no-vat: "Not Subject to VAT",
      total: "Total",
      due-text: val =>
        [Please transfer the money onto following bank account due to *#val*:],
      owner: "Owner",
      iban: "IBAN",
    ),
    fr: (
      id: "fr",
      country: "CH",
      recipient: "Destinataire",
      biller: "Émetteur",
      invoice: "Facture",
      cancellation-invoice: "Annulation de facture",
      cancellation-notice: (id, issuing-date) => [
        Comme convenu, voust recevrez un crédit
        pour la facture *#id* du *#issuing-date*.
      ],
      invoice-id: "Facture N°",
      issuing-date: "Date d’émission",
      delivery-date: "Date de livraison",
      items: "Produits",
      closing: "Merci !",
      number: "N°",
      date: "Date",
      description: "Description",
      duration: "Durée",
      quantity: "Quantité",
      price: "Prix",
      total-time: "Temps total travaillé",
      subtotal: "Sous-total",
      discount-of: "Remise de",
      vat: "TVA",
      no-vat: "Non sujet à la TVA",
      total: "Total",
      due-text: val =>
        [Merci de régler d’ici le *#val* par virement au compte bancaire suivant:],
      owner: "Titulaire",
      iban: "IBAN",
    ),
    de: (
      id: "de",
      country: "CH",
      recipient: "Empfänger",
      biller: "Aussteller",
      invoice: "Rechnung",
      cancellation-invoice: "Stornorechnung",
      cancellation-notice: (id, issuing-date) => [
        Vereinbarungsgemäß erhalten Sie hiermit eine Gutschrift
        zur Rechnung *#id* vom *#issuing-date*.
      ],
      invoice-id: "Rechnungsnummer",
      issuing-date: "Ausstellungsdatum",
      delivery-date: "Lieferdatum",
      items: "Leistungen",
      closing: "Vielen Dank für die gute Zusammenarbeit!",
      number: "Nr",
      date: "Datum",
      description: "Beschreibung",
      duration: "Dauer",
      quantity: "Menge",
      price: "Preis",
      total-time: "Gesamtarbeitszeit",
      subtotal: "Zwischensumme",
      discount-of: "Rabatt von",
      vat: "MwSt. von",
      no-vat: "Nicht Mehrwertsteuerpflichtig",
      total: "Gesamt",
      due-text: val =>
        [Bitte überweisen Sie den Betrag bis *#val* auf folgendes Konto:],
      owner: "Inhaber",
      iban: "IBAN",
    ),
  )

#let invoice(
  language: "en",
  currency: "CHF",
  country: none,
  title: none,
  banner-image: none,
  invoice-id: none,
  cancellation-id: none,
  issuing-date: none,
  delivery-date: none,
  due-date: none,
  biller: (:),
  recipient: (:),
  keywords: (),
  hourly-rate: none,
  styling: (:), // font, font-size, margin (sets defaults below)
  items: (),
  discount: none,
  vat: 0.081,
  vat-always: false, // Always charge VAT (even if reverse charge applies)
  data: none,
  override-translation: none,
  doc,
) = {
  // Set styling defaults
  styling.font = styling.at("font", default: "Liberation Sans")
  styling.font-size = styling.at("font-size", default: 10pt)
  styling.margin = styling.at("margin", default: (
    top: 20mm,
    right: 25mm,
    bottom: 20mm,
    left: 25mm,
  ))

  language = if data != none {
    data.at("language", default: language)
  } else { language }

  // Translations
  let t = if type(language) == str { languages.at(language) }
          else if type(language) == dictionary { language }
          else { panic("Language must be either a string or a dictionary.") }

  // override parts of translation, e.g. change word "Invoice" into "Quote"
  if override-translation != none {
    for k in t.keys() {
      if override-translation.at(k, default: none) != none {
        t.insert(k, override-translation.at(k))
      }
    }
  }

  if data != none {
    language = data.at("language", default: language)
    currency = data.at("currency", default: currency)
    country = data.at("country", default: t.country)
    title = data.at("title", default: title)
    banner-image = data.at("banner-image", default: banner-image)
    invoice-id = data.at("invoice-id", default: invoice-id)
    cancellation-id = data.at("cancellation-id", default: cancellation-id)
    issuing-date = data.at("issuing-date", default: issuing-date)
    delivery-date = data.at("delivery-date", default: delivery-date)
    due-date = data.at("due-date", default: due-date)
    biller = data.at("biller", default: biller)
    recipient = data.at("recipient", default: recipient)
    keywords = data.at("keywords", default: keywords)
    hourly-rate = data.at("hourly-rate", default: hourly-rate)
    styling = data.at("styling", default: styling)
    items = data.at("items", default: items)
    discount = data.at("discount", default: discount)
    vat = data.at("vat", default: vat)
  }

  // Verify inputs
  assert(
    verify-iban(country, biller.iban),
    message: "Invalid IBAN " + biller.iban + " for country " + country
  )

  let signature = ""
  let issuing-date = if issuing-date != none { issuing-date }
        else { datetime.today().display("[year]-[month]-[day]") }
  let issuing-date-display = if issuing-date != none and type(issuing-date) == str {
      format-date(issuing-date)
    } else { issuing-date }

  set document(
    title: title,
    keywords: keywords,
    date: parse-date(issuing-date),
  )
  set page(
    margin: styling.margin,
    numbering: none,
  )
  set text(
    lang: t.id,
    font: if styling.font == none { "libertinus serif" } else { styling.font },
    size: styling.font-size,
  )
  set table() // TODO: put back stroke: none


  text(weight: "bold", size: 2em)[
    #(if title != none { title } else {
      if cancellation-id != none { t.cancellation-invoice }
      else { t.invoice }
    })
  ]

  let invoice-id-norm = if invoice-id != none {
          if cancellation-id != none { cancellation-id }
          else { invoice-id }
        }
        else {
          datetime
            .today()
            .display("[year][month][day]")
        }

  let delivery-date = if delivery-date != none { delivery-date }
        else { TODO }
  let delivery-date-display = if delivery-date != none and type(delivery-date) == str {
      format-date(delivery-date)
    } else { delivery-date }

  table(
    columns: 2,
    align: (right, left),
    inset: 4pt,
    [#t.invoice-id:], [*#invoice-id-norm*],
    [#t.issuing-date:], [*#issuing-date-display*],
    [#t.delivery-date:], [*#delivery-date-display*],
  )

  v(2em)

  box(height: 12em)[
    #columns(2, gutter: 4em)[
      === #t.recipient
      #v(0.3em)
      #recipient.name \
      #{if "title" in recipient { [#recipient.title \ ] }}
      #{if "country" in recipient.address { [#recipient.address.country \ ] }}
      #recipient.address.city #recipient.address.postal-code \
      #recipient.address.street \

      === #t.biller
      #v(0.3em)
      #biller.name \
      #{if "title" in biller { [#biller.title \ ] }}
      #{if "country" in biller.address { [#biller.address.country \ ] }}
      #biller.address.city #biller.address.postal-code \
      #biller.address.street \
    ]
  ]

  if cancellation-id != none {
    (t.cancellation-notice)(invoice-id, issuing-date-display)
  }

  [== #t.items]

  v(1em)

  let getRowTotal = row => {
    if row.at("dur-min", default: 0) == 0 {
      row.price * row.at("quantity", default: 1)
    }
    else {
      calc.round(hourly-rate * (row.dur-min / 60), digits: 2)
    }
  }

  let cancel-neg = if cancellation-id != none { -1 } else { 1 }

  table(
    columns: (auto, auto, 1fr, auto, auto, auto, auto),
    align: (col, row) =>
        if row == 0 {
          (right,left,left,center,center,center,center,).at(col)
        }
        else {
          (right,left,left,right,right,right,right,).at(col)
        },
    inset: 6pt,
    table.header(
      // TODO: Add after https://github.com/typst/typst/issues/3734
      // align: (right,left,left,center,center,center,center,),
      table.hline(stroke: 0.5pt),
      [*#t.number*],
      [*#t.date*],
      [*#t.description*],
      [*#t.duration*\ #text(size: 0.8em)[( min )]],
      [*#t.quantity*],
      [*#t.price*\ #text(size: 0.8em)[( #currency )]],
      [*#t.total*\ #text(size: 0.8em)[( #currency )]],
      table.hline(stroke: 0.5pt),
    ),
    ..items
      .enumerate()
      .map(((index, row)) => {
        let dur-min = row.at("dur-min", default: 0)
        let dur-hour = dur-min / 60

        (
          row.at("number", default: index + 1),
          format-date(row.date),
          row.description,
          str(if dur-min == 0 { "" } else { dur-min }),
          str(row.at("quantity", default: if dur-min == 0 { "1" } else { "" })),
          str(add-zeros(cancel-neg *
           row.at("price", default: calc.round(hourly-rate * dur-hour, digits: 2))
          )),
          str(add-zeros(cancel-neg * getRowTotal(row))),
        )
      })
      .flatten()
      .map(str),
    table.hline(stroke: 0.5pt),
  )

  let sub-total = items
        .map(getRowTotal)
        .sum()

  let total-duration = items
        .map(row => int(row.at("dur-min", default: 0)))
        .sum()

  let discount-value = if discount == none { 0 }
    else {
      if (discount.type == "fixed") { discount.value }
      else if discount.type == "proportionate" {
        sub-total * discount.value
      }
      else { panic(["#discount.type" is no valid discount type]) }
    }
  let discount-label = if discount == none { 0 }
    else {
      if (discount.type == "fixed") { str(discount.value) + " " + currency }
      else if discount.type == "proportionate" {
        str(discount.value * 100) + " %"
      }
      else { panic(["#discount.type" is no valid discount type]) }
    }
  let tax =  sub-total * vat
  let total = sub-total - discount-value + tax

  let table-entries = (
    if total-duration != 0 {
      ([#t.total-time:], [*#total-duration min*])
    },
    if (discount-value != 0) or (vat != 0) {
      ([#t.subtotal:],
      [#{add-zeros(cancel-neg * sub-total)} #currency])
    },
    if discount-value != 0 {
      (
        [#t.discount-of #discount-label
          #{if discount.reason != "" { "(" + discount.reason + ")" }}],
        [-#add-zeros(cancel-neg * discount-value) #currency]
      )
    },
    if vat != 0 {
      ([#t.vat #{vat * 100} %:],
        [#{add-zeros(cancel-neg * tax)} #currency]
      )
    },
    if (vat == 0) {([#t.no-vat], [ ])},
    (
      [*#t.total*:],
      [*#add-zeros(cancel-neg * total) #currency*]
    ),
  )
  .filter(entry => entry != none)

  let grayish = luma(245)

  align(right,
    table(
      columns: 2,
      fill: (col, row) => // if last row
        if row == table-entries.len() - 1 { grayish }
        else { none },
      stroke: (col, row) => // if last row
        if row == table-entries.len() - 1 { (y: 0.5pt, x: 0pt) }
        else { none },
      ..table-entries
        .flatten(),
    )
  )

  v(1em)

  if cancellation-id == none {
    let due-date = if due-date != none { due-date }
          else {
            (parse-date(issuing-date) + duration(days: 14))
              .display("[year]-[month]-[day]")
          }

    (t.due-text)(format-date(due-date))

    v(1em)

    t.closing
  }
  else {
    v(1em)
    align(center, strong(t.closing))
  }
  doc // TODO put somewhere else maybe?
  context place(
    bottom,
    float: true,
    dy: page.margin.bottom,
    align(center,
      block(width: 100%,
        swiss-qr-bill(
          account: "CH4431999123000889012",
          creditor-name: "Max Muster & Söhne",
          creditor-street: "Musterstrasse",
          creditor-building: "123",
          creditor-postal-code: "8000",
          creditor-city: "Seldwyla",
          creditor-country: "CH",
          amount: 1949.75,
          currency: "CHF",
          debtor-name: "Simon Muster",
          debtor-street: "Musterstrasse",
          debtor-building: "1",
          debtor-postal-code: "8000",
          debtor-city: "Seldwyla",
          debtor-country: "CH",
          reference-type: "QRR",  // QRR, SCOR, or NON
          reference: "210000000003139471430009017",
          additional-info: "Bestellung vom 15.10.2020"
        )
      )
    )

  )


}
