# Invoice Maker

Generate simple, clean invoices with a (optional) swiss invoice QR code.

![Example Invoice](./template/main.pdf)

## Installation & Usage

#TODO

## Parameters

> The QR code section can be removed by not setting any qr_opts.

For all parameters regarding the QR code invoice, see the parameters [of the PayQR Swiss Typst package](https://github.com/philippdrebes/typst-payqr-swiss/tree/v0.4.1?tab=readme-ov-file#parameters).

## Acknowledgements

- [Adrian Sieber](https://github.com/ad-si) for creating [invoice-maker](https://github.com/ad-si/invoice-maker), from which this project is forked.
- [Philipp Drebes](https://github.com/philippdrebes) and all other contributors of [PayQR-Swiss](https://github.com/philippdrebes/typst-payqr-swiss), which is used for the QR part of the invoice.

## Development

Run Tests:

```sh
make test
```

## Required Fonts

- For the QR Code, the first found font in this list will be used: `Helvetica`, `Frutiger`, `Arial`, `Liberation Sans`.
