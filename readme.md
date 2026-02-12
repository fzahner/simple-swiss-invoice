# Invoice Maker

Generate invoices with a swiss QR code payment.

<a href="./fixtures/expected-en.pdf">
  <img
    alt="Example invoice"
    src="./images/example-invoice.png"
    height="768"
  >
</a>

## Installation & Usage

## Parameters

> The QR code section can be removed by not setting any qr_opts.

For all parameters regarding the QR code invoice, see the parameters [of the PayQR Swiss Typst package](https://github.com/philippdrebes/typst-payqr-swiss/tree/v0.4.1?tab=readme-ov-file#parameters).

## Development

Run Tests:

```sh
make test
```

## Legacy Version

Invoice Maker was originally implemented with TypeScript and Pandoc
as seen in [`./typescript_pandoc`](./typescript_pandoc).

This version is still in maintenance mode, but will not receive new features.
