# QR Meja V3.3

Setiap meja memiliki `qrToken` acak. QR di folder `qr/` dibuat dari:
`PUBLIC_BASE_URL/?table_token=<qrToken>`

Pelanggan membuka QR -> menu -> keranjang -> kirim order. Order masuk ke layar staff secara real-time.

Sebelum dicetak massal, isi `PUBLIC_BASE_URL` dengan domain produksi lalu buat ulang QR.
